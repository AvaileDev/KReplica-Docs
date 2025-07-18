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
    <li><a href="/playground"
           class="${currentPage == "playground" ? "active" : ""}"
           hx-get="/playground"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Playground</a></li>
    <li><a href="/why-kreplica"
           class="${currentPage == "why-kreplica" ? "active" : ""}"
           hx-get="/why-kreplica"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Why KReplica?</a></li>
    <li><a href="/guides"
           class="${currentPage == "guides" ? "active" : ""}"
           hx-get="/guides"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">Guides</a></li>
    <li><a href="/faq"
           class="${currentPage == "faq" ? "active" : ""}"
           hx-get="/faq"
           hx-target=".main-content"
           hx-push-url="true"
           hx-indicator=".page-progress"
           hx-on::before-request="${isMobile ? "isOpen = false" : null}">FAQ</a></li>
</ul>