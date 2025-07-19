@param String activeFile

<div id="feature-tour-description" hx-swap-oob="innerHTML">
    @if("source".equals(activeFile))
        <p>Everything starts with a simple Kotlin interface. No boilerplate or complex base classes required.</p>
    @elseif("UserAccountSchema.kt".equals(activeFile))
        <p>KReplica generates powerful, variant-aware DTOs, including special marker interfaces that enable advanced,
            type-safe patterns.</p>
    @elseif("Mapper.kt".equals(activeFile))
        <p>These marker interfaces allow you to build clean, generic mappers that connect your API layer to your domain
            models effortlessly.</p>
    @elseif("Evolve.kt".equals(activeFile))
        <p>Finally, the generated sealed hierarchy provides compile-time safety, forcing you to handle new API versions
            and preventing entire classes of runtime errors.</p>
    @endif
</div>