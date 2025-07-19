fun handleUser(user: UserAccountSchema) {
    when (user) {
        is UserAccountSchema.V1.Data -> {
            println("Handling V1 user: ${user.firstName}")
        }

        is UserAccountSchema.V2.Data -> {
            println("Handling V2 user with new logic: ${user.firstName}")
        }

        else -> {
            // The compiler will force you to handle all variants,
            // including CreateRequest and PatchRequest if needed.
        }
    }
}