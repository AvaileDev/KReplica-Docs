@file:OptIn(ExperimentalUuidApi::class)

package io.availe.lytte.models

import io.availe.models.KReplicaCreateVariant
import io.availe.models.KReplicaDataVariant
import io.availe.models.KReplicaPatchVariant
import io.availe.models.Patchable
import kotlin.Int
import kotlin.OptIn
import kotlin.String
import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

public sealed interface UserAccountSchema {
    public sealed interface DataVariant : UserAccountSchema

    public sealed interface PatchRequestVariant : UserAccountSchema

    public sealed interface CreateRequestVariant : UserAccountSchema

    public sealed interface V1 : UserAccountSchema {
        public data class Data(
            public val id: Uuid,
            public val firstName: String,
            public val lastName: String,
            public val email: String,
            public val schemaVersion: Int = 1,
        ) : V1,
            DataVariant,
            KReplicaDataVariant<V1>

        public data class PatchRequest(
            public val firstName: Patchable<String> = Patchable.Unchanged,
            public val lastName: Patchable<String> = Patchable.Unchanged,
            public val email: Patchable<String> = Patchable.Unchanged,
            public val schemaVersion: Patchable<Int> = Patchable.Unchanged,
        ) : V1,
            PatchRequestVariant,
            KReplicaPatchVariant<V1>

        public data class CreateRequest(
            public val firstName: String,
            public val lastName: String,
            public val email: String,
            public val schemaVersion: Int = 1,
        ) : V1,
            CreateRequestVariant,
            KReplicaCreateVariant<V1>
    }

    public sealed interface V2 : UserAccountSchema {
        public data class Data(
            public val id: Uuid,
            public val firstName: String,
            public val lastName: String,
            public val email: String,
            public val schemaVersion: Int = 2,
        ) : V2,
            DataVariant,
            KReplicaDataVariant<V2>

        public data class PatchRequest(
            public val firstName: Patchable<String> = Patchable.Unchanged,
            public val lastName: Patchable<String> = Patchable.Unchanged,
            public val email: Patchable<String> = Patchable.Unchanged,
            public val schemaVersion: Patchable<Int> = Patchable.Unchanged,
        ) : V2,
            PatchRequestVariant,
            KReplicaPatchVariant<V2>

        public data class CreateRequest(
            public val firstName: String,
            public val lastName: String,
            public val email: String,
            public val schemaVersion: Int = 2,
        ) : V2,
            CreateRequestVariant,
            KReplicaCreateVariant<V2>
    }
}