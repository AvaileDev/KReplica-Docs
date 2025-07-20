@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

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
<textarea name="source" style="display:none">${example.getSourceCode()}</textarea>
<button id="playground-submit"
        hx-post="/playground/compile"
        hx-trigger="click"
        hx-indicator="#primary-indicator"
        hx-target="#examples-main">
    Submit
</button>