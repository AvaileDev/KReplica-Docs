package io.availe.kreplicadocs

data class ExampleViewModel(
    val slug: String,
    val sourceCode: String,
    val featureTourParts: Map<Int, List<FeatureTourStepViewModel>>,
    val featureTourSteps: List<FeatureTourStepViewModel>
)

data class FeatureTourStepViewModel(
    val title: String,
    val description: String,
    val part: Int,
    val endpoint: String,
    val fileName: String
)

fun Example.toViewModel(): ExampleViewModel {
    val stepViewModels = this.featureTourSteps.map { step ->
        FeatureTourStepViewModel(
            title = step.title,
            description = step.description,
            part = step.part,
            endpoint = step.endpoint,
            fileName = step.file.value
        )
    }
    return ExampleViewModel(
        slug = this.slug,
        sourceCode = this.sourceCode,
        featureTourParts = stepViewModels.groupBy { it.part },
        featureTourSteps = stepViewModels
    )
}