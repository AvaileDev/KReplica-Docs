@param io.availe.kreplicadocs.PlaygroundViewModel vm

@template.tags.playground-shell(
example = vm.getExample(),
exampleSelectOptions = vm.getExampleSelectOptions(),
content = @`
    <div id="kreplica-editor" style="height:400px;"></div>
    <textarea name="source" style="display:none">${vm.getExample().getSourceCode()}</textarea>
    <button id="playground-submit"
            hx-post="/playground/compile"
            hx-trigger="click"
            hx-indicator="#primary-indicator"
            hx-target="#examples-main">
        Submit
    </button>
`
)