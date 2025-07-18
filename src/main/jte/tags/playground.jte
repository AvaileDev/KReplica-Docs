@param io.availe.kreplicadocs.Example example

<div class="playground-intro">
    <h2>${example.getName()}</h2>
    <p>${example.getDescription()}</p>
</div>

<div
        class="playground-container"
        x-data="{
        activeTab: '${example.getGeneratedFiles().keySet().stream().findFirst().orElse("")}',
        init() {
            this.$watch('activeTab', () => {
                this.$nextTick(() => {
                    Prism.highlightAllUnder(this.$el);
                });
            });
        }
    }"
>
    <div class="playground-panel source-panel">
        <h3 class="panel-title">Source Interface</h3>
        @template.tags.code(language="kotlin", content=@`
            ${example.getSourceCode()}
        `)
    </div>
    <div class="playground-panel generated-panel">
        <div class="panel-tabs">
            @for (var entry : example.getGeneratedFiles().entrySet())
                <button
                        :class="{ 'active': activeTab === '${entry.getKey()}' }"
                        @click="activeTab = '${entry.getKey()}'"
                        hx-get="/examples/${example.getSlug()}/generated/${entry.getKey()}"
                        hx-target="#generated-code-viewer"
                        hx-swap="innerHTML"
                >
                    ${entry.getKey()}
                </button>
            @endfor
        </div>
        <div id="generated-code-viewer" class="panel-content">
            @template.tags.code(language="kotlin", content=@`
                ${example.getGeneratedFiles().values().stream().findFirst().orElse("")}
            `)
        </div>
    </div>
</div>
