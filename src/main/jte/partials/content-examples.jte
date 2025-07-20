@param io.availe.kreplicadocs.GuidesViewModel vm

<div class="examples-container">
    <aside class="examples-sidebar">
        @template.fragments.examples-sidebar-links(allExamples = vm.getAllExamples(), activeSlug = vm.getActiveSlug())
    </aside>

    <div class="examples-main-content">
        @template.partials.guide-content()

        <h2 id="interactive-examples"
            style="margin-top: 40px; border-top: 1px solid var(--border-color); padding-top: 40px;">
            Interactive Examples
        </h2>
        <p>Select an example from the sidebar to load an interactive playground below.</p>

        <div class="examples-shell">
            <div class="examples-main" id="examples-main">
                @if (vm.getExample() != null)
                    @template.tags.playground(example = vm.getExample(), exampleSelectOptions = vm.getExampleSelectOptions())
                @else
                    <div style="padding: 2rem; text-align: center; color: var(--text-light);">
                        <p>Select an example to get started.</p>
                        <div id="primary-indicator" class="htmx-indicator">Loading...</div>
                    </div>
                @endif
            </div>
        </div>

        <div class="technical-notes">
            <h3>Technical Notes & Best Practices</h3>

            <h4>Why use the <code>private</code> keyword on source interfaces?</h4>
            <p>The <code>private</code> keyword is not required. However, the KReplica source interfaces are only used
                by the
                processor and are not intended for direct use in application code. Using <code>private</code> prevents
                them from
                polluting the global namespace.</p>

            <h4>Does compilation order matter for nested models?</h4>
            <p>No. KReplica cleans the build folder at the start of each run to ensure no stale data. To handle nested
                models
                correctly, KReplica uses two-pass compilation. It first creates stub files of all
                <code>Replicate.Model</code>
                declarations and then deletes them after the main compilation to avoid redeclaration errors.</p>

            <h4>Can a <code>Replication.Property</code> be broader than its <code>Replication.Model</code>?</h4>
            <p>No. The replication of all children must be a subset of the parent (⊆), including for nested models.
                Otherwise,
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
    </div>
</div>