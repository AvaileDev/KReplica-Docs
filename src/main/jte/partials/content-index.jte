@param io.availe.kreplicadocs.Example featureExample

<div class="hero-section">
    <h1>Evolve Your Kotlin DTOs with Confidence</h1>
    <p>KReplica is a DTO generator that creates robust, versioned, and variant-aware data transfer objects from simple
        Kotlin interfaces, eliminating boilerplate and ensuring compile-time safety for your APIs.</p>
    <a href="/guides"
       class="button-primary"
       hx-get="/guides"
       hx-target=".main-content"
       hx-push-url="/guides"
       hx-indicator=".page-progress">See the Guides</a>
</div>

@if(featureExample != null)
    <div class="feature-highlight">
        <h2>From Interface to Type-Safe API</h2>
        <p>See how KReplica transforms a simple definition into a robust, versioned, and easy-to-use API model. Click
            through the tabs to follow the journey.</p>
        <div class="feature-playground-wrapper">
            @template.tags.feature-playground(
            featureExample = featureExample,
            tabs = @`
                <button role="tab" aria-selected="true" class="active"
                        hx-get="/examples/${featureExample.getSlug()}/file/source"
                        hx-target="#feature-playground-content-wrapper .playground-content"
                        hx-swap="innerHTML">
                    1. Define Interface
                </button>
                <button role="tab" aria-selected="false"
                        hx-get="/examples/${featureExample.getSlug()}/file/${featureExample.getGeneratedFiles().keySet().iterator().next()}"
                        hx-target="#feature-playground-content-wrapper .playground-content"
                        hx-swap="innerHTML">
                    2. Generate DTOs
                </button>
                <button role="tab" aria-selected="false"
                        hx-get="/examples/${featureExample.getSlug()}/usage/Mapper.kt"
                        hx-target="#feature-playground-content-wrapper .playground-content"
                        hx-swap="innerHTML">
                    3. Integrate Mapper
                </button>
                <button role="tab" aria-selected="false"
                        hx-get="/examples/${featureExample.getSlug()}/usage/Evolve.kt"
                        hx-target="#feature-playground-content-wrapper .playground-content"
                        hx-swap="innerHTML">
                    4. Evolve with &#96;when&#96;
                </button>
            `,
            initialContent = @`
                @template.tags.code(language="kotlin", content=@`
                    ${featureExample.getSourceCode()}
                `)
            `
            )
        </div>
    </div>
@endif


<h2>Get Started in 60 Seconds</h2>
<p>Add the KSP and KReplica plugins to your module's <code>build.gradle.kts</code> file to start generating DTOs
    automatically.</p>

@template.tags.code(language = "kotlin", content = @`
    plugins {
    id("com.google.devtools.ksp") version "..."
    id("io.availe.kreplica") version "5.0.0"
    }
`)