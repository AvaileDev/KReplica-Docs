@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks
@param String currentPage
@param boolean isMobile = false

<ul class="nav-links">
    @for(var link : navLinks)
        @template.tags.nav-link(link = link, currentPage = currentPage, isMobile = isMobile)
    @endfor
</ul>