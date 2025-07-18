@template.layout.main(
currentPage = "index",
content = @`
    <h1>KReplica</h1>
    <p>KReplica is a DTO generator for KMM and Kotlin JVM. It runs automatically during Kotlin compilation.</p>
    <p>Please check out the proposals for mapping to a source object.</p>

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
        <li><strong>Granular control:</strong> Enable or disable specific features or variants at both the model and property levels.</li>
        <li><strong>Nominal Typing:</strong> Automatically wrap primitive types in value classes for added type safety and clarity.</li>
        <li><strong>Schema Versioning:</strong> Defines a sealed interface for each schema version, enabling exhaustive when expressions.</li>
        <li><strong>Plain Kotlin:</strong> Emits plain Kotlin source files to your build directory, free of framework-specific code or runtime dependencies.</li>
    </ul>
    <p>Ready to get started? <a href="/getting-started">Check out the Quick Start guide</a>.</p>
`
)