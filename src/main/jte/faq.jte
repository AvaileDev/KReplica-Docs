@template.layout.main(
title = "FAQ | KReplica Docs",
currentPage = "faq",
content = @`
    <h1>FAQ & Addenda</h1>

    <h2>Frequently Asked Questions</h2>

    <h3>Can a Replication.Property have a broader replication than its Replication.Model?</h3>
    <p>No. The replication of all children must be a subset of the parent (⊆), including for nested models. Otherwise, KReplica will error and log the offending fields.</p>
    <p>This rule ensures fail-fast feedback. If you restrict a parent’s replication but forget to update a child field, you’ll get an immediate build-time error.</p>

    <h3>If a Replicate.Model has another Replicate.Model as a field, does the order of compilation matter?</h3>
    <p>No. KReplica cleans the build folder at the start of each run (which ensures no stale data). To ensure that nested contextuals work, KReplica uses two-pass compilation. Prior to the main compilation, it creates stub files of all <code>Replicate.Model</code> declarations, which is then deleted to avoid a redeclaration error.</p>

    <h3>Why do all the examples use the private keyword?</h3>
    <p>The <code>private</code> keyword is not required. However, the KReplica source interfaces are only used by the processor and are not intended for direct use in application code. Using <code>private</code> prevents them from polluting the global namespace.</p>
    <p>This is particularly important with versioned schemas, as the <code>V[number]</code> naming convention is repetitive. This does mean, however, that only one versioned schema can exist per file.</p>

    <h2>Other Addenda</h2>
    @template.tags.alert(content = @`
        <p><strong>Note 1:</strong> KReplica generates all output files in your module’s <code>build/generated-src/kotlin-poet/</code> directory.</p>
    `)

    @template.tags.alert(content = @`
        <p><strong>Note 2:</strong> 90% of what you need to know to utilize KReplica is covered by the first two examples: <code>Replicate.Model</code> / <code>Replicate.Property</code> and Versioned Schemas.</p>
    `)
`
)