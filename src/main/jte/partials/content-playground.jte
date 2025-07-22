@param io.availe.kreplicadocs.model.view.PlaygroundViewModel vm

<div class="playground-container">
    <div class="playground-controls">
        @template.tags.custom-select(
        label = "Starter Template:",
        id = "template-select",
        options = vm.getAvailableTemplates(),
        hxGet = "/playground/templates",
        hxTarget = "#editor-source-container",
        hxPushUrl = "false",
        hxIndicator = ".playground-actions .htmx-indicator",
        hxSwap = "innerHTML"
        )
    </div>

    <form class="playground-form"
          hx-post="/playground/compile"
          hx-target="#playground-output"
          hx-indicator=".playground-actions .htmx-indicator">

        <div class="playground-editor-area" data-template-slug="${vm.getActiveTemplateSlug()}">
            <div id="editor-source-container">
                <textarea name="source" hidden>${vm.getInitialSourceCode()}</textarea>
            </div>
            <div id="kreplica-editor"></div>
        </div>

        <div class="playground-actions">
            <div class="split-button-container">
                <div class="split-button-group">
                    <button type="submit" class="button-primary split-button-main">Run</button>
                </div>
            </div>

            <div class="split-button-container" x-data="{ isOpen: false }" @keydown.escape.window="isOpen = false">
                <div class="split-button-group">
                    <button type="button" id="reset-template-btn" class="button-primary split-button-main">Reset All
                    </button>
                    <button type="button" @click="isOpen = !isOpen" class="button-primary split-button-toggle"
                            aria-label="More actions">
                        <svg :class="{'rotate-180': isOpen}" class="split-button-icon"
                             xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 0 24 24" width="20px">
                            <path d="M7 10l5 5 5-5z" fill="currentColor"/>
                        </svg>
                    </button>
                </div>
                <div x-show="isOpen" @click.outside="isOpen = false" class="dropdown-menu" x-cloak>
                    <button type="button" id="clear-output-btn" class="dropdown-item">Clear Output</button>
                </div>
            </div>

            <div class="htmx-indicator">Compiling...</div>
        </div>
    </form>

    <div class="playground-output-area">
        <h3>Output</h3>
        <div id="playground-output">
            <div class="placeholder-text">Click "Run" to see the generated code.</div>
        </div>
    </div>
</div>
