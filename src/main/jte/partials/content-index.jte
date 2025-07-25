@import io.availe.kreplicadocs.common.CodeSnippet
@param io.availe.kreplicadocs.model.view.IndexViewModel vm

<div class="hero-section">
    <h1>DTO generation for Kotlin CRUD APIs</h1>
    <p>KReplica generates Kotlin code from interfaces, with explicit control over Create, Data, and Patch variants.</p>
</div>

<h2>Get Started in 60 Seconds</h2>
<p>Add the KSP and KReplica plugins to your module's <code>build.gradle.kts</code> file to start generating DTOs
    automatically.</p>

@template.tags.code(language = "kotlin", content = @`${vm.getSnippets().get(CodeSnippet.QUICKSTART_BUILD)}`)

<div class="feature-highlight">
    <h2>Bulletproof Your APIs</h2>
    <p>KReplica uses sealed hierarchies to enable exhaustive <code>when</code> expressions. If you add a new API
        version, your code won't compile until you handle it—no more runtime surprises.</p>

    <div class="workflow-container" x-data="{ activeTab: 'all' }">
        <div class="workflow-tabs" role="tablist">
            <button role="tab" :class="{ 'active': activeTab === 'all' }" @click="activeTab = 'all'">Handle Everything
            </button>
            <button role="tab" :class="{ 'active': activeTab === 'version' }" @click="activeTab = 'version'">Handle by
                Version
            </button>
            <button role="tab" :class="{ 'active': activeTab === 'variant' }" @click="activeTab = 'variant'">Handle by
                Variant
            </button>
        </div>
        <div class="workflow-content" x-show="activeTab === 'all'" x-cloak>
            <p>By using the top-level schema interface, your <code>when</code> expression must exhaustively handle every
                version and variant.</p>
            @template.tags.code(language="kotlin", content=@`${vm.getSnippets().get(CodeSnippet.WHEN_EXPRESSION_ALL)}`)
        </div>
        <div class="workflow-content" x-show="activeTab === 'version'" x-cloak>
            <p>By typing a parameter as a specific version (e.g., <code>UserAccountSchema.V2</code>), the compiler
                ensures you handle all variants within that version only.</p>
            @template.tags.code(language="kotlin", content=@`${vm.getSnippets().get(CodeSnippet.WHEN_EXPRESSION_BY_VERSION)}`)
        </div>
        <div class="workflow-content" x-show="activeTab === 'variant'" x-cloak>
            <p>By using a local variant interface (e.g., <code>UserAccountSchema.DataVariant</code>), you can handle all
                DTOs of a specific kind, across all versions.</p>
            @template.tags.code(language="kotlin", content=@`${vm.getSnippets().get(CodeSnippet.WHEN_EXPRESSION_BY_VARIANT)}`)
        </div>
    </div>

    <div class="tour-cta">
        <a href="/guide"
           class="button-primary"
           hx-get="/guide"
           hx-target=".main-content"
           hx-push-url="/guide"
           hx-indicator=".page-progress">See More in the Guide</a>
    </div>
</div>