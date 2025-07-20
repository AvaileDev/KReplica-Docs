@param io.availe.kreplicadocs.model.PageViewModel vm

<div hx-swap-oob="innerHTML:#mobile-nav-links">
    @template.fragments.nav-links(vm = vm, isMobile = true)
</div>

<div hx-swap-oob="innerHTML:#desktop-nav-links">
    @template.fragments.nav-links(vm = vm, isMobile = false)
</div>