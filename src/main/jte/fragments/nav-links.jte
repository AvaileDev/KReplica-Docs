@param String currentPage
@param boolean isMobile = false

<ul class="nav-links">
    <li><a href="/"
           @click="${isMobile ? "isOpen = false" : null}"
           class="${currentPage == "index" ? "active" : ""}"
           hx-get="/"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress">Home</a></li>
    <li><a href="/getting-started"
           @click="${isMobile ? "isOpen = false" : null}"
           class="${currentPage == "getting-started" ? "active" : ""}"
           hx-get="/getting-started"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress">Getting Started</a></li>
    <li><a href="/concepts"
           @click="${isMobile ? "isOpen = false" : null}"
           class="${currentPage == "concepts" ? "active" : ""}"
           hx-get="/concepts"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress">Core Concepts</a></li>
    <li><a href="/examples"
           @click="${isMobile ? "isOpen = false" : null}"
           class="${currentPage == "examples" ? "active" : ""}"
           hx-get="/examples"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress">Examples</a></li>
    <li><a href="/faq"
           @click="${isMobile ? "isOpen = false" : null}"
           class="${currentPage == "faq" ? "active" : ""}"
           hx-get="/faq"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress">FAQ</a></li>
</ul>