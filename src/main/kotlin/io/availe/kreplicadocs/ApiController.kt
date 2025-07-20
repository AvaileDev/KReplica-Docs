package io.availe.kreplicadocs

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ApiController {

    @GetMapping(WebApp.Endpoints.Api.COMPLETIONS)
    fun getCompletions(): List<CompletionItem> {
        return listOf(
            CompletionItem(label = "@Replicate.Model", insertText = "@Replicate.Model(", kind = "Keyword"),
            CompletionItem(label = "@Replicate.Property", insertText = "@Replicate.Property(", kind = "Keyword"),
            CompletionItem(
                label = "@Replicate.SchemaVersion",
                insertText = "@Replicate.SchemaVersion(",
                kind = "Keyword"
            ),
            CompletionItem(label = "@Replicate.Apply", insertText = "@Replicate.Apply(", kind = "Keyword"),
            CompletionItem(label = "@Replicate.Hide", insertText = "@Replicate.Hide", kind = "Keyword"),
            CompletionItem(label = "DtoVariant.DATA", insertText = "DtoVariant.DATA", kind = "EnumMember"),
            CompletionItem(label = "DtoVariant.CREATE", insertText = "DtoVariant.CREATE", kind = "EnumMember"),
            CompletionItem(label = "DtoVariant.PATCH", insertText = "DtoVariant.PATCH", kind = "EnumMember"),
            CompletionItem(label = "NominalTyping.ENABLED", insertText = "NominalTyping.ENABLED", kind = "EnumMember"),
            CompletionItem(
                label = "NominalTyping.DISABLED",
                insertText = "NominalTyping.DISABLED",
                kind = "EnumMember"
            ),
            CompletionItem(
                label = "AutoContextual.ENABLED",
                insertText = "AutoContextual.ENABLED",
                kind = "EnumMember"
            ),
            CompletionItem(
                label = "AutoContextual.DISABLED",
                insertText = "AutoContextual.DISABLED",
                kind = "EnumMember"
            ),
            CompletionItem(label = "Patchable.Unchanged", insertText = "Patchable.Unchanged", kind = "EnumMember"),
            CompletionItem(label = "Patchable.Set", insertText = "Patchable.Set(", kind = "Function"),
            CompletionItem(label = "KReplicaDataVariant", insertText = "KReplicaDataVariant", kind = "Interface"),
            CompletionItem(label = "KReplicaCreateVariant", insertText = "KReplicaCreateVariant", kind = "Interface"),
            CompletionItem(label = "KReplicaPatchVariant", insertText = "KReplicaPatchVariant", kind = "Interface")
        )
    }
}