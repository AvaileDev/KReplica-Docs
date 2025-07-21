package io.availe.kreplicadocs.services

import io.availe.kreplicadocs.config.AppProperties
import io.availe.kreplicadocs.model.ExampleSlug
import io.availe.kreplicadocs.model.view.*
import org.springframework.stereotype.Service

@Service
class ViewModelFactory(
    private val provider: ExampleDataProvider,
    private val appProperties: AppProperties,
) {

    fun createIndexViewModel(): IndexViewModel {
        val navLinks = provider.getNavLinks()
        val featureExample = provider.getFeatureTourExample()

        val exampleViewModel = featureExample?.toViewModel()
        val tourOptions = exampleViewModel?.featureTourSteps?.map { step ->
            SelectOption(
                step.endpoint,
                step.title,
                step.fileName == "source"
            )
        } ?: emptyList()

        return IndexViewModel(
            navLinks = navLinks,
            properties = appProperties,
            currentPage = "index",
            featureExample = exampleViewModel,
            tourSelectOptions = tourOptions
        )
    }

    fun createGuidesViewModel(activeSlug: ExampleSlug? = null): GuidesViewModel {
        val allExamples = provider.getAllExamples()
        val activeExample = activeSlug?.let { slug -> allExamples.find { it.slug == slug.value } }

        val exampleOptions = allExamples.map {
            SelectOption(
                value = it.slug,
                label = it.name,
                selected = it.slug == activeExample?.slug
            )
        }

        return GuidesViewModel(
            navLinks = provider.getNavLinks(),
            properties = appProperties,
            currentPage = "guides",
            allExamples = provider.getAllExamples(),
            guideSnippets = provider.getGuideSnippets(),
            example = activeExample,
            activeSlug = activeExample?.slug,
            exampleSelectOptions = exampleOptions
        )
    }

    fun createPlaygroundViewModel(): PlaygroundViewModel {
        val templates = provider.getPlaygroundTemplates()
        val activeTemplate = templates.firstOrNull()
            ?: throw IllegalStateException("No playground templates found")

        val initialSource = provider.getPlaygroundTemplateSource(activeTemplate.slug)
        val templateOptions = templates.map {
            SelectOption(
                value = it.slug,
                label = it.name,
                selected = it.slug == activeTemplate.slug
            )
        }

        return PlaygroundViewModel(
            navLinks = provider.getNavLinks(),
            properties = appProperties,
            currentPage = "playground",
            availableTemplates = templateOptions,
            initialSourceCode = initialSource,
            activeTemplateSlug = activeTemplate.slug
        )
    }
}