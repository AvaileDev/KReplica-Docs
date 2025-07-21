@param io.availe.kreplicadocs.model.Example example
@param String activeFile = "source"

<div class="examples-shell">
    <div class="playground-header">
        <h2>${example.getName()}</h2>
        <p>${example.getDescription()}</p>
    </div>
    <div class="playground-tabs-wrapper">
        <div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist">
            @template.tags.tab-button(
            label = "Source",
            isActive = "source".equals(activeFile),
            hxGet = "/examples/${example.getSlug()}/file-content/source",
            hxTarget = "#playground-content-${example.getSlug()}"
            )
            @for(var entry : example.getGeneratedFiles().entrySet())
                @template.tags.tab-button(
                label = entry.getKey(),
                isActive = entry.getKey().equals(activeFile),
                hxGet = "/examples/${example.getSlug()}/file-content/${entry.getKey()}",
                hxTarget = "#playground-content-${example.getSlug()}"
                )
            @endfor
        </div>
    </div>
    <div class="playground-content" id="playground-content-${example.getSlug()}">
        <div class="htmx-indicator">Loading...</div>
        @template.tags.code(language="kotlin", content=@`${example.getSourceCode()}`)
    </div>
</div>