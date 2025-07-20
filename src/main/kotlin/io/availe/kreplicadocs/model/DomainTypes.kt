package io.availe.kreplicadocs.model

@JvmInline
value class ExampleSlug(val value: String)

@JvmInline
value class FileName(val value: String)

data class FeatureTourStep(
    val title: String,
    val description: String,
    val file: FileName,
    val part: Int,
    var endpoint: String = ""
)