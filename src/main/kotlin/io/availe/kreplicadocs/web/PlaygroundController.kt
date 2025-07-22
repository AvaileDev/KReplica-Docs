package io.availe.kreplicadocs.web

import io.availe.kreplicadocs.common.FragmentTemplate
import io.availe.kreplicadocs.common.PartialTemplate
import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.services.ExampleDataProvider
import io.availe.kreplicadocs.services.ViewModelFactory
import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.ModelAttribute
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.view.FragmentsRendering

data class CompileRequest(val source: String)

@Controller
class PlaygroundController(
    private val viewModelFactory: ViewModelFactory,
    private val provider: ExampleDataProvider
) {

    @GetMapping("/playground")
    fun playground(model: Model): String {
        model.addAttribute("vm", viewModelFactory.createPlaygroundViewModel())
        return "pages/playground"
    }

    @HxRequest
    @GetMapping("/playground")
    fun playgroundHtmx(model: Model): FragmentsRendering {
        model.addAttribute("vm", viewModelFactory.createPlaygroundViewModel())
        return FragmentsRendering.with(PartialTemplate.CONTENT_PLAYGROUND.path)
            .fragment(FragmentTemplate.NAV_UPDATE_OOB.path)
            .build()
    }

    @HxRequest
    @GetMapping(WebApp.Endpoints.Playground.TEMPLATE_SWAP)
    fun getPlaygroundTemplate(@RequestParam("template-select") slug: String, model: Model): String {
        val sourceCode = provider.getPlaygroundTemplateSource(slug)
        model.addAttribute("code", sourceCode)
        model.addAttribute("slug", slug)
        return "fragments/playground-editor-swap"
    }

    @HxRequest
    @PostMapping(WebApp.Endpoints.Playground.COMPILE)
    fun compile(@ModelAttribute compileRequest: CompileRequest, model: Model): String {
        val generatedFiles = mapOf(
            "GeneratedFile1.kt" to "/*\n${compileRequest.source.lines().firstOrNull() ?: ""}\n...was processed\n*/",
            "Status" to "Compilation successful (simulated)."
        )
        model.addAttribute("files", generatedFiles)
        return "fragments/playground-results"
    }
}