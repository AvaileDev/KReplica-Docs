@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param io.availe.kreplicadocs.Example example = null

@template.layout.main(
title = "Examples | KReplica Docs",
currentPage = "examples",
content = @`
    <div class="examples-layout">
        <aside class="examples-sidebar">
            <div class="sidebar-nav">
                <h3>Examples</h3>
                <ul>
                    @for(var item : allExamples)
                        <li>
                            <a hx-get="/examples/${item.getSlug()}"
                               hx-target="#examples-content"
                               hx-push-url="/examples/${item.getSlug()}"
                               hx-indicator="#primary-indicator">
                                ${item.getName()}
                            </a>
                        </li>
                    @endfor
                </ul>
            </div>
        </aside>

        <div class="examples-main" id="examples-content">
            @if(example != null)
                @template.tags.playground(example = example)
            @else
                <h1>Interactive Examples</h1>
                <p>Select an example from the sidebar to see KReplica in action.</p>
                <p>The source interface is on the left; the generated code is on the right. You can switch between generated files using the tabs.</p>
                <div id="primary-indicator" class="htmx-indicator">Loading...</div>
            @endif
        </div>
    </div>
`
)