package io.availe.kreplicadocs.common

enum class PageTemplate(val path: String) {
    INDEX("pages/index"),
    GUIDES("pages/guides"),
    PLAYGROUND("pages/playground")
}

enum class PartialTemplate(val path: String) {
    CONTENT_INDEX("partials/content-index"),
    CONTENT_EXAMPLES("partials/content-examples"),
    CONTENT_PLAYGROUND("partials/content-playground"),
    EXAMPLE_PLAYGROUND_UPDATE("partials/example-playground-update")
}

enum class FragmentTemplate(val path: String) {
    NAV_UPDATE_OOB("fragments/nav-update-oob"),
    EXAMPLE_NOT_FOUND("fragments/example-not-found"),
    PLAYGROUND_FILE_SWAP("fragments/playground-file-swap"),
    GENERATED_PANEL_CONTENT("fragments/generated-panel-content"),
    FEATURE_PLAYGROUND_SWAP("fragments/feature-playground-swap"),
    PLAYGROUND_FILE_CONTENT("fragments/playground-file-content")
}