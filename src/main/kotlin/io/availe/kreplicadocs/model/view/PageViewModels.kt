package io.availe.kreplicadocs.model.view

import io.availe.kreplicadocs.common.CodeSnippet
import io.availe.kreplicadocs.config.AppProperties
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
    val snippets: Map<CodeSnippet, String>
) : PageViewModel

data class GuideViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val snippets: Map<CodeSnippet, String>
) : PageViewModel

data class PlaygroundViewModel(
    override val navLinks: List<NavLink>,
    override val properties: AppProperties,
    override val currentPage: String,
    val availableTemplates: List<SelectOption>,
    val initialSourceCode: String,
    val activeTemplateSlug: String
) : PageViewModel