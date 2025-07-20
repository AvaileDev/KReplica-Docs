package io.availe.kreplicadocs.model

import io.availe.kreplicadocs.config.AppProperties

interface PageViewModel {
    val navLinks: List<io.availe.kreplicadocs.model.NavLink>
    val properties: AppProperties
    val currentPage: String
}

data class IndexViewModel(
    override val navLinks: List<io.availe.kreplicadocs.model.NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val featureExample: ExampleViewModel?,
    val tourSelectOptions: List<SelectOption>
) : PageViewModel

data class GuidesViewModel(
    override val navLinks: List<io.availe.kreplicadocs.model.NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val allExamples: List<io.availe.kreplicadocs.model.Example>,
    val example: io.availe.kreplicadocs.model.Example?,
    val activeSlug: String?,
    val exampleSelectOptions: List<SelectOption>
) : PageViewModel

data class PlaygroundViewModel(
    override val navLinks: List<io.availe.kreplicadocs.model.NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val example: io.availe.kreplicadocs.model.Example,
    val exampleSelectOptions: List<SelectOption>
) : PageViewModel