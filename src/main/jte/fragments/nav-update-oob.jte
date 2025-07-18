@param String currentPage

<div hx-swap-oob="outerHTML:#mobile-nav-links">
    <nav class="main-nav" id="mobile-nav-links">
        @template.fragments.nav-links(currentPage = currentPage, isMobile = true)
    </nav>
</div>

<div hx-swap-oob="outerHTML:#desktop-nav-links">
    <nav class="desktop-nav" id="desktop-nav-links">
        @template.fragments.nav-links(currentPage = currentPage, isMobile = false)
    </nav>
</div>