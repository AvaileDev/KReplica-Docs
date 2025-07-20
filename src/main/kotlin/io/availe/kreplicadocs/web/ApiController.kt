package io.availe.kreplicadocs.web

import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.model.CompletionItem
import io.availe.kreplicadocs.services.CompletionProviderService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ApiController(private val completionProvider: CompletionProviderService) {

    @GetMapping(WebApp.Endpoints.Api.COMPLETIONS)
    fun getCompletions(): List<CompletionItem> {
        return completionProvider.getCompletions()
    }
}