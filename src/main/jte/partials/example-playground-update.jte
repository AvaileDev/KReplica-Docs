@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

@template.tags.playground(example = example)
@template.fragments.examples-sidebar-links(allExamples = allExamples, activeSlug = activeSlug, useOob = true)

<div hx-swap-oob="outerHTML:.examples-mobile-nav">
    <div class="examples-mobile-nav">
        <label for="example-select">Select an Example:</label>
        <select id="example-select"
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