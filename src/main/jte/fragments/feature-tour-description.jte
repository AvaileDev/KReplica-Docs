@param io.availe.kreplicadocs.model.ExampleViewModel featureExample
@param String activeFile
@param boolean oob = false

<div id="feature-tour-description"
     hx-swap-oob="${oob ? "innerHTML" : null}">
    @for(var step : featureExample.getFeatureTourSteps())
        @if(step.getFileName().equals(activeFile))
            <p>${step.getDescription()}</p>
        @endif
    @endfor
</div>