package io.availe.kreplicadocs.common

import io.availe.kreplicadocs.model.ExampleSlug
import io.availe.kreplicadocs.services.ViewModelFactory
import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.servlet.view.FragmentsRendering

enum class PageTemplate(val path: String) {
    INDEX("pages/index"),
    GUIDES("pages/guides"),
    PLAYGROUND("pages/playground")
}

enum class PartialTemplate(val path: String) {
    CONTENT_INDEX("partials/content-index"),
    CONTENT_EXAMPLES("partials/content-examples"),
    CONTENT_PLAYGROUND("partials/content-playground"),
    EXAMPLE_PLAYGROUND_UPDATE("partials/example-playground-update")
}

enum class FragmentTemplate(val path: String) {
    NAV_UPDATE_OOB("fragments/nav-update-oob"),
    EXAMPLE_NOT_FOUND("fragments/example-not-found"),
    PLAYGROUND_FILE_SWAP("fragments/playground-file-swap"),
    GENERATED_PANEL_CONTENT("fragments/generated-panel-content"),
    FEATURE_PLAYGROUND_SWAP("fragments/feature-playground-swap"),
    PLAYGROUND_FILE_CONTENT("fragments/playground-file-content")
}

object WebApp {
    object Endpoints {
        object Pages {
            const val INDEX = "/"
            const val GUIDES = "/guides"
            const val GUIDES_BY_SLUG = "/guides/{slug}"
            const val PLAYGROUND = "/playground"
        }

        object Examples {
            private const val BASE = "/examples/{slug}"
            const val PLAYGROUND = "$BASE/playground"
            const val PLAYGROUND_FILE_SWAP = "$BASE/playground-file-swap/{fileName}"
            const val GENERATED_PANEL = "$BASE/generated-panel/{fileName}"
            const val FILE_CONTENT = "$BASE/file/{fileName}"
            const val FILE_CONTENT_ONLY = "$BASE/file-content/{fileName}"
        }

        object Api {
            const val COMPLETIONS = "/api/completions"
        }
    }

    object ViewModelAttributes {
        const val NAV_LINKS = "navLinks"
        const val CURRENT_PAGE = "currentPage"
        const val ALL_EXAMPLES = "allExamples"
        const val EXAMPLE = "example"
        const val FEATURE_EXAMPLE = "featureExample"
        const val ACTIVE_SLUG = "activeSlug"
        const val ACTIVE_FILE = "activeFile"
        const val LANGUAGE = "language"
        const val CODE = "code"
        const val PROPERTIES = "properties"
        const val TOUR_SELECT_OPTIONS = "tourSelectOptions"
        const val EXAMPLE_SELECT_OPTIONS = "exampleSelectOptions"
    }
}

@Controller
class PageController(private val viewModelFactory: ViewModelFactory) {

    @GetMapping(WebApp.Endpoints.Pages.INDEX)
    fun index(model: Model): String {
        model.addAttribute("vm", viewModelFactory.createIndexViewModel())
        return PageTemplate.INDEX.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.INDEX)
    fun indexHtmx(model: Model): FragmentsRendering {
        model.addAttribute("vm", viewModelFactory.createIndexViewModel())
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_INDEX.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }

    @GetMapping(WebApp.Endpoints.Pages.GUIDES)
    fun guides(model: Model): String {
        model.addAttribute("vm", viewModelFactory.createGuidesViewModel())
        return PageTemplate.GUIDES.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.GUIDES)
    fun guidesHtmx(model: Model): FragmentsRendering {
        model.addAttribute("vm", viewModelFactory.createGuidesViewModel())
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_EXAMPLES.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }

    @GetMapping(WebApp.Endpoints.Pages.GUIDES_BY_SLUG)
    fun guideBySlug(@PathVariable slug: ExampleSlug, model: Model): String {
        model.addAttribute("vm", viewModelFactory.createGuidesViewModel(slug))
        return PageTemplate.GUIDES.path
    }

    @GetMapping(WebApp.Endpoints.Pages.PLAYGROUND)
    fun playground(model: Model): String {
        model.addAttribute("vm", viewModelFactory.createPlaygroundViewModel())
        return PageTemplate.PLAYGROUND.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.PLAYGROUND)
    fun playgroundHtmx(model: Model): FragmentsRendering {
        model.addAttribute("vm", viewModelFactory.createPlaygroundViewModel())
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_PLAYGROUND.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }
}