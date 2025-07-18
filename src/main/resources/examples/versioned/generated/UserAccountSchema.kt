package io.availe.demo

import io.availe.models.Patchable
import kotlin.Int
import kotlin.String

public sealed interface UserAccountSchema {
    public sealed interface DataVariant : UserAccountSchema

    public sealed interface PatchRequestVariant : UserAccountSchema

    public sealed interface V1 : UserAccountSchema {
        public data class Data(
            public val id: Int,
            public val schemaVersion: Int = 1,
        ) : V1, DataVariant
    }

    public sealed interface V2 : UserAccountSchema {
        public data class Data(
            public val id: Int,
            public val name: String,
            public val schemaVersion: Int = 2,
        ) : V2, DataVariant

        public data class PatchRequest(
            public val id: Patchable<Int> = Patchable.Unchanged,
            public val name: Patchable<String> = Patchable.Unchanged,
            public val schemaVersion: Patchable<Int> = Patchable.Unchanged,
        ) : V2, PatchRequestVariant
    }
}