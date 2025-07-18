@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param io.availe.kreplicadocs.Example example = null
@param String activeSlug = null

<div class="examples-layout">
    <aside class="examples-sidebar">
        <div class="sidebar-nav">
            <h3>Examples</h3>
            @template.fragments.examples-sidebar-links(allExamples = allExamples, activeSlug = activeSlug)
        </div>
    </aside>

    <div class="examples-main" id="examples-main">
        @if(example != null)
            @template.tags.playground(example = example)
        @else
            <h1>Interactive Examples</h1>
            <p>Select an example from the sidebar to see KReplica in action.</p>
            <p>The source interface is on the left; the generated code is on the right. You can switch between generated
                files using the tabs.</p>
            <div id="primary-indicator" class="htmx-indicator">Loading...</div>
        @endif
    </div>
</div>

<div class="nav-footer">
    <a href="/concepts"
       class="button-secondary"
       hx-get="/concepts"
       hx-target=".main-content"
       hx-push-url="/concepts"
       hx-indicator=".page-progress">&larr; Prev: Core Concepts</a>
    <a href="/faq"
       class="button-secondary"
       hx-get="/faq"
       hx-target=".main-content"
       hx-push-url="/faq"
       hx-indicator=".page-progress">Next: FAQ &rarr;</a>
</div>