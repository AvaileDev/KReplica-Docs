package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.servlet.view.FragmentsRendering

@Controller
class PageController(private val provider: ExampleDataProvider) {

    private fun prepareExamplesModel(model: Model) {
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
        return FragmentsRendering
            .with("partials/content-index")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/")
    fun index(model: Model): String {
        model.addAttribute("currentPage", "index")
        return "pages/index"
    }

    @HxRequest
    @GetMapping("/getting-started")
    fun gettingStartedHtmx(model: Model): FragmentsRendering {
        model.addAttribute("currentPage", "getting-started")
        return FragmentsRendering
            .with("partials/content-getting-started")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/getting-started")
    fun gettingStarted(model: Model): String {
        model.addAttribute("currentPage", "getting-started")
        return "pages/getting-started"
    }

    @HxRequest
    @GetMapping("/concepts")
    fun conceptsHtmx(model: Model): FragmentsRendering {
        model.addAttribute("currentPage", "concepts")
        return FragmentsRendering
            .with("partials/content-concepts")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/concepts")
    fun concepts(model: Model): String {
        model.addAttribute("currentPage", "concepts")
        return "pages/concepts"
    }

    @HxRequest
    @GetMapping("/examples")
    fun examplesHtmx(model: Model): FragmentsRendering {
        prepareExamplesModel(model)
        model.addAttribute("currentPage", "examples")
        return FragmentsRendering
            .with("partials/content-examples")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/examples")
    fun examples(model: Model): String {
        prepareExamplesModel(model)
        model.addAttribute("currentPage", "examples")
        return "pages/examples"
    }

    @GetMapping("/examples/{slug}")
    fun exampleBySlug(@PathVariable slug: String, model: Model): String {
        model.addAttribute("allExamples", provider.getAllExamples())
        model.addAttribute("activeSlug", slug)
        model.addAttribute("example", provider.getExampleBySlug(slug))
        model.addAttribute("currentPage", "examples")
        return "pages/examples"
    }

    @HxRequest
    @GetMapping("/faq")
    fun faqHtmx(model: Model): FragmentsRendering {
        model.addAttribute("currentPage", "faq")
        return FragmentsRendering
            .with("partials/content-faq")
            .fragment("fragments/nav-update-oob")
            .build()
    }

    @GetMapping("/faq")
    fun faq(model: Model): String {
        model.addAttribute("currentPage", "faq")
        return "pages/faq"
    }
}
