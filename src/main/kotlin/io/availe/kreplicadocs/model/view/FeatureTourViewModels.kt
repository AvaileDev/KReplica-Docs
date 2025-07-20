package io.availe.kreplicadocs.model.view

import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.model.Example
import org.springframework.web.util.UriComponentsBuilder

data class ExampleViewModel(
    val slug: String,
    val sourceCode: String,
    val featureTourParts: List<FeatureTourPartViewModel>,
    val featureTourSteps: List<FeatureTourStepViewModel>
)

data class FeatureTourPartViewModel(
    val title: String,
    val steps: List<FeatureTourStepViewModel>
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

    val partsViewModel = stepViewModels.groupBy { it.part }
        .map { (partNumber, steps) ->
            val title = this.featureTourPartTitles.getOrDefault(partNumber, "Part $partNumber")
            FeatureTourPartViewModel(title, steps)
        }
        .sortedBy { it.steps.first().part }

    return ExampleViewModel(
        slug = this.slug,
        sourceCode = this.sourceCode,
        featureTourParts = partsViewModel,
        featureTourSteps = stepViewModels
    )
}