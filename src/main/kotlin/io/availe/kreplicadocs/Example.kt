package io.availe.kreplicadocs

data class Example(
    val name: String,
    val slug: String,
    val description: String,
    val sourceCode: String,
    val generatedFiles: Map<String, String>,
    val usageFiles: Map<String, String>
)