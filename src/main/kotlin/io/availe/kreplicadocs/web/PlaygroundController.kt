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
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.servlet.view.FragmentsRendering

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
    fun getPlaygroundTemplate(@PathVariable slug: String, model: Model): String {
        val sourceCode = provider.getPlaygroundTemplateSource(slug)
        model.addAttribute("code", sourceCode)
        return "fragments/playground-editor-swap"
    }

    @HxRequest
    @PostMapping(WebApp.Endpoints.Playground.COMPILE)
    fun compile(@RequestBody sourceCode: String, model: Model): String {
        // placeholder response
        val generatedFiles = mapOf(
            "GeneratedFile1.kt" to "/*\n${sourceCode.lines().firstOrNull() ?: ""}\n...was processed\n*/",
            "Status" to "Compilation successful (simulated)."
        )
        model.addAttribute("files", generatedFiles)
        return "fragments/playground-results"
    }
}