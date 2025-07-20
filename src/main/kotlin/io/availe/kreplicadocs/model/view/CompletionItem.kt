package io.availe.kreplicadocs.model.view

data class CompletionItem(
    val label: String,
    val insertText: String,
    val kind: String
)