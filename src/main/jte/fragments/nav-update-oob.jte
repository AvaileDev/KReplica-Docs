@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks
@param String currentPage

<div hx-swap-oob="innerHTML:#mobile-nav-links">
    @template.fragments.nav-links(navLinks = navLinks, currentPage = currentPage, isMobile = true)
</div>

<div hx-swap-oob="innerHTML:#desktop-nav-links">
    @template.fragments.nav-links(navLinks = navLinks, currentPage = currentPage, isMobile = false)
</div>