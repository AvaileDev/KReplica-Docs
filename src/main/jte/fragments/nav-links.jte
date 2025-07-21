@param io.availe.kreplicadocs.model.view.PageViewModel vm
@param boolean isMobile = false

<ul class="nav-links" hx-ext="preload">
    @for(var link : vm.getNavLinks())
        @template.tags.nav-link(link = link, currentPage = vm.getCurrentPage(), isMobile = isMobile)
    @endfor
</ul>