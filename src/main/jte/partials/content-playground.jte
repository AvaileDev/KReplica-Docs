@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.SelectOption> exampleSelectOptions

<div class="playground-header">
    <h2>${example.getName()}</h2>
    <p>${example.getDescription()}</p>
</div>

<div class="playground-mobile-controls">
    @template.tags.custom-select(
    label = "Example:",
    id = "example-select-mobile",
    options = exampleSelectOptions,
    hxGet = "'/guides/' + this.value + '/playground'",
    hxTarget = "#examples-main",
    hxPushUrl = "'/guides/' + this.value",
    hxIndicator = "#primary-indicator"
    )
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