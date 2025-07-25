package io.availe.kreplicadocs.services

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import io.availe.kreplicadocs.common.CodeSnippet
import io.availe.kreplicadocs.model.NavLink
import io.availe.kreplicadocs.model.PlaygroundTemplate
import jakarta.annotation.PostConstruct
import org.slf4j.LoggerFactory
import org.springframework.core.io.support.ResourcePatternResolver
import org.springframework.stereotype.Service
import java.io.FileNotFoundException

@Service
class CodeSnippetProvider(
    private val resourcePatternResolver: ResourcePatternResolver,
    private val objectMapper: ObjectMapper,
) {
    private val log = LoggerFactory.getLogger(CodeSnippetProvider::class.java)
    private val snippets = mutableMapOf<CodeSnippet, String>()
    private val playgroundTemplates = mutableListOf<PlaygroundTemplate>()
    private val navLinks = listOf(
        NavLink("/", "index", "Home"),
        NavLink("/playground", "playground", "Playground"),
        NavLink("/guide", "guide", "Guide")
    )

    @PostConstruct
    fun init() {
        loadAllSnippets()
        loadPlaygroundTemplates()
    }

    private fun loadAllSnippets() {
        for (snippet in CodeSnippet.entries) {
            try {
                val resource = resourcePatternResolver.getResource("classpath:code-snippets/${snippet.path}")
                if (resource.exists()) {
                    snippets[snippet] = resource.inputStream.bufferedReader().use { it.readText() }
                } else {
                    log.warn("Code snippet not found and will be skipped: {}", snippet.path)
                    snippets[snippet] = "Error: Snippet not found at ${snippet.path}"
                }
            } catch (e: Exception) {
                log.error("Error loading code snippet: ${snippet.path}", e)
                snippets[snippet] = "Error loading snippet: ${e.message}"
            }
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

    fun getSnippets(): Map<CodeSnippet, String> = snippets

    fun getPlaygroundTemplates(): List<PlaygroundTemplate> = playgroundTemplates

    fun getPlaygroundTemplateSource(slug: String): String {
        val resource = resourcePatternResolver.getResource("classpath:playground-templates/$slug.kt")
        if (!resource.exists()) throw FileNotFoundException("Playground template not found: $slug")
        return resource.inputStream.bufferedReader().use { it.readText() }
    }

    fun getNavLinks(): List<NavLink> = navLinks
}