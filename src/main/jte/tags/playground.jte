@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.SelectOption> exampleSelectOptions

@template.tags.playground-shell(
example = example,
exampleSelectOptions = exampleSelectOptions,
content = @`
    <div class="playground-tabs-wrapper">
        <div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist">
            @template.tags.tab-button(
            label = "Source",
            isActive = true,
            hxGet = "/examples/${example.getSlug()}/playground-file-swap/source",
            hxTarget = "#playground-content-${example.getSlug()}"
            )
            @for(var entry : example.getGeneratedFiles().entrySet())
                @template.tags.tab-button(
                label = entry.getKey(),
                isActive = false,
                hxGet = "/examples/${example.getSlug()}/playground-file-swap/${entry.getKey()}",
                hxTarget = "#playground-content-${example.getSlug()}"
                )
            @endfor
        </div>
    </div>

    <div class="playground-content" id="playground-content-${example.getSlug()}">
        <div class="htmx-indicator">Loading...</div>
        @template.tags.code(language="kotlin", content=@`${example.getSourceCode()}`)
    </div>
`
)