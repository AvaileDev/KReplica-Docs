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
        <h2>Define Once, Use Everywhere</h2>
        <p>From a simple interface, KReplica generates not just the DTOs, but enables powerful, type-safe patterns like
            exhaustive <code>when</code> expressions.</p>
        <div class="feature-playground-wrapper">
            @template.tags.feature-playground(featureExample = featureExample)
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