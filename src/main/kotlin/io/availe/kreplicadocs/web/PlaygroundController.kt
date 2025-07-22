package io.availe.kreplicadocs.web

import io.availe.kreplicadocs.common.FragmentTemplate
import io.availe.kreplicadocs.common.PartialTemplate
import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.services.CompilationBrokerService
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
import java.util.concurrent.TimeUnit

data class CompileRequestForm(val source: String)

@Controller
class PlaygroundController(
    private val viewModelFactory: ViewModelFactory,
    private val provider: ExampleDataProvider,
    private val compilationBroker: CompilationBrokerService
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
    fun compile(@ModelAttribute compileRequest: CompileRequestForm, model: Model): String {
        try {
            val future = compilationBroker.submitJob(compileRequest.source)
            val response = future.get(15, TimeUnit.SECONDS)

            if (response.success) {
                model.addAttribute("files", response.generatedFiles)
                return "fragments/playground-results"
            } else {
                model.addAttribute("message", response.message)
                return "fragments/playground-error"
            }
        } catch (e: Exception) {
            model.addAttribute("message", "Error: ${e.message ?: "An unknown error occurred."}")
            return "fragments/playground-error"
        }
    }
}