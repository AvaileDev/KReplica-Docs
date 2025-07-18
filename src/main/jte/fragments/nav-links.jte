@param String currentPage
@param boolean isMobile = false

<ul class="nav-links">
    <li><a href="/"
           class="${currentPage == "index" ? "active" : ""}"
           hx-get="/"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Home</a></li>
    <li><a href="/getting-started"
           class="${currentPage == "getting-started" ? "active" : ""}"
           hx-get="/getting-started"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Getting Started</a></li>
    <li><a href="/concepts"
           class="${currentPage == "concepts" ? "active" : ""}"
           hx-get="/concepts"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Core Concepts</a></li>
    <li><a href="/examples"
           class="${currentPage == "examples" ? "active" : ""}"
           hx-get="/examples"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Examples</a></li>
    <li><a href="/faq"
           class="${currentPage == "faq" ? "active" : ""}"
           hx-get="/faq"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">FAQ</a></li>
</ul>