// This generic interface is defined once in your application.
// It uses Global Variants as type constraints.
interface ApiSchemaMapper<
        M,
        ID,
        V : Any,
        D : KReplicaDataVariant<V>,
        C : KReplicaCreateVariant<V>,
        P : KReplicaPatchVariant<V>
        > {
    fun toDataDto(model: M): D
    fun toDomain(id: ID, dto: C): M
    fun applyPatch(model: M, patch: P): M
}