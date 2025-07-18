<h1>Getting Started</h1>
<p>To get started with KReplica, you need to add the KSP and KReplica plugins to your module's <code>build.gradle.kts</code> file.</p>
<p>This will enable the annotation processor to run during your Kotlin compilation and generate the DTOs based on your interfaces.</p>

@template.tags.code(language = "kotlin", content = @`
    plugins {
    id("com.google.devtools.ksp") version "2.1.21-2.0.1"
    id("io.availe.kreplica") version "3.0.0"
    }
`)

<div class="nav-footer">
    <a href="/concepts" class="button-secondary">Next: Core Concepts &rarr;</a>
</div>