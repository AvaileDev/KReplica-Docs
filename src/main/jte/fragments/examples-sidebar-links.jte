@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug
@param boolean useOob = false

<div id="examples-sidebar-links" hx-swap-oob="${useOob ? "outerHTML" : null}">
    <h4>Guide Sections</h4>
    <ul>
        <li><a href="#top" class="">Top</a></li>
        <li><a href="#api-reference" class="">API Reference</a></li>
        <li><a href="#generated-code" class="">Generated Code</a></li>
        <li><a href="#patterns" class="">Patterns & Recipes</a></li>
    </ul>

    <h4>Interactive Examples</h4>
    <ul>
        @for(var item : allExamples)
            <li>
                <a href="#interactive-examples"
                   class="${item.getSlug().equals(activeSlug) ? "active" : ""}"
                   hx-get="/examples/${item.getSlug()}/playground"
                   hx-target="#examples-main"
                   hx-indicator="#primary-indicator">
                    ${item.getName()}
                </a>
            </li>
        @endfor
    </ul>
</div>