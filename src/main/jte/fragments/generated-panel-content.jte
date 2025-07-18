@param io.availe.kreplicadocs.Example example
@param String activeFile

<div class="panel-tabs">
    @for (var entry : example.getGeneratedFiles().entrySet())
        <button
                class="${entry.getKey().equals(activeFile) ? "active" : ""}"
                hx-get="/examples/${example.getSlug()}/generated-panel/${entry.getKey()}"
                hx-target="#generated-panel-${example.getSlug()}"
                hx-swap="innerHTML"
        >
            ${entry.getKey()}
        </button>
    @endfor
</div>
<div class="panel-content">
    @if(activeFile != null)
        @template.tags.code(language="kotlin", content=@`
            ${example.getGeneratedFiles().get(activeFile)}
        `)
    @endif
</div>