package io.availe.kreplicadocs

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.annotation.PostConstruct
import org.springframework.core.io.Resource
import org.springframework.core.io.support.ResourcePatternResolver
import org.springframework.stereotype.Service
import org.springframework.web.util.UriComponentsBuilder

@Service
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

    private data class ExampleMetadata(val name: String, val description: String)

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

        val featureTourSteps = if (slug.value == "user-profile") {
            buildFeatureTourSteps(slug)
        } else {
            emptyList()
        }

        return Example(
            name = metadata.name,
            slug = slug.value,
            description = metadata.description,
            sourceCode = sourceCode,
            generatedFiles = loadFilesFrom("examples/${slug.value}/generated/*.kt"),
            usageFiles = loadFilesFrom("examples/${slug.value}/usage/*.kt"),
            featureTourSteps = featureTourSteps
        )
    }

    private fun buildFeatureTourSteps(slug: ExampleSlug): List<FeatureTourStep> {
        return listOf(
            FeatureTourStep(
                title = "1. Define Interface",
                description = "Everything starts with a simple Kotlin interface. No boilerplate or complex base classes required.",
                file = FileName("source"),
                endpoint = UriComponentsBuilder.fromPath(WebApp.Endpoints.Examples.FILE_CONTENT)
                    .buildAndExpand(mapOf("slug" to slug.value, "fileName" to "source"))
                    .toUriString(),
                part = 1
            ),
            FeatureTourStep(
                title = "2. Generate DTOs",
                description = "KReplica generates powerful, variant-aware DTOs, including a sealed hierarchy that enables advanced, type-safe patterns.",
                file = FileName("UserAccountSchema.kt"),
                endpoint = UriComponentsBuilder.fromPath(WebApp.Endpoints.Examples.FILE_CONTENT)
                    .buildAndExpand(mapOf("slug" to slug.value, "fileName" to "UserAccountSchema.kt"))
                    .toUriString(),
                part = 1
            ),
            FeatureTourStep(
                title = "3. Ensure Exhaustive Handling",
                description = "The generated sealed hierarchy enables exhaustive `when` expressions, forcing you to handle every version and variant at compile time. This eliminates entire classes of runtime errors as your API evolves.",
                file = FileName("WhenStatements.kt"),
                endpoint = UriComponentsBuilder.fromPath(WebApp.Endpoints.Examples.USAGE_CONTENT)
                    .buildAndExpand(mapOf("slug" to slug.value, "fileName" to "WhenStatements.kt"))
                    .toUriString(),
                part = 1
            ),
            FeatureTourStep(
                title = "4. The Generic Pattern",
                description = "Here is the key: KReplica generates global variant interfaces. You can use them to define a generic, reusable `ApiSchemaMapper` that is type-safe across all your models and versions.",
                file = FileName("ApiSchemaMapper.kt"),
                endpoint = UriComponentsBuilder.fromPath(WebApp.Endpoints.Examples.USAGE_CONTENT)
                    .buildAndExpand(mapOf("slug" to slug.value, "fileName" to "ApiSchemaMapper.kt"))
                    .toUriString(),
                part = 2
            ),
            FeatureTourStep(
                title = "5. The Implementation",
                description = "With the generic pattern in place, implementing a mapper for a specific schema version is clean, simple, and compile-time checked, cleanly decoupling your API layer from your domain models.",
                file = FileName("Mapper.kt"),
                endpoint = UriComponentsBuilder.fromPath(WebApp.Endpoints.Examples.USAGE_CONTENT)
                    .buildAndExpand(mapOf("slug" to slug.value, "fileName" to "Mapper.kt"))
                    .toUriString(),
                part = 2
            )
        )
    }

    fun getAllExamples(): List<Example> = examples
    fun getNavLinks(): List<NavLink> = navLinks
    fun getExampleBySlug(slug: ExampleSlug): Example? = examples.find { it.slug == slug.value }
}