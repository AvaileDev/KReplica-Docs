<h1>Core Concepts</h1>
<p>Understanding the core concepts of KReplica is key to using it effectively. This guide will walk you through the main
    ideas, from the basic model definition to the power of schema versioning.</p>

<h2>The Basic Idea: Model from Interface</h2>
<p>At its heart, KReplica generates DTOs from a simple Kotlin <code>interface</code> that you define. You use
    annotations to tell KReplica what to build.</p>

<h2>Variants: DATA, CREATE, and PATCH</h2>
<p>A single source interface can generate multiple DTO variants for different use cases:</p>
<ul>
    <li><code>DATA</code>: The primary, read-only representation of your model.</li>
    <li><code>CREATE</code>: A variant used for object creation requests. You can exclude server-generated fields like
        <code>id</code>.
    </li>
    <li><code>PATCH</code>: A variant for update requests, where every property is wrapped in a <code>Patchable</code>
        type to distinguish between changed and unchanged values.
    </li>
</ul>

<h2>Schema Versioning & Sealed Hierarchies</h2>
<p>For models that evolve over time, KReplica supports schema versioning. You define a base interface and then extend it
    with versioned interfaces (e.g., <code>V1</code>, <code>V2</code>). KReplica uses this structure to generate a
    top-level <strong>sealed hierarchy</strong>.</p>
<p>For example, if you define <code>V1</code> and <code>V2</code> interfaces, KReplica generates a structure like this:
</p>
@template.tags.code(language="kotlin", content=@`
    public sealed interface UserAccountSchema {
    public sealed interface V1 : UserAccountSchema { /* ... */ }
    public sealed interface V2 : UserAccountSchema { /* ... */ }
    }
`)

<h2>The Payoff: Exhaustive <code>when</code> Expressions</h2>
<p>Because KReplica generates a sealed hierarchy, the Kotlin compiler can ensure your <code>when</code> expressions are
    exhaustive. This provides compile-time safety, guaranteeing you handle every possible version and variant of your
    model.</p>
@template.tags.code(language="kotlin", content=@`
    fun handleUser(user: UserAccountSchema) {
    when (user) {
    is UserAccountSchema.V1.Data -> println("Handling a V1 user")
    is UserAccountSchema.V2.Data -> println("Handling a V2 user")
    is UserAccountSchema.V2.PatchRequest -> println("Handling a V2 patch")
    }
    }
`)

<h2>Nominal Typing</h2>
<p>To improve type safety, KReplica can automatically wrap primitive types like <code>String</code> or <code>Int</code>
    in dedicated <code>value class</code> types. This prevents accidentally mixing up different kinds of IDs or values.
</p>

<div class="nav-footer">
    <a href="/getting-started" class="button-secondary">&larr; Prev: Getting Started</a>
    <a href="/guides" class="button-secondary nav-item-next">Next: Guides &rarr;</a>
</div>