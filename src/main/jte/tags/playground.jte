@param boolean isFeatureTour = false
@param io.availe.kreplicadocs.model.Example example = null
@param java.util.List<io.availe.kreplicadocs.model.view.SelectOption> exampleSelectOptions = null
@param gg.jte.Content controls = null
@param gg.jte.Content content = null

@if(isFeatureTour)
    <div class="examples-shell feature-playground" id="feature-playground">
        <div class="feature-playground-controls">
            ${controls}
        </div>
        <div class="feature-playground-content-area">
            <div id="feature-playground-content-wrapper" class="playground-content-fixed-height">
                <div class="playground-content">
                    ${content}
                </div>
            </div>
        </div>
    </div>
@else
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

    @if(content == null)
        <div class="playground-tabs-wrapper">
            <div class="playground-tabs" id="playground-tabs-${example.getSlug()}" role="tablist">
                @template.tags.tab-button(
                label = "Source",
                isActive = true,
                hxGet = "/examples/${example.getSlug()}/playground-file-swap/source",
                hxTarget = "#playground-content-${example.getSlug()}"
                )
                @for(var entry : example.getGeneratedFiles().entrySet())
                    @template.tags.tab-button(
                    label = entry.getKey(),
                    isActive = false,
                    hxGet = "/examples/${example.getSlug()}/playground-file-swap/${entry.getKey()}",
                    hxTarget = "#playground-content-${example.getSlug()}"
                    )
                @endfor
            </div>
        </div>
        <div class="playground-content" id="playground-content-${example.getSlug()}">
            <div class="htmx-indicator">Loading...</div>
            @template.tags.code(language="kotlin", content=@`${example.getSourceCode()}`)
        </div>
    @else
        <div class="playground-content">
            ${content}
        </div>
    @endif
@endif