@param io.availe.kreplicadocs.model.view.GuidesViewModel vm

<div class="examples-container">
    <aside class="examples-sidebar">
        @template.fragments.guide-sidebar(vm = vm)
    </aside>
    <div class="guide-main-content">
        @template.partials.guide-content(snippets = vm.getGuideSnippets())

        <section id="interactive-examples">
            <h2 class="section-divider">
                Interactive Examples
            </h2>
            <p>Select an example from the sidebar to explore its implementation and generated code.</p>
        </section>

        <div id="examples-main">
            @if (vm.getExample() != null)
                @template.fragments.example-playground(example = vm.getExample(), activeFile = "source")
            @else
                <div class="placeholder-text">
                    <p>Select an example to get started.</p>
                </div>
            @endif
        </div>
    </div>
</div>