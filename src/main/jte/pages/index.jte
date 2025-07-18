@template.layout.main(
currentPage = "index",
content = @`
    <div class="hero-section">
        <h1>Generate Type-Safe Kotlin DTOs, Effortlessly.</h1>
        <p>KReplica is a DTO generator for KMM and Kotlin JVM that runs automatically during compilation to create robust, versioned, and variant-aware data transfer objects from simple interfaces.</p>
        <a href="/getting-started" class="button-primary">Get Started</a>
    </div>

    <h2>Features</h2>
    <ul>
        <li>
            <strong>Variant generation:</strong> From a single interface, specify up to three variants to generate:
            <ul>
                <li><code>DATA</code>: For read-only data representation</li>
                <li><code>CREATE</code>: For object creation requests</li>
                <li><code>PATCH</code>: For update requests, wraps properties in a <code>Patchable</code> type.</li>
            </ul>
        </li>
        <li><strong>Schema Versioning:</strong> Defines a sealed interface for each schema version, enabling exhaustive when expressions for powerful, type-safe evolution of your models.</li>
        <li><strong>Nominal Typing:</strong> Automatically wrap primitive types in value classes for added type safety and clarity, preventing common bugs.</li>
        <li><strong>Granular control:</strong> Enable or disable specific features or variants at both the model and property levels.</li>
        <li><strong>Plain Kotlin:</strong> Emits plain Kotlin source files to your build directory, free of framework-specific code or runtime dependencies.</li>
    </ul>
`
)