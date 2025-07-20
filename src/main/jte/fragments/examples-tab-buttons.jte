@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug
@param boolean useOob = false

<div class="examples-tablist" role="tablist" hx-swap-oob="${useOob ? "outerHTML" : null}">
    @for(var item : allExamples)
        @template.tags.tab-button(
        label = item.getName(),
        isActive = item.getSlug().equals(activeSlug),
        hxGet = "/examples/${item.getSlug()}/playground",
        hxTarget = "#examples-main",
        hxPushUrl = "/examples/${item.getSlug()}",
        hxIndicator = "#primary-indicator"
        )
    @endfor
</div>