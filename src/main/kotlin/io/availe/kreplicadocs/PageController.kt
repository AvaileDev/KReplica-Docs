package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.servlet.view.FragmentsRendering

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