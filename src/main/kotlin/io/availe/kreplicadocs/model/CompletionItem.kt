package io.availe.kreplicadocs.model

data class CompletionItem(
    val label: String,
    val insertText: String,
    val kind: String
)