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

data class GuidesViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val allExamples: List<Example>,
    val guideSnippets: Map<String, String>
) : PageViewModel

data class PlaygroundViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val availableTemplates: List<SelectOption>,
    val initialSourceCode: String,
    val activeTemplateSlug: String
) : PageViewModel