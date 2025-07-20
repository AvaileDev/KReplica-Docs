@param io.availe.kreplicadocs.ExampleViewModel featureExample
@param String activeFile
@param boolean oob = false

<div id="feature-playground-tabs" hx-swap-oob="${oob ? "outerHTML" : null}">
    @for(var entry : featureExample.getFeatureTourParts().entrySet())
        <div class="tour-part">
            <h3 class="tour-part-header">Part ${entry.getKey()}
                : ${entry.getKey() == 1 ? "Core Feature - Compile-Time Safety" : "Advanced Pattern - Type-Safe Mappers"}</h3>
            <div class="playground-tabs" role="tablist">
                @for(var step : entry.getValue())
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