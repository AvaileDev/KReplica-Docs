package io.availe.kreplicadocs

import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import io.availe.kreplicadocs.WebApp.ViewModelAttributes as Attributes

@Controller
class ExamplesController(private val provider: ExampleDataProvider) {

    private fun withExample(slug: ExampleSlug, action: (Example) -> String): String {
        return provider.getExampleBySlug(slug)?.let(action) ?: FragmentTemplate.EXAMPLE_NOT_FOUND.path
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.PLAYGROUND)
    fun getExamplePlayground(@PathVariable slug: ExampleSlug, model: Model): String {
        return withExample(slug) { example ->
            model.addAttribute(Attributes.EXAMPLE, example)
            model.addAttribute(Attributes.ALL_EXAMPLES, provider.getAllExamples())
            model.addAttribute(Attributes.ACTIVE_SLUG, slug.value)
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
            model.addAttribute(Attributes.EXAMPLE, example)
            model.addAttribute(Attributes.ACTIVE_FILE, fileName.value)
            model.addAttribute(Attributes.LANGUAGE, "kotlin")
            model.addAttribute(Attributes.CODE, example.getContent(fileName) ?: "")
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
            model.addAttribute(Attributes.EXAMPLE, example)
            model.addAttribute(Attributes.ACTIVE_FILE, fileName.value)
            FragmentTemplate.GENERATED_PANEL_CONTENT.path
        }
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.FILE_CONTENT)
    fun getFileContent(@PathVariable slug: ExampleSlug, @PathVariable fileName: FileName, model: Model): String {
        return withExample(slug) { example ->
            model.addAttribute(Attributes.FEATURE_EXAMPLE, example.toViewModel())
            model.addAttribute(Attributes.ACTIVE_FILE, fileName.value)
            model.addAttribute(Attributes.LANGUAGE, "kotlin")
            model.addAttribute(Attributes.CODE, example.getContent(fileName) ?: "")
            FragmentTemplate.FEATURE_PLAYGROUND_SWAP.path
        }
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Examples.FILE_CONTENT_ONLY)
    fun getFileContentOnly(@PathVariable slug: ExampleSlug, @PathVariable fileName: FileName, model: Model): String {
        return withExample(slug) { example ->
            model.addAttribute(Attributes.LANGUAGE, "kotlin")
            model.addAttribute(Attributes.CODE, example.getContent(fileName) ?: "")
            FragmentTemplate.PLAYGROUND_FILE_CONTENT.path
        }
    }
}