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

<div class="technical-notes">
    <h3>Technical Notes & Best Practices</h3>

    <h4>Why use the <code>private</code> keyword on source interfaces?</h4>
    <p>The <code>private</code> keyword is not required. However, the KReplica source interfaces are only used by the
        processor and are not intended for direct use in application code. Using <code>private</code> prevents them from
        polluting the global namespace.</p>

    <h4>Does compilation order matter for nested models?</h4>
    <p>No. KReplica cleans the build folder at the start of each run to ensure no stale data. To handle nested models
        correctly, KReplica uses two-pass compilation. It first creates stub files of all <code>Replicate.Model</code>
        declarations and then deletes them after the main compilation to avoid redeclaration errors.</p>

    <h4>Can a <code>Replication.Property</code> be broader than its <code>Replication.Model</code>?</h4>
    <p>No. The replication of all children must be a subset of the parent (⊆), including for nested models. Otherwise,
        KReplica will fail the build and log the offending fields. This ensures fail-fast feedback.</p>
</div>

<div class="nav-footer">
    <a href="/"
       class="button-secondary"
       hx-get="/"
       hx-target=".main-content"
       hx-push-url="/"
       hx-indicator=".page-progress">&larr; Prev: Home</a>
</div>