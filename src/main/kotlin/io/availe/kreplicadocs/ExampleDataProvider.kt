package io.availe.kreplicadocs

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.registerKotlinModule
import jakarta.annotation.PostConstruct
import org.springframework.core.io.support.ResourcePatternResolver
import org.springframework.stereotype.Service

@Service
class ExampleDataProvider(
    private val resourcePatternResolver: ResourcePatternResolver,
    private val objectMapper: ObjectMapper
) {

    private val examples = mutableListOf<Example>()

    private data class ExampleMetadata(val name: String, val description: String)

    @PostConstruct
    fun init() {
        objectMapper.registerKotlinModule()

        val metadataResource = resourcePatternResolver.getResource("classpath:examples.json")
        val metadataMap: Map<String, ExampleMetadata> = metadataResource.inputStream.use {
            objectMapper.readValue(it, object : TypeReference<Map<String, ExampleMetadata>>() {})
        }

        examples.addAll(
            metadataMap.mapNotNull { (slug, metadata) ->
                loadExample(slug, metadata)
            }
        )
    }

    private fun loadExample(slug: String, metadata: ExampleMetadata): Example? {
        val sourceResource = resourcePatternResolver.getResource("classpath:examples/$slug/Source.kt")
        if (!sourceResource.exists()) return null
        val sourceCode = sourceResource.inputStream.bufferedReader().use { it.readText() }

        val generatedFiles = resourcePatternResolver.getResources("classpath:examples/$slug/generated/*.kt")
            .filter { it.exists() }
            .associate {
                val filename = it.filename ?: "unknown.kt"
                val content = it.inputStream.bufferedReader().use { reader -> reader.readText() }
                filename to content
            }

        val usageFiles = resourcePatternResolver.getResources("classpath:examples/$slug/usage/*.kt")
            .filter { it.exists() }
            .associate {
                val filename = it.filename ?: "unknown.kt"
                val content = it.inputStream.bufferedReader().use { reader -> reader.readText() }
                filename to content
            }

        return Example(
            name = metadata.name,
            slug = slug,
            description = metadata.description,
            sourceCode = sourceCode,
            generatedFiles = generatedFiles,
            usageFiles = usageFiles
        )
    }

    fun getAllExamples(): List<Example> = examples

    fun getExampleBySlug(slug: String): Example? = examples.find { it.slug == slug }
}