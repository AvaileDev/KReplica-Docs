@file:OptIn(ExperimentalUuidApi::class)

package io.availe.demo

import io.availe.models.Patchable
import kotlin.OptIn
import kotlin.String
import kotlin.collections.List
import kotlin.jvm.JvmInline
import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

public sealed interface UserAccountSchema {
    public data class Data(
        public val emailAddress: UserAccountEmailAddress,
        public val id: UserAccountId,
        public val banReason: UserAccountBanReason,
        public val userDescription: String?,
    ) : UserAccountSchema

    public data class CreateRequest(
        public val emailAddress: UserAccountEmailAddress,
        public val userDescription: String?,
    ) : UserAccountSchema

    public data class PatchRequest(
        public val emailAddress: Patchable<UserAccountEmailAddress> = Patchable.Unchanged,
        public val banReason: Patchable<UserAccountBanReason> = Patchable.Unchanged,
        public val userDescription: Patchable<String?> = Patchable.Unchanged,
    ) : UserAccountSchema
}