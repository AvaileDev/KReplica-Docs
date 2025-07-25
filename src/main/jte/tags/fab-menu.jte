@param io.availe.kreplicadocs.model.view.GuideViewModel vm

<div class="fab-container"
     x-data="{ isOpen: false }"
     :class="{ 'is-open': isOpen }"
     @keydown.escape.window="isOpen = false"
     @click.outside="isOpen = false"
     x-cloak>

    <div class="fab-menu">
        <h4 class="fab-menu-header">Guide Sections</h4>
        <ul>
            <li style="--stagger-delay: 0ms;"><a href="#top" @click="isOpen = false">Top</a></li>
            <li style="--stagger-delay: 30ms;"><a href="#quick-start" @click="isOpen = false">Quick Start</a></li>
            <li style="--stagger-delay: 60ms;"><a href="#core-concept" @click="isOpen = false">Core Concept</a></li>
            <li style="--stagger-delay: 90ms;"><a href="#generated-code" @click="isOpen = false">Generated Code</a></li>
            <li style="--stagger-delay: 120ms;"><a href="#api-reference" @click="isOpen = false">API Reference</a></li>
            <li style="--stagger-delay: 150ms;"><a href="#patterns" @click="isOpen = false">Core Patterns</a></li>
            <li style="--stagger-delay: 180ms;"><a href="#faq" @click="isOpen = false">FAQ</a></li>
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