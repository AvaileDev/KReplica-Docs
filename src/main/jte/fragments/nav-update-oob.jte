@param io.availe.kreplicadocs.PageViewModel vm

<div hx-swap-oob="innerHTML:#mobile-nav-links">
    @template.fragments.nav-links(navLinks = vm.getNavLinks(), currentPage = vm.getCurrentPage(), isMobile = true)
</div>

<div hx-swap-oob="innerHTML:#desktop-nav-links">
    @template.fragments.nav-links(navLinks = vm.getNavLinks(), currentPage = vm.getCurrentPage(), isMobile = false)
</div>