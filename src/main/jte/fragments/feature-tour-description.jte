@param String activeFile
@param boolean oob = false

<div id="feature-tour-description"
     hx-swap-oob="${oob ? "innerHTML" : null}">
    @if("source".equals(activeFile))
        <p>Everything starts with a simple Kotlin interface. No boilerplate or complex base classes required.</p>
    @elseif("UserAccountSchema.kt".equals(activeFile))
        <p>KReplica generates powerful, variant-aware DTOs, including a sealed hierarchy that enables advanced,
            type-safe patterns.</p>
    @elseif("WhenStatements.kt".equals(activeFile))
        <p>The generated sealed hierarchy enables exhaustive <code>when</code> expressions, forcing you to handle every
            version
            and variant at compile time. This eliminates entire classes of runtime errors as your API evolves.</p>
    @elseif("ApiSchemaMapper.kt".equals(activeFile))
        <p>Here is the key: KReplica generates global variant interfaces. You can use them to define a generic, reusable
            <code>ApiSchemaMapper</code> that is type-safe across all your models and versions.</p>
    @elseif("Mapper.kt".equals(activeFile))
        <p>With the generic pattern in place, implementing a mapper for a specific schema version is clean, simple,
            and compile-time checked, cleanly decoupling your API layer from your domain models.</p>
    @endif
</div>