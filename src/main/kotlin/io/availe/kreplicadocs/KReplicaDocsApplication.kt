package io.availe.kreplicadocs

import io.availe.kreplicadocs.config.AppProperties
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.boot.runApplication

@SpringBootApplication
@EnableConfigurationProperties(AppProperties::class)
class KReplicaDocsApplication

fun main(args: Array<String>) {
    runApplication<KReplicaDocsApplication>(*args)
}
