@import gg.jte.support.ForSupport
@param io.availe.kreplicadocs.model.view.GuidesViewModel vm

<div class="fab-container"
     x-data="{ isOpen: false }"
     :class="{ 'is-open': isOpen }"
     @keydown.escape.window="isOpen = false"
     @click.outside="isOpen = false"
     x-cloak>

    <div class="fab-menu">
        <h4 class="fab-menu-header">Guide Sections</h4>
        <ul>
            @for(var entryLoop : ForSupport.of(vm.getGuideTocItems().entrySet()))
                <li style="--stagger-delay: ${entryLoop.getIndex() * 30}ms;">
                    @if(entryLoop.get().getKey().getSlug() == null)
                        <a href="${entryLoop.get().getKey().getHref()}"
                           @click="isOpen = false">${entryLoop.get().getKey().getName()}</a>
                    @else
                        <a href="${entryLoop.get().getKey().getHref()}"
                           class="${entryLoop.get().getKey().getSlug().equals(vm.getActiveSlug()) ? "active" : ""}"
                           hx-get="${entryLoop.get().getKey().getHref()}"
                           hx-target=".main-content"
                           hx-push-url="true"
                           hx-indicator=".page-progress"
                           @click="isOpen = false">
                            ${entryLoop.get().getKey().getName()}
                        </a>
                    @endif
                </li>
            @endfor
        </ul>
    </div>

    <button type="button"
            class="fab-button"
            @click="isOpen = !isOpen"
            aria-label="Toggle Table of Contents">
        <svg class="fab-icon-menu" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path d="M4 6h16v2H4zm0 5h16v2H4zm0 5h16v2H4z"></path>
        </svg>
        <svg class="fab-icon-close" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"></path>
        </svg>
    </button>
</div>