@param io.availe.kreplicadocs.model.view.GuidesViewModel vm

<div id="guide-sidebar-links">
    <h4>Guide Sections</h4>
    <ul>
        <li><a href="#top">Top</a></li>
        <li><a href="#api-reference">API Reference</a></li>
        <li><a href="#generated-code">Generated Code</a></li>
        <li><a href="#patterns">Patterns & Recipes</a></li>
        @for(var item : vm.getAllExamples())
            <li>
                <a href="/guides/${item.getSlug()}"
                   class="${item.getSlug().equals(vm.getActiveSlug()) ? "active" : ""}"
                   hx-get="/guides/${item.getSlug()}"
                   hx-target=".main-content"
                   hx-push-url="true"
                   hx-indicator=".page-progress">
                    ${item.getName()}
                </a>
            </li>
        @endfor
    </ul>
</div>