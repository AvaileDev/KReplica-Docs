package io.availe.kreplicadocs.web

import io.availe.kreplicadocs.common.FragmentTemplate
import io.availe.kreplicadocs.common.PageTemplate
import io.availe.kreplicadocs.common.PartialTemplate
import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.services.ViewModelFactory
import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
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

    @GetMapping(WebApp.Endpoints.Pages.GUIDE)
    fun guide(model: Model): String {
        model.addAttribute("vm", viewModelFactory.createGuideViewModel())
        return PageTemplate.GUIDE.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Pages.GUIDE)
    fun guideHtmx(model: Model): FragmentsRendering {
        model.addAttribute("vm", viewModelFactory.createGuideViewModel())
        return FragmentsRendering
            .with(PartialTemplate.CONTENT_GUIDE.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }
}