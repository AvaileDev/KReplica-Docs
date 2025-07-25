package io.availe.kreplicadocs.model.view

data class GuideSection(
    val id: String,
    val title: String,
    val subsections: List<GuideSubSection> = emptyList()
)

data class GuideSubSection(
    val id: String,
    val title: String
)