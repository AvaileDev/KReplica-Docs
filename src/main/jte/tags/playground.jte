@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

<div class="playground-header">
    <h2>${example.getName()}</h2>
    <p>{example.getDescription()}</p>
</div>

<div class="playground-mobile-controls">
    <div class="custom-select-wrapper">
        <label for="example-select-mobile">Example:</label>
        <select id="example-select-mobile"
                hx-get="'/examples/' + this.value + '/playground'"
                hx-target="#examples-main"
                hx-push-url="'/examples/' + this.value"
                hx-indicator="#primary-indicator">
            @for(var item : allExamples)
                <option value="${item.getSlug()}" selected="${item.getSlug().equals(activeSlug)}">
                    ${item.getName()}
                </option>
            @endfor
        </select>
    </div>
</div>


<div class="playground-tabs-wrapper">
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
</div>

<div class="playground-content" id="playground-content-${example.getSlug()}">
    <div class="htmx-indicator">Loading...</div>
    @template.tags.code(language="kotlin", content=@`
        ${example.getSourceCode()}
    `)
</div>