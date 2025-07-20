@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.SelectOption> exampleSelectOptions

@template.tags.playground-shell(
example = example,
exampleSelectOptions = exampleSelectOptions,
content = @`
    <div id="kreplica-editor" style="height:400px;"></div>
    <textarea name="source" style="display:none">${example.getSourceCode()}</textarea>
    <button id="playground-submit"
            hx-post="/playground/compile"
            hx-trigger="click"
            hx-indicator="#primary-indicator"
            hx-target="#examples-main">
        Submit
    </button>
`
)