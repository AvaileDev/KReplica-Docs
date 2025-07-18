<h1>Why KReplica?</h1>
<p>KReplica is designed to solve common, frustrating problems when working with Data Transfer Objects (DTOs) in modern
    applications, especially those with evolving APIs.</p>

<h2>Stop Writing Boilerplate</h2>
<p>Define a single, simple interface and KReplica generates multiple DTO variants for different use cases. You no longer
    need to manually create and sync separate classes for reading data, creating new objects, and patching existing
    ones.</p>
<ul>
    <li><code>DATA</code>: The primary, read-only representation of your model.</li>
    <li><code>CREATE</code>: A variant for object creation, letting you exclude server-generated fields like
        <code>id</code>.
    </li>
    <li><code>PATCH</code>: A variant for updates where every property is wrapped in a <code>Patchable</code> type,
        making it easy to see what's changed.
    </li>
</ul>

<h2>Evolve Your APIs with Confidence</h2>
<p>When your API models change, KReplica provides compile-time safety. By generating a top-level <strong>sealed
        hierarchy</strong> for versioned models, it turns potential runtime errors into build-time errors.</p>
<p>The Kotlin compiler will force you to handle every version and variant in your <code>when</code> expressions,
    guaranteeing that you can't forget to update your logic when a new version of a model is introduced.</p>
@template.tags.code(language="kotlin", content=@`
    fun handleUser(user: UserAccountSchema) {
    when (user) {
    is UserAccountSchema.V1.Data -> println("Old logic for V1")
    is UserAccountSchema.V2.Data -> println("New logic for V2")
    // The compiler will error here if you forget a case!
    }
    }
`)

<h2>Achieve True Type Safety</h2>
<p>Kotlin's type system is great, but it can't prevent you from passing a `String` meant for a username into a function
    expecting a `String` for an email. KReplica solves this with <strong>Nominal Typing</strong>.</p>
<p>It can automatically wrap primitive types in dedicated <code>value class</code> types (e.g., `UserId(123)` instead of
    just `123`), preventing you from accidentally mixing up different kinds of data that share the same underlying type.
</p>


<div class="nav-footer">
    <a href="/playground"
       class="button-secondary"
       hx-get="/playground"
       hx-target=".main-content"
       hx-push-url="/playground"
       hx-indicator=".page-progress">&larr; Prev: Playground</a>
    <a href="/guides"
       class="button-secondary nav-item-next"
       hx-get="/guides"
       hx-target=".main-content"
       hx-push-url="/guides"
       hx-indicator=".page-progress">Next: Guides &rarr;</a>
</div>