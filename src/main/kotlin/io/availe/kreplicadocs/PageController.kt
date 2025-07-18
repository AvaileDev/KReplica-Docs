package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable

@Controller
class PageController(private val provider: ExampleDataProvider) {

    private fun prepareExamplesModel(model: Model) {
        val allExamples = provider.getAllExamples()
        val firstExample = allExamples.firstOrNull()
        model.addAttribute("allExamples", allExamples)
        if (firstExample != null) {
            model.addAttribute("example", firstExample)
            model.addAttribute("activeSlug", firstExample.slug)
        }
    }

    @HxRequest
    @GetMapping("/")
    fun indexHtmx(): String {
        return "partials/content-index"
    }

    @GetMapping("/")
    fun index(): String {
        return "pages/index"
    }

    @HxRequest
    @GetMapping("/getting-started")
    fun gettingStartedHtmx(): String {
        return "partials/content-getting-started"
    }

    @GetMapping("/getting-started")
    fun gettingStarted(): String {
        return "pages/getting-started"
    }

    @HxRequest
    @GetMapping("/concepts")
    fun conceptsHtmx(): String {
        return "partials/content-concepts"
    }

    @GetMapping("/concepts")
    fun concepts(): String {
        return "pages/concepts"
    }

    @HxRequest
    @GetMapping("/examples")
    fun examplesHtmx(model: Model): String {
        prepareExamplesModel(model)
        return "partials/content-examples"
    }

    @GetMapping("/examples")
    fun examples(model: Model): String {
        prepareExamplesModel(model)
        return "pages/examples"
    }

    @GetMapping("/examples/{slug}")
    fun exampleBySlug(@PathVariable slug: String, model: Model): String {
        model.addAttribute("allExamples", provider.getAllExamples())
        model.addAttribute("activeSlug", slug)
        model.addAttribute("example", provider.getExampleBySlug(slug))
        return "pages/examples"
    }

    @HxRequest
    @GetMapping("/faq")
    fun faqHtmx(): String {
        return "partials/content-faq"
    }

    @GetMapping("/faq")
    fun faq(): String {
        return "pages/faq"
    }
}