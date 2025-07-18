@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug
@param boolean useOob = false

<div class="examples-tablist" role="tablist" hx-swap-oob="${useOob ? "outerHTML" : null}">
    @for(var item : allExamples)
        <button role="tab"
                aria-selected="${item.getSlug().equals(activeSlug)}"
                class="${item.getSlug().equals(activeSlug) ? "active" : ""}"
                hx-get="/examples/${item.getSlug()}/playground"
                hx-target="#examples-main"
                hx-push-url="/examples/${item.getSlug()}"
                hx-indicator="#primary-indicator">
            ${item.getName()}
        </button>
    @endfor
</div>
