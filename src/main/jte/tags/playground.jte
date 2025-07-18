@param io.availe.kreplicadocs.Example example

<div class="example-banner">
    <h2>${example.getName()}</h2>
    <p>{example.getDescription()}</p>
</div>

<div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist">
    <button role="tab"
            aria-selected="true"
            class="active"
            hx-get="/examples/${example.getSlug()}/file/source"
            hx-target="#playground-content-${example.getSlug()}"
            hx-swap="innerHTML">
        Source
    </button>
    @for(var entry : example.getGeneratedFiles().entrySet())
        <button role="tab"
                aria-selected="false"
                hx-get="/examples/${example.getSlug()}/file/${entry.getKey()}"
                hx-target="#playground-content-${example.getSlug()}"
                hx-swap="innerHTML">
            ${entry.getKey()}
        </button>
    @endfor
</div>

<div class="playground-content" id="playground-content-${example.getSlug()}">
    @template.tags.code(language="kotlin", content=@`
        ${example.getSourceCode()}
    `)
</div>