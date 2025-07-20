package io.availe.kreplicadocs

@JvmInline
value class ExampleSlug(val value: String)

@JvmInline
value class FileName(val value: String)

data class FeatureTourStep(
    val title: String,
    val description: String,
    val file: FileName,
    val endpoint: String,
    val part: Int,
)