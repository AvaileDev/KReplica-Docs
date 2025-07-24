@param io.availe.kreplicadocs.model.view.IndexViewModel vm
@param String activeFile = "source"

<div class="hero-section">
    <h1>DTO generation for Kotlin CRUD APIs</h1>
    <p>KReplica generates Kotlin code from interfaces, with explicit control over Create, Data, and Patch variants.</p>
</div>

<h2>Get Started in 60 Seconds</h2>
<p>Add the KSP and KReplica plugins to your module's <code>build.gradle.kts</code> file to start generating DTOs
    automatically.</p>

@template.tags.code(language = "kotlin", content = @`
    plugins {
    id("com.google.devtools.ksp") version "..."
    id("io.availe.kreplica") version "5.0.0"
    }
`)

@if(vm.getFeatureExample() != null)
    <div class="feature-highlight">
        <h2>The Core Workflow</h2>
        <div class="feature-playground-wrapper">
            @template.tags.feature-tour(
            controls = @`
                <div class="feature-playground-mobile-controls">
                    @template.tags.custom-select(
                    label = "Tour Step:",
                    id = "tour-select-mobile",
                    options = vm.getTourSelectOptions(),
                    hxGet = "this.value",
                    hxTarget = "#feature-playground-content-wrapper .playground-content",
                    hxPushUrl = null,
                    hxIndicator = "#feature-playground-content-wrapper .htmx-indicator"
                    )
                </div>
                <div class="feature-playground-desktop-controls">
                    @template.fragments.feature-tour-description(featureExample = vm.getFeatureExample(), activeFile = activeFile)
                    @template.fragments.feature-playground-tabs(featureExample = vm.getFeatureExample(), activeFile = activeFile)
                </div>
            `,
            content = @`
                @template.tags.code(language="kotlin", content=@`${vm.getFeatureExample().getSourceCode()}`)
            `
            )
        </div>
        <div class="tour-cta">
            <a href="/guides"
               class="button-primary"
               hx-get="/guides"
               hx-target=".main-content"
               hx-push-url="/guides"
               hx-indicator=".page-progress">See More in the Guides</a>
        </div>
    </div>
@endif