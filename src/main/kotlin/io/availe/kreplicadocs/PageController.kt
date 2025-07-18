package io.availe.kreplicadocs

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable

@Controller
class PageController(private val provider: ExampleDataProvider) {

    @GetMapping("/")
    fun index(): String {
        return "index"
    }

    @GetMapping("/getting-started")
    fun gettingStarted(): String {
        return "getting-started"
    }

    @GetMapping("/concepts")
    fun concepts(): String {
        return "concepts"
    }

    @GetMapping("/examples")
    fun examples(model: Model): String {
        model.addAttribute("allExamples", provider.getAllExamples())
        return "examples"
    }

    @GetMapping("/examples/{slug}")
    fun exampleBySlug(@PathVariable slug: String, model: Model): String {
        model.addAttribute("allExamples", provider.getAllExamples())
        model.addAttribute("example", provider.getExampleBySlug(slug))
        return "examples"
    }

    @GetMapping("/faq")
    fun faq(): String {
        return "faq"
    }
}