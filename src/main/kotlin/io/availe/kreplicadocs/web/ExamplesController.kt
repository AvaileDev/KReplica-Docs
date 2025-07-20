package io.availe.kreplicadocs.web

import io.availe.kreplicadocs.common.FragmentTemplate
import io.availe.kreplicadocs.common.PartialTemplate
import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.model.Example
import io.availe.kreplicadocs.model.ExampleSlug
import io.availe.kreplicadocs.model.FileName
import io.availe.kreplicadocs.model.toViewModel
import io.availe.kreplicadocs.services.ExampleDataProvider
import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable

@Controller
class ExamplesController(private val provider: ExampleDataProvider) {

    private fun withExample(slug: ExampleSlug, action: (Example) -> String): String {
        return provider.getExampleBySlug(slug)?.let(action) ?: FragmentTemplate.EXAMPLE_NOT_FOUND.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.PLAYGROUND)
    fun getExamplePlayground(@PathVariable slug: ExampleSlug, model: Model): String {
        return withExample(slug) { example ->
            model.addAttribute(WebApp.ViewModelAttributes.EXAMPLE, example)
            model.addAttribute(WebApp.ViewModelAttributes.ALL_EXAMPLES, provider.getAllExamples())
            model.addAttribute(WebApp.ViewModelAttributes.ACTIVE_SLUG, slug.value)
            PartialTemplate.EXAMPLE_PLAYGROUND_UPDATE.path
        }
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.PLAYGROUND_FILE_SWAP)
    fun getPlaygroundFileSwap(
        @PathVariable slug: ExampleSlug,
        @PathVariable fileName: FileName,
        model: Model
    ): String {
        return withExample(slug) { example ->
            model.addAttribute(WebApp.ViewModelAttributes.EXAMPLE, example)
            model.addAttribute(WebApp.ViewModelAttributes.ACTIVE_FILE, fileName.value)
            model.addAttribute(WebApp.ViewModelAttributes.LANGUAGE, "kotlin")
            model.addAttribute(WebApp.ViewModelAttributes.CODE, example.getContent(fileName) ?: "")
            FragmentTemplate.PLAYGROUND_FILE_SWAP.path
        }
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.GENERATED_PANEL)
    fun getGeneratedPanelContent(
        @PathVariable slug: ExampleSlug,
        @PathVariable fileName: FileName,
        model: Model
    ): String {
        return withExample(slug) { example ->
            model.addAttribute(WebApp.ViewModelAttributes.EXAMPLE, example)
            model.addAttribute(WebApp.ViewModelAttributes.ACTIVE_FILE, fileName.value)
            FragmentTemplate.GENERATED_PANEL_CONTENT.path
        }
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.FILE_CONTENT)
    fun getFileContent(@PathVariable slug: ExampleSlug, @PathVariable fileName: FileName, model: Model): String {
        return withExample(slug) { example ->
            model.addAttribute(WebApp.ViewModelAttributes.FEATURE_EXAMPLE, example.toViewModel())
            model.addAttribute(WebApp.ViewModelAttributes.ACTIVE_FILE, fileName.value)
            model.addAttribute(WebApp.ViewModelAttributes.LANGUAGE, "kotlin")
            model.addAttribute(WebApp.ViewModelAttributes.CODE, example.getContent(fileName) ?: "")
            FragmentTemplate.FEATURE_PLAYGROUND_SWAP.path
        }
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.FILE_CONTENT_ONLY)
    fun getFileContentOnly(@PathVariable slug: ExampleSlug, @PathVariable fileName: FileName, model: Model): String {
        return withExample(slug) { example ->
            model.addAttribute(WebApp.ViewModelAttributes.LANGUAGE, "kotlin")
            model.addAttribute(WebApp.ViewModelAttributes.CODE, example.getContent(fileName) ?: "")
            FragmentTemplate.PLAYGROUND_FILE_CONTENT.path
        }
    }
}