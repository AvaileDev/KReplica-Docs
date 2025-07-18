@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param io.availe.kreplicadocs.Example example = null
@param String activeSlug = null

<div class="examples-container">
    <aside class="examples-sidebar">
        <h4>Examples</h4>
        @template.fragments.examples-sidebar-links(allExamples = allExamples, activeSlug = activeSlug)
    </aside>

    <div class="examples-main-content">
        <div class="examples-shell">
            <div class="examples-main" id="examples-main">
                @if(example != null)
                    @template.tags.playground(example = example, allExamples = allExamples, activeSlug = activeSlug)
                @else
                    <h1>Interactive Examples</h1>
                    <p>Select an example from the sidebar to see KReplica in action.</p>
                    <div id="primary-indicator" class="htmx-indicator">Loading...</div>
                @endif
            </div>
        </div>
    </div>
</div>

<div class="nav-footer">
    <a href="/why-kreplica"
       class="button-secondary"
       hx-get="/why-kreplica"
       hx-target=".main-content"
       hx-push-url="/why-kreplica"
       hx-indicator=".page-progress">&larr; Prev: Why KReplica?</a>
    <a href="/faq"
       class="button-secondary nav-item-next"
       hx-get="/faq"
       hx-target=".main-content"
       hx-push-url="/faq"
       hx-indicator=".page-progress">Next: FAQ &rarr;</a>
</div>