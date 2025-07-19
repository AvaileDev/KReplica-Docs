package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.servlet.view.FragmentsRendering

@Controller
class PageController(private val provider: ExampleDataProvider) {

    private fun prepareGuidesModel(model: Model) {
        val all = provider.getAllExamples()
        model.addAttribute("allExamples", all)
        all.firstOrNull()?.let {
            model.addAttribute("example", it)
            model.addAttribute("activeSlug", it.slug)
        }
    }

    @HxRequest
    @GetMapping("/")
    fun indexHtmx(model: Model): FragmentsRendering {
        model.addAttribute("currentPage", "index")
        model.addAttribute("featureExample", provider.getExampleBySlug("user-profile"))
        return FragmentsRendering
            .with("partials/content-index")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/")
    fun index(model: Model): String {
        model.addAttribute("currentPage", "index")
        model.addAttribute("featureExample", provider.getExampleBySlug("user-profile"))
        return "pages/index"
    }

    @HxRequest
    @GetMapping("/guides")
    fun guidesHtmx(model: Model): FragmentsRendering {
        prepareGuidesModel(model)
        model.addAttribute("currentPage", "guides")
        return FragmentsRendering
            .with("partials/content-examples")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/guides")
    fun guides(model: Model): String {
        prepareGuidesModel(model)
        model.addAttribute("currentPage", "guides")
        return "pages/guides"
    }

    @GetMapping("/guides/{slug}")
    fun guideBySlug(@PathVariable slug: String, model: Model): String {
        model.addAttribute("allExamples", provider.getAllExamples())
        model.addAttribute("activeSlug", slug)
        model.addAttribute("example", provider.getExampleBySlug(slug))
        model.addAttribute("currentPage", "guides")
        return "pages/guides"
    }

    @HxRequest
    @GetMapping("/playground")
    fun playgroundHtmx(model: Model): FragmentsRendering {
        model.addAttribute("currentPage", "playground")
        return FragmentsRendering
            .with("partials/content-playground")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/playground")
    fun playground(model: Model): String {
        model.addAttribute("currentPage", "playground")
        return "pages/playground"
    }
}