package io.availe.kreplicadocs.services

import io.availe.kreplicadocs.config.AppProperties
import io.availe.kreplicadocs.model.view.GuideViewModel
import io.availe.kreplicadocs.model.view.IndexViewModel
import io.availe.kreplicadocs.model.view.PlaygroundViewModel
import io.availe.kreplicadocs.model.view.SelectOption
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
        return GuideViewModel(
            navLinks = snippetProvider.getNavLinks(),
            properties = appProperties,
            currentPage = "guide",
            snippets = snippetProvider.getSnippets()
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