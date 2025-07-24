package io.availe.kreplicadocs.model.view

import io.availe.kreplicadocs.common.WebApp
import io.availe.kreplicadocs.model.Example
import org.springframework.web.util.UriComponentsBuilder

data class FeatureTourSubStepViewModel(
    val title: String,
    val description: String,
    val fileName: String
)

data class FeatureTourStepViewModel(
    val title: String,
    val description: String,
    val part: Int,
    val fileName: String?,
    val endpoint: String,
    val subSteps: List<FeatureTourSubStepViewModel> = emptyList()
)

data class FeatureTourPartViewModel(
    val title: String,
    val steps: List<FeatureTourStepViewModel>
)

data class ExampleViewModel(
    val slug: String,
    val sourceCode: String,
    val featureTourParts: List<FeatureTourPartViewModel>,
    val featureTourSteps: List<FeatureTourStepViewModel>,
    private val allContent: Map<String, String>
) {
    fun getContent(fileName: String?): String? = fileName?.let(allContent::get)
}

fun Example.toViewModel(): ExampleViewModel {
    val content = buildMap<String, String> {
        put("source", sourceCode)
        generatedFiles.forEach { (k, v) -> put(k, v) }
        usageFiles.forEach { (k, v) -> put(k, v) }
    }

    val stepVMs = featureTourSteps.map { step ->
        val endpoint = step.file?.let { file ->
            UriComponentsBuilder.fromPath(WebApp.Endpoints.Examples.FILE_CONTENT)
                .buildAndExpand(mapOf("slug" to slug, "fileName" to file.value))
                .toUriString()
        } ?: ""

        val subVMs = step.subSteps.map {
            FeatureTourSubStepViewModel(
                title = it.title,
                description = it.description,
                fileName = it.file.value
            )
        }

        FeatureTourStepViewModel(
            title = step.title,
            description = step.description,
            part = step.part,
            fileName = step.file?.value,
            endpoint = endpoint,
            subSteps = subVMs
        )
    }

    val partsVM = stepVMs.groupBy { it.part }
        .map { (part, steps) ->
            val title = featureTourPartTitles.getOrDefault(part, "Part $part")
            FeatureTourPartViewModel(title, steps)
        }
        .sortedBy { it.steps.first().part }

    return ExampleViewModel(
        slug = slug,
        sourceCode = sourceCode,
        featureTourParts = partsVM,
        featureTourSteps = stepVMs,
        allContent = content
    )
}