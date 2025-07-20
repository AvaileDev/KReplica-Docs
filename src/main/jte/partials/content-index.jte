@param io.availe.kreplicadocs.ExampleViewModel featureExample
@param String activeFile = "source"

<div class="hero-section">
    <h1>Evolve Your Kotlin DTOs with Confidence</h1>
    <p>KReplica is a DTO generator that creates robust, versioned, and variant-aware data transfer objects from simple
        Kotlin interfaces, eliminating boilerplate and ensuring compile-time safety for your APIs.</p>
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

@if(featureExample != null)
    <div class="feature-highlight">
        <h2>Take the Interactive Tour</h2>
        <div class="feature-playground-wrapper">
            @template.tags.feature-playground(
            controls = @`
                <div class="feature-playground-mobile-controls">
                    <div class="custom-select-wrapper">
                        <label for="tour-select-mobile">Tour Step:</label>
                        <select id="tour-select-mobile"
                                hx-get="this.value"
                                hx-target="#feature-playground-content-wrapper .playground-content"
                                hx-swap="innerHTML"
                                hx-indicator="#feature-playground-content-wrapper .htmx-indicator">
                            @for(var step : featureExample.getFeatureTourSteps())
                                <option value="${step.getEndpoint()}"
                                        selected="${step.getFileName().equals(activeFile)}">
                                    ${step.getTitle()}
                                </option>
                            @endfor
                        </select>
                    </div>
                </div>
                <div class="feature-playground-desktop-controls">
                    @template.fragments.feature-tour-description(featureExample = featureExample, activeFile = activeFile)
                    @template.fragments.feature-playground-tabs(featureExample = featureExample, activeFile = activeFile)
                </div>
            `,
            content = @`
                @template.tags.code(language="kotlin", content=@`${featureExample.getSourceCode()}`)
            `
            )
        </div>
        <div class="tour-cta">
            <a href="/guides"
               class="button-primary"
               hx-get="/guides"
               hx-target=".main-content"
               hx-push-url="/guides"
               hx-indicator=".page-progress">Explore More Examples</a>
        </div>
    </div>
@endif