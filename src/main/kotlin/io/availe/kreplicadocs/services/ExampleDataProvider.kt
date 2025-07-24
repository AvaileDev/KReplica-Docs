package io.availe.kreplicadocs.services

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import io.availe.kreplicadocs.model.*
import jakarta.annotation.PostConstruct
import org.springframework.core.io.Resource
import org.springframework.core.io.support.ResourcePatternResolver
import org.springframework.stereotype.Service
import java.io.FileNotFoundException

@Service
class ExampleDataProvider(
    private val resourcePatternResolver: ResourcePatternResolver,
    private val objectMapper: ObjectMapper,
) {

    private var featureTourExample: Example? = null
    private val playgroundTemplates = mutableListOf<PlaygroundTemplate>()
    private val guideSnippets = mutableMapOf<String, String>()
    private val navLinks = listOf(
        NavLink("/", "index", "Home"),
        NavLink("/playground", "playground", "Playground"),
        NavLink("/guide", "guide", "Guide")
    )

    private data class TourMetadata(
        val name: String,
        val description: String,
        val featureTourSteps: List<FeatureTourStep> = emptyList(),
        val featureTourPartTitles: Map<Int, String> = emptyMap()
    )

    @PostConstruct
    fun init() {
        loadFeatureTourExample()
        loadPlaygroundTemplates()
        guideSnippets.putAll(loadFilesFrom("guide-snippets/*.kt"))
        guideSnippets.putAll(loadFilesFrom("guide-snippets/*.kts"))
    }

    private fun loadFeatureTourExample() {
        val metadataResource = resourcePatternResolver.getResource("classpath:metadata/tour.json")
        if (!metadataResource.exists()) return

        val metadataMap: Map<String, TourMetadata> = metadataResource.inputStream.use {
            objectMapper.readValue(it, object : TypeReference<Map<String, TourMetadata>>() {})
        }

        metadataMap.entries.firstOrNull()?.let { (slug, metadata) ->
            featureTourExample = loadExample(ExampleSlug(slug), metadata)
        }
    }

    private fun loadPlaygroundTemplates() {
        val templatesResource = resourcePatternResolver.getResource("classpath:metadata/playground-templates.json")
        if (!templatesResource.exists()) return

        val templates: List<PlaygroundTemplate> = templatesResource.inputStream.use {
            objectMapper.readValue(it, object : TypeReference<List<PlaygroundTemplate>>() {})
        }
        playgroundTemplates.addAll(templates)
    }

    private fun loadFilesFrom(path: String): Map<String, String> {
        return resourcePatternResolver.getResources("classpath:$path")
            .filter(Resource::exists)
            .associate { resource ->
                val filename = resource.filename ?: "unknown"
                val content = resource.inputStream.bufferedReader().use { it.readText() }
                filename to content
            }
    }

    private fun loadExample(slug: ExampleSlug, metadata: TourMetadata): Example? {
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
            featureTourParts = metadata.featureTourSteps.groupBy { it.part },
            featureTourPartTitles = metadata.featureTourPartTitles
        )
    }

    fun getFeatureTourExample(): Example? = featureTourExample

    fun getAllExamples(): List<Example> = featureTourExample?.let { listOf(it) } ?: emptyList()

    fun getPlaygroundTemplates(): List<PlaygroundTemplate> = playgroundTemplates

    fun getPlaygroundTemplateSource(slug: String): String {
        val resource = resourcePatternResolver.getResource("classpath:playground-templates/$slug.kt")
        if (!resource.exists()) throw FileNotFoundException("Playground template not found: $slug")
        return resource.inputStream.bufferedReader().use { it.readText() }
    }

    fun getNavLinks(): List<NavLink> = navLinks

    fun getGuideSnippets(): Map<String, String> = guideSnippets
}