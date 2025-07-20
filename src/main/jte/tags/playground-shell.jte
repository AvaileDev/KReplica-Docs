@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.SelectOption> exampleSelectOptions
@param gg.jte.Content content

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

${content}