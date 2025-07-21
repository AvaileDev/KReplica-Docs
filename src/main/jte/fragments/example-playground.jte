@param io.availe.kreplicadocs.model.Example example
@param String activeFile = "source"

<div class="examples-shell"
     x-data="{ activeFile: '${activeFile}' }">
    <div class="playground-header">
        <h2>${example.getName()}</h2>
        <p>${example.getDescription()}</p>
    </div>
    <div class="playground-tabs-wrapper">
        <div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist">
            <button role="tab"
                    :class="activeFile === 'source' ? 'active' : ''"
                    @click="activeFile = 'source'"
                    hx-get="/examples/${example.getSlug()}/file-content/source"
                    hx-target="#playground-content-${example.getSlug()}"
                    hx-swap="innerHTML">
                Source
            </button>
            @for(var entry : example.getGeneratedFiles().entrySet())
                <button role="tab"
                        :class="activeFile === '${entry.getKey()}' ? 'active' : ''"
                        @click="activeFile = '${entry.getKey()}'"
                        hx-get="/examples/${example.getSlug()}/file-content/${entry.getKey()}"
                        hx-target="#playground-content-${example.getSlug()}"
                        hx-swap="innerHTML">
                    ${entry.getKey()}
                </button>
            @endfor
        </div>
    </div>
    <div class="playground-content" id="playground-content-${example.getSlug()}">
        <div class="htmx-indicator">Loading...</div>
        @template.tags.code(language="kotlin", content=@`${example.getSourceCode()}`)
    </div>
</div>