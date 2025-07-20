@param io.availe.kreplicadocs.model.PlaygroundViewModel vm

@template.tags.playground(
example = vm.getExample(),
exampleSelectOptions = vm.getExampleSelectOptions(),
content = @`
    <div id="kreplica-editor"></div>
    <textarea name="source" hidden>${vm.getExample().getSourceCode()}</textarea>
    <button id="playground-submit"
            hx-post="/playground/compile"
            hx-trigger="click"
            hx-indicator="#primary-indicator"
            hx-target="#examples-main">
        Submit
    </button>
`
)