@param io.availe.kreplicadocs.model.Example example
@param String activeFile = "source"

<div class="examples-shell">
    <div class="playground-header">
        <h2>${example.getName()}</h2>
        <p>${example.getDescription()}</p>
    </div>
    <div class="playground-tabs-wrapper">
        @template.fragments.playground-tabs(
        example = example,
        activeFile = activeFile,
        useOob = false
        )
    </div>
    <div class="playground-content" id="playground-content-${example.getSlug()}">
        <div class="htmx-indicator">Loading...</div>
        @template.tags.code(language="kotlin", content=@`${example.getSourceCode()}`)
    </div>
</div>