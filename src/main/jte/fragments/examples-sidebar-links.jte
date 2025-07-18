@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

<ul hx-swap-oob="true" id="examples-sidebar-links">
    @for(var item : allExamples)
        <li>
            <a class="${item.getSlug().equals(activeSlug) ? "active" : ""}"
               hx-get="/examples/${item.getSlug()}"
               hx-target="#examples-content"
               hx-push-url="/examples/${item.getSlug()}"
               hx-indicator="#primary-indicator">
                ${item.getName()}
            </a>
        </li>
    @endfor
</ul>