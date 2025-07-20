package io.availe.kreplicadocs

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ApiController {

    @GetMapping(WebApp.Endpoints.Api.COMPLETIONS)
    fun getCompletions(): List<Map<String, Any>> {
        return listOf(
            mapOf("label" to "@Replicate.Model", "insertText" to "@Replicate.Model(", "kind" to "Keyword"),
            mapOf("label" to "@Replicate.Property", "insertText" to "@Replicate.Property(", "kind" to "Keyword"),
            mapOf(
                "label" to "@Replicate.SchemaVersion",
                "insertText" to "@Replicate.SchemaVersion(",
                "kind" to "Keyword"
            ),
            mapOf("label" to "@Replicate.Apply", "insertText" to "@Replicate.Apply(", "kind" to "Keyword"),
            mapOf("label" to "@Replicate.Hide", "insertText" to "@Replicate.Hide", "kind" to "Keyword"),
            mapOf("label" to "DtoVariant.DATA", "insertText" to "DtoVariant.DATA", "kind" to "EnumMember"),
            mapOf("label" to "DtoVariant.CREATE", "insertText" to "DtoVariant.CREATE", "kind" to "EnumMember"),
            mapOf("label" to "DtoVariant.PATCH", "insertText" to "DtoVariant.PATCH", "kind" to "EnumMember"),
            mapOf("label" to "NominalTyping.ENABLED", "insertText" to "NominalTyping.ENABLED", "kind" to "EnumMember"),
            mapOf(
                "label" to "NominalTyping.DISABLED",
                "insertText" to "NominalTyping.DISABLED",
                "kind" to "EnumMember"
            ),
            mapOf(
                "label" to "AutoContextual.ENABLED",
                "insertText" to "AutoContextual.ENABLED",
                "kind" to "EnumMember"
            ),
            mapOf(
                "label" to "AutoContextual.DISABLED",
                "insertText" to "AutoContextual.DISABLED",
                "kind" to "EnumMember"
            ),
            mapOf("label" to "Patchable.Unchanged", "insertText" to "Patchable.Unchanged", "kind" to "EnumMember"),
            mapOf("label" to "Patchable.Set", "insertText" to "Patchable.Set(", "kind" to "Function"),
            mapOf("label" to "KReplicaDataVariant", "insertText" to "KReplicaDataVariant", "kind" to "Interface"),
            mapOf("label" to "KReplicaCreateVariant", "insertText" to "KReplicaCreateVariant", "kind" to "Interface"),
            mapOf("label" to "KReplicaPatchVariant", "insertText" to "KReplicaPatchVariant", "kind" to "Interface")
        )
    }
}