package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable

@Controller
class ExamplesController(private val provider: ExampleDataProvider) {

    @HxRequest
    @GetMapping("/examples/{slug}")
    fun getExamplePlayground(@PathVariable slug: String, model: Model): String {
        val example = provider.getExampleBySlug(slug)
        if (example != null) {
            model.addAttribute("example", example)
            return "tags/playground"
        }
        return "fragments/example-not-found"
    }

    @HxRequest
    @GetMapping("/examples/{slug}/generated/{fileName}")
    fun getGeneratedFile(
        @PathVariable slug: String,
        @PathVariable fileName: String,
        model: Model
    ): String {
        val example = provider.getExampleBySlug(slug)
        val code = example?.generatedFiles?.get(fileName)
        if (code != null) {
            model.addAttribute("language", "kotlin")
            model.addAttribute("content", code)
            return "tags/code"
        }
        return "fragments/example-not-found"
    }
}