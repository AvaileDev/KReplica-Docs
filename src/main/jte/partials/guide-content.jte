@param java.util.Map<String, String> snippets

<div class="guide-content">
    <section id="top">
        <h1>KReplica Developer Guide</h1>
        <p>This guide provides a detailed reference for KReplica's API and features, walking through core concepts and
            common patterns to help you get the most out of the library.</p>
    </section>

    <section id="quick-start">
        <h2>Quick Start</h2>
        <p>Add the KSP and KReplica plugins to your module's <code>build.gradle.kts</code> file to start generating DTOs
            automatically.</p>
        @template.tags.code(language = "kotlin", content = @`${snippets.get("quickstart-build.kts")}`)
    </section>

    <section id="core-concept">
        <h2>The Core Concept: From Interface to DTOs</h2>
        <p>Instead of writing and maintaining boilerplate data classes for Create, Read, and Update operations, you
            define your data contract <strong>once</strong> in a simple Kotlin interface. KReplica takes it from there.
        </p>
        @template.tags.code(language="kotlin", content=@`${snippets.get("property-example.kt")}`)
        <p>This simple definition instructs KReplica to generate a sealed hierarchy containing <code>Data</code>, <code>CreateRequest</code>,
            and <code>PatchRequest</code> classes, with the <code>id</code> property correctly excluded from the <code>CreateRequest</code>.
        </p>
    </section>

    <section id="generated-code">
        <h2>Understanding the Generated Code</h2>
        <p>The code KReplica generates is designed for maximum safety and flexibility. It's built on two key concepts
            you'll work with.</p>

        <h4>Sealed Hierarchies for Bulletproof APIs</h4>
        <p>Tired of `if (dto.version == 1)` checks that break when you add a `V3`? KReplica solves this with **sealed
            hierarchies**. This lets you use Kotlin's exhaustive `when` expressions, forcing you to handle every DTO
            variant at compile time. If you add a new version, your code won't compile until you handle it—no more
            runtime surprises.</p>

        <h4>Local vs. Global Variants</h4>
        <p>KReplica generates two categories of interfaces for different use cases:</p>
        <ul>
            <li><strong>Local Variants</strong> (e.g., <code>UserAccountSchema.PatchRequestVariant</code>): Use these
                when working *within a single model's world*. They are perfect for handling all patch requests, but only
                for the `UserAccount` model.
            </li>
            <li><strong>Global Variants</strong> (e.g., <code>KReplicaPatchVariant&lt;V&gt;</code>): This is the key to
                writing reusable code. Use these to create patterns that work *across any KReplica model*, such as a
                generic API mapper.
            </li>
        </ul>
        @template.tags.code(language="kotlin", content=@`${snippets.get("local-variants-example.kt")}`)
    </section>

    <section id="api-reference">
        <h2>Configuration API Reference</h2>
        <p>KReplica is configured using a set of annotations. This section serves as a detailed dictionary for every
            available option.</p>

        <h3>@Replicate.Model</h3>
        <p>This is the primary annotation that marks an interface for DTO generation.</p>
        <ul>
            <li><strong><code>variants: Array&lt;DtoVariant&gt;</code></strong> (Required)<br>Specifies which DTO
                variants to generate. Possible values are <code>DtoVariant.DATA</code>, <code>DtoVariant.CREATE</code>,
                and <code>DtoVariant.PATCH</code>.
            </li>
            <li><strong><code>nominalTyping: NominalTyping</code></strong> (Default: <code>DISABLED</code>)<br>Avoid
                passing an email string into a user ID field by mistake. When <code>ENABLED</code>, this wraps primitive
                properties in type-safe value classes.
            </li>
            <li><strong><code>autoContextual: AutoContextual</code></strong> (Default: <code>ENABLED</code>)<br>Controls
                automatic integration with <code>kotlinx.serialization</code> by adding <code>@Contextual</code> to
                non-primitive property types.
            </li>
        </ul>

        <h3>@Replicate.Property</h3>
        <p>This annotation provides fine-grained control over individual properties, allowing you to override the
            settings from <code>@Replicate.Model</code>.</p>
        <ul>
            <li><strong><code>include: Array&lt;DtoVariant&gt;</code></strong><br>Explicitly includes the property <em>only</em>
                in the specified variants.
            </li>
            <li><strong><code>exclude: Array&lt;DtoVariant&gt;</code></strong><br>Excludes the property from the
                specified variants.
            </li>
            <li><strong><code>nominalTyping</code></strong> and <strong><code>autoContextual</code></strong><br>These
                parameters function identically to their counterparts in <code>@Replicate.Model</code> but apply only to
                the specific property they annotate.
            </li>
        </ul>

        <h3>Supporting Annotations</h3>
        <ul>
            <li><strong><code>@Replicate.SchemaVersion(number: Int)</code></strong>: Manually specifies a version number
                for versioned schemas if you don't use the `V1`, `V2` naming convention.
            </li>
            <li><strong><code>@Replicate.Apply(annotations: Array&lt;KClass&gt;)</code></strong>: Applies other
                annotations (like <code>@Serializable</code>) to the generated DTOs.
            </li>
            <li><strong><code>@Replicate.Hide</code></strong>: Disables code generation for the annotated model, useful
                for temporarily testing the impact of removing a schema.
            </li>
        </ul>
    </section>

    <section id="patterns">
        <h2>Core Patterns & Use Cases</h2>
        <p>Learn how to apply KReplica's features to solve common development challenges.</p>

        <h3>Schema Versioning</h3>
        <p>Your API needs to evolve without breaking existing clients. To do this safely, you can create a `V2` of your
            interface. KReplica will add it to the sealed hierarchy, ensuring you handle both old and new clients
            correctly at compile-time.</p>

        <h3>Contextual Variant Nesting</h3>
        <p>When you have an `AdminAccount` that contains a `UserAccount`, how do you ensure the
            `AdminAccount.CreateRequest` correctly uses the `UserAccount.CreateRequest`? KReplica handles this
            automatically.</p>
        <div class="workflow-container" x-data="{ activeTab: 'auto' }">
            <div class="workflow-tabs" role="tablist">
                <button role="tab" :class="{ 'active': activeTab === 'auto' }" @click="activeTab = 'auto'">The Smart Way
                    (Automatic)
                </button>
                <button role="tab" :class="{ 'active': activeTab === 'manual' }" @click="activeTab = 'manual'">The Hard
                    Way (Manual)
                </button>
            </div>
            <div class="workflow-content" x-show="activeTab === 'auto'" x-cloak>
                <p>Let KReplica handle the complexity. Simply nest the base interface of the child model (`V1`).
                    KReplica automatically ensures that the `Create` variant of the parent uses the `Create` variant of
                    the child, and so on.</p>
                @template.tags.code(language="kotlin", content=@`${snippets.get("nested-model-pattern.kt")}`)
            </div>
            <div class="workflow-content" x-show="activeTab === 'manual'" x-cloak>
                <p>To appreciate the automatic approach, here is how you would have to do it manually. Notice how you
                    need to explicitly reference generated types and use `@Replicate.Property` to wire up each variant.
                    This is verbose and error-prone.</p>
                @template.tags.code(language="kotlin", content=@`${snippets.get("nested-model-manual-pattern.kt")}`)
            </div>
        </div>

        <h3>Recipe: Type-Safe API Mappers</h3>
        <p>Now let's use the Global Variant Interfaces to build a completely reusable bridge between your DTOs and your
            internal domain models, which contain your business logic. This pattern allows you to define one generic
            `ApiSchemaMapper` for your entire application.</p>
        @template.tags.code(language="kotlin", content=@`${snippets.get("mapper-pattern-example.kt")}`)

        <h3>Integrating with kotlinx.serialization</h3>
        <p>Use <code>@Replicate.Apply([Serializable::class])</code> to make all generated DTOs serializable. For complex
            types like `Instant` or generics, KReplica's `autoContextual = ENABLED` setting will automatically add the
            <code>@Contextual</code> annotation where needed, preventing common serialization errors.</p>
    </section>

    <section id="faq">
        <h2>Frequently Asked Questions</h2>
        <h3>Can a `Replication.Property` have a broader replication than its `Replication.Model`?</h3>
        <p>No. The replication of all properties must be a subset of the parent model’s variants. This rule ensures
            fail-fast feedback. If you restrict a parent’s replication but forget to update a child property, you’ll get
            an immediate build-time error instead of a silent failure.</p>

        <h3>If a `Replicate.Model` has another `Replicate.Model` as a field, does the order of compilation matter?</h3>
        <p>No. KReplica uses a two-pass compilation strategy. It first generates stub files for all `@Replicate.Model`
            declarations to make their types known, then performs the main compilation. This ensures that nested models
            resolve correctly regardless of file order.</p>

        <h3>Why do the examples use the private keyword?</h3>
        <p>The `private` keyword is not required, but it's a recommended practice. The source interfaces are only for
            KReplica's use; your application code will interact with the generated DTOs. Making them private prevents
            them from polluting the global namespace. This is especially useful for versioned schemas, as it allows you
            to nest versions (e.g., `private interface V1 : UserAccount`) inside a parent scope, avoiding naming
            collisions.</p>
    </section>
</div>