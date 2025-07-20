fun handleUserPatches(patch: UserAccountSchema.PatchRequestVariant) {
    when (patch) {
        is UserAccountSchema.V1.PatchRequest -> { /* ... */
        }

        is UserAccountSchema.V2.PatchRequest -> { /* ... */
        }
    }
}