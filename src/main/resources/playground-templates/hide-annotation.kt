package io.availe.demo.playground

import io.availe.Replicate
import io.availe.models.DtoVariant

@Replicate.Model(variants = [DtoVariant.DATA])
@Replicate.Hide
private interface HiddenAccount {
    val id: Int
}

@Replicate.Model(variants = [DtoVariant.DATA])
private interface VisibleAccount {
    val name: String
}