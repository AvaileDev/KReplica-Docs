@param java.util.Map<String, String> snippets

<div class="guide-content">
    <h1 id="top">KReplica Developer Guide</h1>
    <p>
        This guide provides a detailed reference for KReplica's API and features. It assumes you have already seen the
        high-level overview on the homepage.
    </p>

    <h2 id="api-reference">Core API Reference</h2>
    <p>
        KReplica is configured using a set of annotations. This section serves as a detailed dictionary for every
        available option.
    </p>

    <h3 id="api-model">@Replicate.Model</h3>
    <p>This is the primary annotation that marks an interface for DTO generation.</p>
    <ul>
        <li>
            <strong><code>variants: Array&lt;DtoVariant&gt;</code></strong> (Required)<br>
            Specifies which DTO variants to generate. Possible values are <code>DtoVariant.DATA</code>,
            <code>DtoVariant.CREATE</code>, and <code>DtoVariant.PATCH</code>.
        </li>
        <li>
            <strong><code>nominalTyping: NominalTyping</code></strong> (Default: <code>DISABLED</code>)<br>
            When <code>ENABLED</code>, wraps primitive properties (String, Int, etc.) in a dedicated value class for
            enhanced type safety. For example, a property <code>val email: String</code> would become <code>val email:
                Email</code>
            in the generated DTO, where <code>Email</code> is a <code>value class Email(val value: String)</code>.
        </li>
        <li>
            <strong><code>autoContextual: AutoContextual</code></strong> (Default: <code>ENABLED</code>)<br>
            Controls integration with <code>kotlinx.serialization</code>. When <code>ENABLED</code>, KReplica
            automatically adds
            the <code>@Contextual</code> annotation to any property types that are not standard primitives, which is
            often
            required for custom types or generics.
        </li>
    </ul>

    <h3 id="api-property">@Replicate.Property</h3>
    <p>This annotation provides fine-grained control over individual properties within a model, allowing you to
        override the settings from <code>@Replicate.Model</code>.</p>
    <ul>
        <li>
            <strong><code>include: Array&lt;DtoVariant&gt;</code></strong><br>
            Explicitly includes the property <em>only</em> in the specified variants.
        </li>
        <li>
            <strong><code>exclude: Array&lt;DtoVariant&gt;</code></strong><br>
            Excludes the property from the specified variants. For example, an ID is often excluded from the <code>CREATE</code>
            variant.
        </li>
    </ul>
    @template.tags.code(language="kotlin", content=@`${snippets.get("property-example.kt")}`)
    <ul>
        <li>
            <strong><code>nominalTyping</code></strong> and <strong><code>autoContextual</code></strong><br>
            These parameters function identically to their counterparts in <code>@Replicate.Model</code> but apply only
            to
            the specific property they annotate.
        </li>
    </ul>

    <h3 id="api-supporting">Supporting Annotations</h3>
    <ul>
        <li><strong><code>@Replicate.SchemaVersion(number: Int)</code></strong>: Manually specifies a version number,
            for use when you do not want to follow the <code>V1</code>, <code>V2</code> naming convention.
        </li>
        <li><strong><code>@Replicate.Apply(annotations: Array&lt;KClass&gt;)</code></strong>: Applies other annotations
            (like <code>@Serializable</code>) to the generated DTOs.
        </li>
        <li><strong><code>@Replicate.Hide</code></strong>: Disables code generation for the annotated model, useful for
            temporarily testing the effects of removing a schema.
        </li>
    </ul>

    <h2 id="generated-code">Understanding the Generated Code</h2>
    <p>KReplica generates a sealed interface hierarchy that contains different types of variant interfaces.</p>

    <h3 id="variants-local-global">Local vs. Global Variants</h3>
    <p>
        It is crucial to understand the two categories of variant interfaces that KReplica generates, as they serve
        different purposes.
    </p>
    <h4>Local Variants</h4>
    <p>
        Inside every generated schema (e.g., <code>UserAccountSchema</code>), KReplica creates nested interfaces like
        <code>DataVariant</code>, <code>CreateRequestVariant</code>, and <code>PatchRequestVariant</code>. These are
        "local" because they only group together variants from within that single schema. They are perfect for when you
        need to handle all patch requests, but only for the <code>UserAccount</code> model.
    </p>
    @template.tags.code(language="kotlin", content=@`${snippets.get("local-variants-example.kt")}`)

    <h4>Global Variants</h4>
    <p>
        KReplica also provides top-level, generic interfaces: s<code>KReplicaDataVariant&lt;V&gt;</code>, <code>KReplicaCreateVariant&lt;V&gt;</code>,
        and <code>KReplicaPatchVariant&lt;V&gt;</code>. These are "global" because they are not tied to any one schema.
        Their purpose is to enable powerful, generic, <strong>cross-schema patterns</strong>, as you'll see in the
        recipes below.
    </p>

    <h2 id="patterns">Advanced Patterns &amp; Recipes</h2>

    <h3 id="pattern-mappers">Recipe: Type-Safe Generic Mappers</h3>
    <p>
        The primary use case for Global Variants is building a generic, reusable, and type-safe mapping layer between
        your API DTOs and your internal domain models.
    </p>
    <p>
        By using the global interfaces as generic constraints, you can define a single <code>ApiSchemaMapper</code> that
        works for any KReplica-generated model.
    </p>
    @template.tags.code(language="kotlin", content=@`${snippets.get("mapper-pattern-example.kt")}`)

    <h3 id="pattern-nested">Pattern: Contextual Nested Models</h3>
    <p>
        When you use one replicated model as a property inside another, KReplica intelligently maps the corresponding
        variants. For example, the <code>CREATE</code> variant of a parent model will automatically use the
        <code>CREATE</code> variant of the nested child model.
    </p>
    @template.tags.code(language="kotlin", content=@`${snippets.get("nested-model-pattern.kt")}`)
</div>