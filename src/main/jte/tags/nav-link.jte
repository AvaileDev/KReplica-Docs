@param io.availe.kreplicadocs.model.NavLink link
@param String currentPage
@param boolean isMobile

<li>
    <a href="${link.getHref()}"
       class="${link.getPageId().equals(currentPage) ? "active" : ""}"
       hx-get="${link.getHref()}"
       hx-target=".main-content"
       hx-push-url="true"
       hx-indicator=".page-progress"
       hx-on::before-request="${isMobile ? "isOpen = false" : null}">
        ${link.getLabel()}
    </a>
</li>