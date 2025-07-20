@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

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