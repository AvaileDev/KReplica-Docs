@param io.availe.kreplicadocs.Example example
@param String activeFile
@param boolean useOob = false

<div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist"
     hx-swap-oob="${useOob ? "outerHTML" : null}">
    <button role="tab"
            aria-selected="${"source".equals(activeFile)}"
            class="${"source".equals(activeFile) ? "active" : ""}"
            hx-get="/examples/${example.getSlug()}/playground-file-swap/source"
            hx-target="#playground-content-${example.getSlug()}"
            hx-swap="innerHTML">
        Source
    </button>
    @for(var entry : example.getGeneratedFiles().entrySet())
        <button role="tab"
                aria-selected="${entry.getKey().equals(activeFile)}"
                class="${entry.getKey().equals(activeFile) ? "active" : ""}"
                hx-get="/examples/${example.getSlug()}/playground-file-swap/${entry.getKey()}"
                hx-target="#playground-content-${example.getSlug()}"
                hx-swap="innerHTML">
            ${entry.getKey()}
        </button>
    @endfor
</div>
