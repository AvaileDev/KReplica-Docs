package io.availe.kreplicadocs

import io.availe.kreplicadocs.WebApp.Endpoints
import io.availe.kreplicadocs.WebApp.Templates
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
        model.addAttribute(Attributes.FEATURE_EXAMPLE, provider.getExampleBySlug(ExampleSlug("user-profile")))
    }

    private fun prepareGuidesModel(model: Model, slug: ExampleSlug? = null) {
        addCommonAttributes(model)
        val allExamples = provider.getAllExamples()
        val activeExample = slug?.let { provider.getExampleBySlug(it) } ?: allExamples.firstOrNull()

        model.addAttribute(Attributes.ALL_EXAMPLES, allExamples)
        model.addAttribute(Attributes.EXAMPLE, activeExample)
        model.addAttribute(Attributes.ACTIVE_SLUG, activeExample?.slug)
        model.addAttribute(Attributes.CURRENT_PAGE, "guides")
    }

    private fun preparePlaygroundModel(model: Model) {
        addCommonAttributes(model)
        val allExamples = provider.getAllExamples()
        val defaultExample = allExamples.firstOrNull()

        model.addAttribute(Attributes.ALL_EXAMPLES, allExamples)
        model.addAttribute(Attributes.EXAMPLE, defaultExample)
        model.addAttribute(Attributes.ACTIVE_SLUG, defaultExample?.slug)
        model.addAttribute(Attributes.CURRENT_PAGE, "playground")
    }

    @GetMapping(Endpoints.Pages.INDEX)
    fun index(model: Model): String {
        prepareIndexModel(model)
        return Templates.Pages.INDEX
    }

    @HxRequest
    @GetMapping(Endpoints.Pages.INDEX)
    fun indexHtmx(model: Model): FragmentsRendering {
        prepareIndexModel(model)
        return FragmentsRendering
            .with(Templates.Partials.CONTENT_INDEX)
            .fragment(Templates.Fragments.NAV_UPDATE_OOB)
            .build()
    }

    @GetMapping(Endpoints.Pages.GUIDES)
    fun guides(model: Model): String {
        prepareGuidesModel(model)
        return Templates.Pages.GUIDES
    }

    @HxRequest
    @GetMapping(Endpoints.Pages.GUIDES)
    fun guidesHtmx(model: Model): FragmentsRendering {
        prepareGuidesModel(model)
        return FragmentsRendering
            .with(Templates.Partials.CONTENT_EXAMPLES)
            .fragment(Templates.Fragments.NAV_UPDATE_OOB)
            .build()
    }

    @GetMapping(Endpoints.Pages.GUIDES_BY_SLUG)
    fun guideBySlug(@PathVariable slug: String, model: Model): String {
        prepareGuidesModel(model, ExampleSlug(slug))
        return Templates.Pages.GUIDES
    }

    @GetMapping(Endpoints.Pages.PLAYGROUND)
    fun playground(model: Model): String {
        preparePlaygroundModel(model)
        return Templates.Pages.PLAYGROUND
    }

    @HxRequest
    @GetMapping(Endpoints.Pages.PLAYGROUND)
    fun playgroundHtmx(model: Model): FragmentsRendering {
        preparePlaygroundModel(model)
        return FragmentsRendering
            .with(Templates.Partials.CONTENT_PLAYGROUND)
            .fragment(Templates.Fragments.NAV_UPDATE_OOB)
            .build()
    }
}