@param io.availe.kreplicadocs.model.Example example
@param String activeFile
@param boolean useOob = false

<div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist"
     hx-swap-oob="${useOob ? "outerHTML" : null}">
    @template.tags.tab-button(
    label = "Source",
    isActive = "source".equals(activeFile),
    hxGet = "/examples/${example.getSlug()}/playground-file-swap/source",
    hxTarget = "#playground-content-${example.getSlug()}"
    )
    @for(var entry : example.getGeneratedFiles().entrySet())
        @template.tags.tab-button(
        label = entry.getKey(),
        isActive = entry.getKey().equals(activeFile),
        hxGet = "/examples/${example.getSlug()}/playground-file-swap/${entry.getKey()}",
        hxTarget = "#playground-content-${example.getSlug()}"
        )
    @endfor
</div>