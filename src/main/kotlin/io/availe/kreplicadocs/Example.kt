package io.availe.kreplicadocs

data class Example(
    val name: String,
    val slug: String,
    val description: String,
    val sourceCode: String,
    val generatedFiles: Map<String, String>,
    val usageFiles: Map<String, String>,
    val featureTourSteps: List<FeatureTourStep> = emptyList(),
    val featureTourParts: Map<Int, List<FeatureTourStep>> = emptyMap()
) {
    fun getContent(fileName: FileName): String? {
        val key = fileName.value
        return when {
            key == "source" -> sourceCode
            generatedFiles.containsKey(key) -> generatedFiles[key]
            usageFiles.containsKey(key) -> usageFiles[key]
            else -> null
        }
    }
}