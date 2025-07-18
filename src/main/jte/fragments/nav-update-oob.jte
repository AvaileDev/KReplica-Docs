@param String currentPage

<div hx-swap-oob="innerHTML:#mobile-nav-links">
    @template.fragments.nav-links(currentPage = currentPage, isMobile = true)
</div>

<div hx-swap-oob="innerHTML:#desktop-nav-links">
    @template.fragments.nav-links(currentPage = currentPage, isMobile = false)
</div>