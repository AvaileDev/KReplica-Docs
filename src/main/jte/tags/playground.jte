@param io.availe.kreplicadocs.Example example

<div class="playground-intro">
    <h2>${example.getName()}</h2>
    <p>${example.getDescription()}</p>
</div>

<div class="playground-container">
    <div class="playground-panel source-panel">
        <div class="panel-tabs">
            <button class="active" type="button">Source</button>
        </div>
        @template.tags.code(language="kotlin", content=@`
            ${example.getSourceCode()}
        `)
    </div>
    <div class="playground-panel generated-panel" id="generated-panel-${example.getSlug()}">
        @template.fragments.generated-panel-content(
        example = example,
        activeFile = example.getGeneratedFiles().keySet().stream().findFirst().orElse(null)
        )
    </div>
</div>
