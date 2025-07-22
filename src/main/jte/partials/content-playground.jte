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
            <button type="submit" id="run-btn" class="button-run">Run</button>
            <button type="button" id="reset-template-btn" class="button-reset">Reset</button>
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
