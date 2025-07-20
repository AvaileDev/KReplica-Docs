package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.servlet.view.FragmentsRendering
import io.availe.kreplicadocs.WebApp.ViewModelAttributes as Attributes

@Controller
class PageController(
    private val provider: ExampleDataProvider,
    private val appProperties: AppProperties
) {

    private fun addCommonAttributes(model: Model) {
        model.addAttribute(Attributes.NAV_LINKS, provider.getNavLinks())
        model.addAttribute(Attributes.PROPERTIES, appProperties)
    }

    private fun prepareIndexModel(model: Model) {
        addCommonAttributes(model)
        model.addAttribute(Attributes.CURRENT_PAGE, "index")
        val featureExample = provider.getExampleBySlug(ExampleSlug("user-profile"))
        if (featureExample != null) {
            val viewModel = featureExample.toViewModel()
            model.addAttribute(Attributes.FEATURE_EXAMPLE, viewModel)
            val tourOptions = viewModel.featureTourSteps.map { step ->
                SelectOption(step.endpoint, step.title, step.fileName == "source")
            }
            model.addAttribute(Attributes.TOUR_SELECT_OPTIONS, tourOptions)
        } else {
            model.addAttribute(Attributes.FEATURE_EXAMPLE, null)
            model.addAttribute(Attributes.TOUR_SELECT_OPTIONS, emptyList<SelectOption>())
        }
    }

    private fun prepareExamplesPageModel(model: Model, pageId: String, activeSlug: ExampleSlug? = null) {
        addCommonAttributes(model)
        val allExamples = provider.getAllExamples()
        val activeExample = activeSlug?.let { provider.getExampleBySlug(it) } ?: allExamples.firstOrNull()
        val exampleOptions = allExamples.map {
            SelectOption(it.slug, it.name, it.slug == activeExample?.slug)
        }

        model.addAttribute(Attributes.ALL_EXAMPLES, allExamples)
        model.addAttribute(Attributes.EXAMPLE, activeExample)
        model.addAttribute(Attributes.ACTIVE_SLUG, activeExample?.slug)
        model.addAttribute(Attributes.EXAMPLE_SELECT_OPTIONS, exampleOptions)
        model.addAttribute(Attributes.CURRENT_PAGE, pageId)
    }

    private fun prepareGuidesModel(model: Model, slug: ExampleSlug? = null) {
        prepareExamplesPageModel(model, "guides", slug)
    }

    private fun preparePlaygroundModel(model: Model) {
        prepareExamplesPageModel(model, "playground")
    }

    @GetMapping(WebApp.Endpoints.Pages.INDEX)
    fun index(model: Model): String {
        prepareIndexModel(model)
        return PageTemplate.INDEX.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.INDEX)
    fun indexHtmx(model: Model): FragmentsRendering {
        prepareIndexModel(model)
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_INDEX.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }

    @GetMapping(WebApp.Endpoints.Pages.GUIDES)
    fun guides(model: Model): String {
        prepareGuidesModel(model)
        return PageTemplate.GUIDES.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.GUIDES)
    fun guidesHtmx(model: Model): FragmentsRendering {
        prepareGuidesModel(model)
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_EXAMPLES.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }

    @GetMapping(WebApp.Endpoints.Pages.GUIDES_BY_SLUG)
    fun guideBySlug(@PathVariable slug: ExampleSlug, model: Model): String {
        prepareGuidesModel(model, slug)
        return PageTemplate.GUIDES.path
    }

    @GetMapping(WebApp.Endpoints.Pages.PLAYGROUND)
    fun playground(model: Model): String {
        preparePlaygroundModel(model)
        return PageTemplate.PLAYGROUND.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.PLAYGROUND)
    fun playgroundHtmx(model: Model): FragmentsRendering {
        preparePlaygroundModel(model)
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_PLAYGROUND.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }
}