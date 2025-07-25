@import gg.jte.support.ForSupport
@param io.availe.kreplicadocs.model.view.GuideViewModel vm

<div class="fab-container"
     x-data="{ isOpen: false, openSection: null }"
     :class="{ 'is-open': isOpen }"
     @keydown.escape.window="isOpen = false"
     @click.outside="isOpen = false"
     x-cloak>

    <div class="fab-menu">
        <h4 class="fab-menu-header">Guide Sections</h4>
        <ul>
            @for (var sectionLoop : ForSupport.of(vm.getGuideNav()))
                !{ var section = sectionLoop.get(); }
                <li style="--stagger-delay: ${sectionLoop.getIndex() * 30}ms;">
                    @if(section.getSubsections().isEmpty())
                        <a href="#${section.getId()}" @click="isOpen = false">${section.getTitle()}</a>
                    @else
                        <div class="fab-parent-item">
                            <a href="#${section.getId()}" @click="isOpen = false"
                               class="fab-parent-link">${section.getTitle()}</a>
                            <button type="button" class="fab-toggle-button" aria-label="Toggle subsection"
                                    @click="openSection = openSection === '${section.getId()}' ? null : '${section.getId()}'">
                                <svg class="fab-toggle-icon"
                                     :class="{ 'is-open': openSection === '${section.getId()}' }"
                                     xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path d="M7.41 8.59L12 13.17l4.59-4.58L18 10l-6 6-6-6 1.41-1.41z"/>
                                </svg>
                            </button>
                        </div>
                        <ul x-show="openSection === '${section.getId()}'" class="fab-submenu"
                            x-transition.opacity.duration.200ms>
                            @for (var subsection : section.getSubsections())
                                <li>
                                    <a href="#${subsection.getId()}"
                                       @click="isOpen = false">${subsection.getTitle()}</a>
                                </li>
                            @endfor
                        </ul>
                    @endif
                </li>
            @endfor
        </ul>
    </div>

    <button type="button"
            class="fab-button"
            @click="isOpen = !isOpen"
            aria-label="Toggle Table of Contents">
        ...
    </button>
</div>
