package io.availe.kreplicadocs.services

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import io.availe.kreplicadocs.model.NavLink
import io.availe.kreplicadocs.model.view.GuideSection
import jakarta.annotation.PostConstruct
import org.springframework.core.io.support.ResourcePatternResolver
import org.springframework.stereotype.Service

data class NavigationConfig(
    val mainNav: List<NavLink>,
    val guideNav: List<GuideSection>
)

@Service
class NavigationProvider(
    private val resourcePatternResolver: ResourcePatternResolver,
    private val objectMapper: ObjectMapper,
) {
    private lateinit var navigationConfig: NavigationConfig

    @PostConstruct
    fun init() {
        val resource = resourcePatternResolver.getResource("classpath:metadata/navigation.json")
        navigationConfig = resource.inputStream.use {
            objectMapper.readValue(it, object : TypeReference<NavigationConfig>() {})
        }
    }

    fun getNavLinks(): List<NavLink> = navigationConfig.mainNav

    fun getGuideNav(): List<GuideSection> = navigationConfig.guideNav
}