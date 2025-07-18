package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable

@Controller
class ExamplesController(private val provider: ExampleDataProvider) {

    @HxRequest
    @GetMapping("/examples/{slug}/playground")
    fun getExamplePlayground(@PathVariable slug: String, model: Model): String {
        val example = provider.getExampleBySlug(slug)
        if (example != null) {
            model.addAttribute("example", example)
            model.addAttribute("allExamples", provider.getAllExamples())
            model.addAttribute("activeSlug", slug)
            return "partials/example-playground-update"
        }
        return "fragments/example-not-found"
    }

    @HxRequest
    @GetMapping("/examples/{slug}/generated-panel/{fileName}")
    fun getGeneratedPanelContent(
        @PathVariable slug: String,
        @PathVariable fileName: String,
        model: Model
    ): String {
        val example = provider.getExampleBySlug(slug)
        if (example != null) {
            model.addAttribute("example", example)
            model.addAttribute("activeFile", fileName)
            return "fragments/generated-panel-content"
        }
        return "fragments/example-not-found"
    }

    @HxRequest
    @GetMapping("/examples/{slug}/file/{fileName}")
    fun getFileContent(
        @PathVariable slug: String,
        @PathVariable fileName: String,
        model: Model
    ): String {
        val example = provider.getExampleBySlug(slug)
        if (example != null) {
            val code = if (fileName == "source") example.sourceCode else example.generatedFiles[fileName] ?: ""
            model.addAttribute("example", example)
            model.addAttribute("activeFile", fileName)
            model.addAttribute("language", "kotlin")
            model.addAttribute("code", code)
            return "fragments/playground-file-swap"
        }
        return "fragments/example-not-found"
    }

    @HxRequest
    @GetMapping("/examples/{slug}/file-content/{fileName}")
    fun getFileContentOnly(
        @PathVariable slug: String,
        @PathVariable fileName: String,
        model: Model
    ): String {
        val example = provider.getExampleBySlug(slug)
        if (example != null) {
            val code = if (fileName == "source") example.sourceCode else example.generatedFiles[fileName] ?: ""
            model.addAttribute("language", "kotlin")
            model.addAttribute("code", code)
            return "fragments/playground-file-content"
        }
        return "fragments/example-not-found"
    }
}