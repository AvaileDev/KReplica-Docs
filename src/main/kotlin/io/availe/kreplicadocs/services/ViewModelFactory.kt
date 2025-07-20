package io.availe.kreplicadocs.services

import io.availe.kreplicadocs.config.AppProperties
import io.availe.kreplicadocs.model.*
import org.springframework.stereotype.Service

@Service
class ViewModelFactory(
    private val provider: ExampleDataProvider,
    private val appProperties: AppProperties
) {

    fun createIndexViewModel(): IndexViewModel {
        val navLinks = provider.getNavLinks()
        val featureExample = provider.getExampleBySlug(ExampleSlug("user-profile"))

        val exampleViewModel = featureExample?.toViewModel()
        val tourOptions = exampleViewModel?.featureTourSteps?.map { step ->
            SelectOption(
                step.endpoint,
                step.title,
                step.fileName == "source"
            )
        } ?: emptyList()

        return _root_ide_package_.io.availe.kreplicadocs.model.IndexViewModel(
            navLinks = navLinks,
            properties = appProperties,
            currentPage = "index",
            featureExample = exampleViewModel,
            tourSelectOptions = tourOptions
        )
    }

    private fun createExamplesPageViewModel(
        pageId: String,
        activeSlug: ExampleSlug? = null
    ): GuidesViewModel {
        val allExamples = provider.getAllExamples()
        val activeExample = activeSlug?.let { provider.getExampleBySlug(it) } ?: allExamples.firstOrNull()
        val exampleOptions = allExamples.map {
            SelectOption(
                it.slug,
                it.name,
                it.slug == activeExample?.slug
            )
        }

        return _root_ide_package_.io.availe.kreplicadocs.model.GuidesViewModel(
            navLinks = provider.getNavLinks(),
            properties = appProperties,
            currentPage = pageId,
            allExamples = allExamples,
            example = activeExample,
            activeSlug = activeExample?.slug,
            exampleSelectOptions = exampleOptions
        )
    }

    fun createGuidesViewModel(slug: ExampleSlug? = null): GuidesViewModel {
        return createExamplesPageViewModel("guides", slug)
    }

    fun createPlaygroundViewModel(): PlaygroundViewModel {
        val examplesViewModel = createExamplesPageViewModel("playground")
        return _root_ide_package_.io.availe.kreplicadocs.model.PlaygroundViewModel(
            navLinks = examplesViewModel.navLinks,
            properties = examplesViewModel.properties,
            currentPage = "playground",
            example = examplesViewModel.example ?: throw IllegalStateException("No examples found for playground"),
            exampleSelectOptions = examplesViewModel.exampleSelectOptions
        )
    }
}