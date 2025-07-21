package io.availe.kreplicadocs.model.view

import io.availe.kreplicadocs.config.AppProperties
import io.availe.kreplicadocs.model.Example
import io.availe.kreplicadocs.model.NavLink

interface PageViewModel {
    val navLinks: List<NavLink>
    val properties: AppProperties
    val currentPage: String
}

data class IndexViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val featureExample: ExampleViewModel?,
    val tourSelectOptions: List<SelectOption>
) : PageViewModel

data class TocItem(
    val name: String,
    val href: String,
    val slug: String? = null
)

data class GuidesViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val allExamples: List<Example>,
    val guideSnippets: Map<String, String>,
    val example: Example?,
    val activeSlug: String?,
    val exampleSelectOptions: List<SelectOption>
) : PageViewModel {
    fun getGuideTocItems(): Map<TocItem, String> {
        val staticItems = listOf(
            TocItem("Top", "#top"),
            TocItem("API Reference", "#api-reference"),
            TocItem("Generated Code", "#generated-code"),
            TocItem("Patterns & Recipes", "#patterns")
        )

        val dynamicItems = allExamples.map {
            TocItem(it.name, "/guides/${it.slug}", it.slug)
        }

        return (staticItems + dynamicItems).associateWith { it.name }
    }
}

data class PlaygroundViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val availableTemplates: List<SelectOption>,
    val initialSourceCode: String,
    val activeTemplateSlug: String
) : PageViewModel