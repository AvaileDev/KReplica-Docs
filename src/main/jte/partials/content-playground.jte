@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug
@param String activeFile = "source"

<div class="playground-header">
    <h2>${example.getName()}</h2>
    <p>${example.getDescription()}</p>
</div>

<div class="playground-mobile-controls">
    <div class="custom-select-wrapper">
        <label for="example-select-mobile">Example:</label>
        <select id="example-select-mobile"
                hx-get="'/guides/' + this.value + '/playground'"
                hx-target="#examples-main"
                hx-push-url="'/guides/' + this.value"
                hx-indicator="#primary-indicator">
            @for(var item : allExamples)
                <option value="${item.getSlug()}" selected="${item.getSlug().equals(activeSlug)}">
                    ${item.getName()}
                </option>
            @endfor
        </select>
    </div>
</div>

<div id="kreplica-editor" style="height:400px;"></div>
<textarea name="source" style="display:none"></textarea>
<button id="playground-submit"
        hx-post="/playground/compile"
        hx-trigger="click"
        hx-indicator="#primary-indicator"
        hx-target="#examples-main">
    Submit
</button>

<div class="playground-tabs-wrapper">
    <div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist">
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
</div>

<div class="playground-content" id="playground-content-${example.getSlug()}">
    <div class="htmx-indicator">Loading...</div>
    @template.tags.code(language="kotlin", content=@`${"source".equals(activeFile) ? example.getSourceCode() : example.getGeneratedFiles().get(activeFile)}`)
</div>