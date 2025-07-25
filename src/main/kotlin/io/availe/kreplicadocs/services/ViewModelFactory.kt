package io.availe.kreplicadocs.services

import io.availe.kreplicadocs.config.AppProperties
import io.availe.kreplicadocs.model.view.*
import org.springframework.stereotype.Service

@Service
class ViewModelFactory(
    private val snippetProvider: CodeSnippetProvider,
    private val appProperties: AppProperties,
) {

    fun createIndexViewModel(): IndexViewModel {
        return IndexViewModel(
            navLinks = snippetProvider.getNavLinks(),
            properties = appProperties,
            currentPage = "index",
            snippets = snippetProvider.getSnippets()
        )
    }

    fun createGuideViewModel(): GuideViewModel {
        val guideNav = listOf(
            GuideSection(id = "top", title = "Top"),
            GuideSection(id = "quick-start", title = "Quick Start"),
            GuideSection(id = "core-concept", title = "The Core Concept"),
            GuideSection(
                id = "generated-code",
                title = "Understanding the Generated Code",
                subsections = listOf(
                    GuideSubSection(id = "generated-code-sealed", title = "Sealed Hierarchies"),
                    GuideSubSection(id = "generated-code-variants", title = "Local vs. Global Variants")
                )
            ),
            GuideSection(
                id = "api-reference",
                title = "Configuration API Reference",
                subsections = listOf(
                    GuideSubSection(id = "api-ref-replicate-model", title = "@Replicate.Model"),
                    GuideSubSection(id = "api-ref-replicate-property", title = "@Replicate.Property"),
                    GuideSubSection(id = "api-ref-supporting-annotations", title = "Supporting Annotations")
                )
            ),
            GuideSection(
                id = "patterns",
                title = "Core Patterns & Use Cases",
                subsections = listOf(
                    GuideSubSection(id = "patterns-schema-versioning", title = "Schema Versioning"),
                    GuideSubSection(id = "patterns-contextual-nesting", title = "Contextual Variant Nesting"),
                    GuideSubSection(id = "patterns-api-mappers", title = "Recipe: Type-Safe API Mappers"),
                    GuideSubSection(
                        id = "patterns-kotlinx-serialization",
                        title = "Integrating with kotlinx.serialization"
                    )
                )
            ),
            GuideSection(
                id = "faq",
                title = "Frequently Asked Questions",
                subsections = listOf(
                    GuideSubSection(id = "faq-property-scope", title = "Broader Property Replication?"),
                    GuideSubSection(id = "faq-compilation-order", title = "Compilation Order"),
                    GuideSubSection(id = "faq-private-keyword", title = "Use of `private` Keyword")
                )
            )
        )

        return GuideViewModel(
            navLinks = snippetProvider.getNavLinks(),
            properties = appProperties,
            currentPage = "guide",
            snippets = snippetProvider.getSnippets(),
            guideNav = guideNav
        )
    }

    fun createPlaygroundViewModel(): PlaygroundViewModel {
        val templates = snippetProvider.getPlaygroundTemplates()
        val activeTemplate = templates.firstOrNull()
            ?: throw IllegalStateException("No playground templates found")

        val initialSource = snippetProvider.getPlaygroundTemplateSource(activeTemplate.slug)
        val templateOptions = templates.map {
            SelectOption(
                value = it.slug,
                label = it.name,
                selected = it.slug == activeTemplate.slug
            )
        }

        return PlaygroundViewModel(
            navLinks = snippetProvider.getNavLinks(),
            properties = appProperties,
            currentPage = "playground",
            availableTemplates = templateOptions,
            initialSourceCode = initialSource,
            activeTemplateSlug = activeTemplate.slug
        )
    }
}