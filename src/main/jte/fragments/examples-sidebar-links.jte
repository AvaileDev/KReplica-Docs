@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

<ul id="examples-sidebar-links" hx-swap-oob="outerHTML">
    @for(var item : allExamples)
        <li>
            <a class="${item.getSlug().equals(activeSlug) ? "active" : ""}"
               hx-get="/examples/${item.getSlug()}/playground"
               hx-target="#examples-main"
               hx-push-url="/examples/${item.getSlug()}"
               hx-indicator="#primary-indicator">
                ${item.getName()}
            </a>
        </li>
    @endfor
</ul>