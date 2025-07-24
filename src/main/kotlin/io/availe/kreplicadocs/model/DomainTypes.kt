package io.availe.kreplicadocs.model

@JvmInline
value class ExampleSlug(val value: String)

@JvmInline
value class FileName(val value: String)

data class FeatureTourSubStep(
    val title: String,
    val description: String,
    val file: FileName
)

data class FeatureTourStep(
    val title: String,
    val description: String,
    val file: FileName?,
    val part: Int,
    var endpoint: String = "",
    val subSteps: List<FeatureTourSubStep> = emptyList()
)

data class PlaygroundTemplate(
    val slug: String,
    val name: String,
    val description: String
)