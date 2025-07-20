package io.availe.kreplicadocs

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ApiController(private val completionProvider: CompletionProviderService) {

    @GetMapping(WebApp.Endpoints.Api.COMPLETIONS)
    fun getCompletions(): List<CompletionItem> {
        return completionProvider.getCompletions()
    }
}