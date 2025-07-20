package io.availe.kreplicadocs

import org.springframework.web.util.UriComponentsBuilder

data class CompletionItem(
    val label: String,
    val insertText: String,
    val kind: String
)

data class SelectOption(
    val value: String,
    val label: String,
    val selected: Boolean
)

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
        val endpointTemplate = WebApp.Endpoints.Examples.FILE_CONTENT
        val endpoint = UriComponentsBuilder.fromPath(endpointTemplate)
            .buildAndExpand(mapOf("slug" to this.slug, "fileName" to step.file.value))
            .toUriString()

        FeatureTourStepViewModel(
            title = step.title,
            description = step.description,
            part = step.part,
            endpoint = endpoint,
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