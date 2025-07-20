package io.availe.kreplicadocs

object WebApp {
    object Endpoints {
        object Pages {
            const val INDEX = "/"
            const val GUIDES = "/guides"
            const val GUIDES_BY_SLUG = "/guides/{slug}"
            const val PLAYGROUND = "/playground"
        }

        object Examples {
            private const val BASE = "/examples/{slug}"
            const val PLAYGROUND = "$BASE/playground"
            const val PLAYGROUND_FILE_SWAP = "$BASE/playground-file-swap/{fileName}"
            const val GENERATED_PANEL = "$BASE/generated-panel/{fileName}"
            const val FILE_CONTENT = "$BASE/file/{fileName}"
            const val USAGE_CONTENT = "$BASE/usage/{fileName}"
            const val FILE_CONTENT_ONLY = "$BASE/file-content/{fileName}"
        }
    }

    object Templates {
        object Pages {
            const val INDEX = "pages/index"
            const val GUIDES = "pages/guides"
            const val PLAYGROUND = "pages/playground"
        }

        object Partials {
            const val CONTENT_INDEX = "partials/content-index"
            const val CONTENT_EXAMPLES = "partials/content-examples"
            const val CONTENT_PLAYGROUND = "partials/content-playground"
            const val EXAMPLE_PLAYGROUND_UPDATE = "partials/example-playground-update"
        }

        object Fragments {
            const val NAV_UPDATE_OOB = "fragments/nav-update-oob"
            const val EXAMPLE_NOT_FOUND = "fragments/example-not-found"
            const val PLAYGROUND_FILE_SWAP = "fragments/playground-file-swap"
            const val GENERATED_PANEL_CONTENT = "fragments/generated-panel-content"
            const val FEATURE_PLAYGROUND_SWAP = "fragments/feature-playground-swap"
            const val PLAYGROUND_FILE_CONTENT = "fragments/playground-file-content"
        }
    }

    object ViewModelAttributes {
        const val CURRENT_PAGE = "currentPage"
        const val ALL_EXAMPLES = "allExamples"
        const val EXAMPLE = "example"
        const val FEATURE_EXAMPLE = "featureExample"
        const val ACTIVE_SLUG = "activeSlug"
        const val ACTIVE_FILE = "activeFile"
        const val LANGUAGE = "language"
        const val CODE = "code"
    }
}