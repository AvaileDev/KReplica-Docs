document.body.addEventListener('htmx:afterSwap', function (evt) {
    Prism.highlightAllUnder(evt.detail.elt);
    initScrollSpy();

    const requestPath = new URL(evt.detail.xhr.responseURL).pathname;
    if (requestPath.startsWith('/guide/')) {
        setTimeout(() => scrollToActiveExample(), 0);
        const exampleShell = document.querySelector('#examples-main .examples-shell');
        applyHighlight(exampleShell);
    }
});

document.body.addEventListener('htmx:beforeSwap', function (evt) {
    if (evt.detail.target.id !== 'playground-output' && window.kreplicaEditor) {
        window.kreplicaEditor.dispose();
        window.kreplicaEditor = null;
    }
});

document.body.addEventListener('htmx:afterSwap', function (e) {
    const editorEl = document.getElementById('kreplica-editor');

    if (editorEl && !window.kreplicaEditor && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }

    if (e.detail.target.id === 'editor-source-container' && window.kreplicaEditor) {
        const newSource = e.detail.target.querySelector('textarea[name="source"]').value;
        window.kreplicaEditor.setValue(newSource);
    }
});

function applyHighlight(targetElement) {
    if (!targetElement) return;
    targetElement.addEventListener('animationend', () => {
        targetElement.classList.remove('flash-highlight');
    }, {once: true});
    targetElement.classList.add('flash-highlight');
}

function scrollToActiveExample() {
    const interactiveExamplesSection = document.getElementById('examples-main');
    if (interactiveExamplesSection) {
        const headerOffset = 85;
        const elementPosition = interactiveExamplesSection.getBoundingClientRect().top;
        const offsetPosition = elementPosition + window.scrollY - headerOffset;

        window.scrollTo({
            top: offsetPosition,
            behavior: "smooth"
        });
    }
}

let scrollSpyTimeoutId;
let isScrollSpyPaused = false;
let activeScrollListener = null;
let isProgrammaticScroll = false;

function throttle(func, limit) {
    let inThrottle;
    return function () {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

function updateActiveNav(targetId) {
    const navContainers = document.querySelectorAll('#guide-sidebar-links, .fab-menu');
    if (!navContainers.length) return;

    navContainers.forEach(container => {
        container.querySelectorAll('a.active').forEach(link => link.classList.remove('active'));
    });

    if (!targetId) return;

    const targetLinks = document.querySelectorAll(`#guide-sidebar-links a[href="#${targetId}"], .fab-menu a[href="#${targetId}"]`);

    targetLinks.forEach(link => {
        link.classList.add('active');
        const fabSubmenu = link.closest('.fab-submenu');
        if (fabSubmenu) {
            const fabContainer = fabSubmenu.closest('.fab-container');
            const parentLi = fabSubmenu.closest('li');
            if (fabContainer && parentLi && fabContainer.__x) {
                const parentLink = parentLi.querySelector('.fab-parent-link');
                if (parentLink) {
                    const parentId = parentLink.getAttribute('href').substring(1);
                    fabContainer.__x.getUnwrappedData().openSection = parentId;
                }
            }
        }
    });
}

function initScrollSpy() {
    if (activeScrollListener) {
        window.removeEventListener('scroll', activeScrollListener);
    }

    const sidebarLinksContainer = document.getElementById('guide-sidebar-links');
    if (!sidebarLinksContainer) return;

    let sections = Array.from(sidebarLinksContainer.querySelectorAll('a[href^="#"]'))
        .map(link => document.getElementById(link.getAttribute('href').substring(1)))
        .filter(section => section !== null);

    if (sections.length === 0) return;

    sections.sort((a, b) => a.offsetTop - b.offsetTop);

    let lastActiveId = null;

    const handleScroll = () => {
        if (isProgrammaticScroll || isScrollSpyPaused) return;

        let newActiveId = null;
        const scrollBottom = Math.ceil(window.innerHeight + window.scrollY);
        const docHeight = document.documentElement.scrollHeight;

        if (scrollBottom >= docHeight) {
            newActiveId = sections[sections.length - 1].id;
        } else {
            const scrollY = window.scrollY;
            const offset = 85;
            for (const section of sections) {
                if (section.offsetTop - offset <= scrollY) {
                    newActiveId = section.id;
                } else {
                    break;
                }
            }
        }

        if (newActiveId === null && sections.length > 0) {
            newActiveId = sections[0].id;
        }

        if (newActiveId !== lastActiveId) {
            lastActiveId = newActiveId;
            updateActiveNav(newActiveId);

            const scrollContainer = document.querySelector('.examples-sidebar');
            if (scrollContainer && scrollContainer.scrollHeight > scrollContainer.clientHeight) {
                const activeLinkInSidebar = scrollContainer.querySelector('a.active');
                if (activeLinkInSidebar) {
                    activeLinkInSidebar.scrollIntoView({
                        behavior: 'smooth',
                        block: 'nearest'
                    });
                }
            }
        }
    };

    sidebarLinksContainer.addEventListener('click', function (e) {
        const anchorLink = e.target.closest('a[href^="#"]');
        if (anchorLink) {
            e.preventDefault();
            const id = anchorLink.getAttribute('href').substring(1);
            const targetSection = document.getElementById(id);
            if (targetSection) {
                isScrollSpyPaused = true;
                const headerOffset = 80;
                const elementPosition = targetSection.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.scrollY - headerOffset;

                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });

                applyHighlight(targetSection);
                updateActiveNav(id);
                lastActiveId = id;

                clearTimeout(scrollSpyTimeoutId);
                scrollSpyTimeoutId = setTimeout(() => {
                    isScrollSpyPaused = false;
                }, 1000);
            }
        }
    });

    activeScrollListener = throttle(handleScroll, 100);
    window.addEventListener('scroll', activeScrollListener);
    handleScroll();
}

document.addEventListener('DOMContentLoaded', function () {
    const editorEl = document.getElementById('kreplica-editor');
    if (editorEl && !window.kreplicaEditor && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }
    initScrollSpy();
    scrollToActiveExample();
});