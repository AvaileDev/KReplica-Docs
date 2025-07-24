@param io.availe.kreplicadocs.model.view.GuideViewModel vm

<div id="guide-sidebar-links">
    <h4>Guide Sections</h4>
    <ul>
        <li><a href="#top">Top</a></li>
        <li><a href="#quick-start">Quick Start</a></li>
        <li><a href="#core-concept">Core Concept</a></li>
        <li><a href="#generated-code">Generated Code</a></li>
        <li><a href="#api-reference">API Reference</a></li>
        <li><a href="#patterns">Core Patterns</a></li>
        <li><a href="#faq">FAQ</a></li>
    </ul>
    <h4>Interactive Examples</h4>
    <ul>
        @for(var item : vm.getAllExamples())
            <li>
                <a href="/guide/${item.getSlug()}"
                   class="${item.getSlug().equals(vm.getActiveSlug()) ? "active" : ""}"
                   hx-get="/guide/${item.getSlug()}"
                   hx-target=".main-content"
                   hx-push-url="true"
                   hx-indicator=".page-progress">
                    ${item.getName()}
                </a>
            </li>
        @endfor
    </ul>
</div>