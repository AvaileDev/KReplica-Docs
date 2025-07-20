@param io.availe.kreplicadocs.model.ExampleViewModel featureExample
@param String activeFile
@param boolean oob = false

<div id="feature-playground-tabs" hx-swap-oob="${oob ? "outerHTML" : null}">
    @for(var part : featureExample.getFeatureTourParts())
        <div class="tour-part">
            <h3 class="tour-part-header">${part.getTitle()}</h3>
            <div class="playground-tabs" role="tablist">
                @for(var step : part.getSteps())
                    @template.tags.tab-button(
                    label = step.getTitle(),
                    isActive = step.getFileName().equals(activeFile),
                    hxGet = step.getEndpoint(),
                    hxTarget = "#feature-playground-content-wrapper .playground-content"
                    )
                @endfor
            </div>
        </div>
    @endfor
</div>