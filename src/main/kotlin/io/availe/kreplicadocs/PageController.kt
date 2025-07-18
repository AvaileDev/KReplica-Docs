package io.availe.kreplicadocs

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping

@Controller
class PageController {

    @GetMapping("/")
    fun index(): String {
        return "index"
    }

    @GetMapping("/getting-started")
    fun gettingStarted(): String {
        return "getting-started"
    }

    @GetMapping("/concepts")
    fun concepts(): String {
        return "concepts"
    }

    @GetMapping("/examples")
    fun examples(): String {
        return "examples"
    }

    @GetMapping("/faq")
    fun faq(): String {
        return "faq"
    }
}