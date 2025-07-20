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
    val example: Example?,
    val activeSlug: String?,
    val exampleSelectOptions: List<SelectOption>
) : PageViewModel

data class PlaygroundViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val example: Example,
    val exampleSelectOptions: List<SelectOption>
) : PageViewModel