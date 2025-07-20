package io.availe.kreplicadocs.services

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import io.availe.kreplicadocs.config.AppProperties
import io.availe.kreplicadocs.model.Example
import io.availe.kreplicadocs.model.ExampleSlug
import io.availe.kreplicadocs.model.FeatureTourStep
import io.availe.kreplicadocs.model.NavLink
import jakarta.annotation.PostConstruct
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.core.io.Resource
import org.springframework.core.io.support.ResourcePatternResolver
import org.springframework.stereotype.Service

@Service
@EnableConfigurationProperties(AppProperties::class)
class ExampleDataProvider(
    private val resourcePatternResolver: ResourcePatternResolver,
    private val objectMapper: ObjectMapper
) {

    private val examples = mutableListOf<Example>()
    private val navLinks = listOf(
        NavLink("/", "index", "Home"),
        NavLink("/playground", "playground", "Playground"),
        NavLink("/guides", "guides", "Guides")
    )

    private data class ExampleMetadata(
        val name: String,
        val description: String,
        val featureTourSteps: List<FeatureTourStep> = emptyList()
    )

    @PostConstruct
    fun init() {
        val metadataResource = resourcePatternResolver.getResource("classpath:examples.json")
        val metadataMap: Map<String, ExampleMetadata> = metadataResource.inputStream.use {
            objectMapper.readValue(it, object : TypeReference<Map<String, ExampleMetadata>>() {})
        }

        examples.addAll(
            metadataMap.mapNotNull { (slug, metadata) ->
                loadExample(ExampleSlug(slug), metadata)
            }
        )
    }

    private fun loadFilesFrom(path: String): Map<String, String> {
        return resourcePatternResolver.getResources("classpath:$path")
            .filter(Resource::exists)
            .associate { resource ->
                val filename = resource.filename ?: "unknown.kt"
                val content = resource.inputStream.bufferedReader().use { it.readText() }
                filename to content
            }
    }

    private fun loadExample(slug: ExampleSlug, metadata: ExampleMetadata): Example? {
        val sourceResource = resourcePatternResolver.getResource("classpath:examples/${slug.value}/Source.kt")
        if (!sourceResource.exists()) return null
        val sourceCode = sourceResource.inputStream.bufferedReader().use { it.readText() }

        return Example(
            name = metadata.name,
            slug = slug.value,
            description = metadata.description,
            sourceCode = sourceCode,
            generatedFiles = loadFilesFrom("examples/${slug.value}/generated/*.kt"),
            usageFiles = loadFilesFrom("examples/${slug.value}/usage/*.kt"),
            featureTourSteps = metadata.featureTourSteps,
            featureTourParts = metadata.featureTourSteps.groupBy { it.part }
        )
    }

    fun getAllExamples(): List<Example> = examples
    fun getNavLinks(): List<NavLink> = navLinks
    fun getExampleBySlug(slug: ExampleSlug): Example? =
        examples.find { it.slug == slug.value }
}