@OptIn(ExperimentalUuidApi::class)
@Replicate.Model(
    variants = [DtoVariant.DATA, DtoVariant.CREATE, DtoVariant.PATCH],
    nominalTyping = NominalTyping.ENABLED
)
private interface UserAccount {
    val emailAddress: String

    @Replicate.Property(include = [DtoVariant.DATA])
    val id: Uuid

    @Replicate.Property(exclude = [DtoVariant.CREATE])
    val banReason: Patchable<List<String?>>

    @Replicate.Property(nominalTyping = NominalTyping.DISABLED)
    val userDescription: String?
}