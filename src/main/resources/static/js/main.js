document.body.addEventListener('htmx:afterSwap', function (evt) {
    Prism.highlightAllUnder(evt.detail.elt);
    initScrollSpy(false);

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

        const endProgrammaticScroll = () => {
            isProgrammaticScroll = false;
            window.removeEventListener('wheel', endProgrammaticScroll);
        };

        isProgrammaticScroll = true;

        window.addEventListener('wheel', endProgrammaticScroll, {once: true});
        setTimeout(endProgrammaticScroll, 1000);

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

    if (!targetId) {
        targetId = "top";
    }
    ;

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

function initScrollSpy(runImmediately = true) {
    if (activeScrollListener) {
        window.removeEventListener('scroll', activeScrollListener);
        activeScrollListener = null;
    }

    const sidebar = document.getElementById('guide-sidebar-links');
    if (!sidebar) return;

    sidebar.addEventListener('click', function (e) {
        const anchorLink = e.target.closest('a[href^="#"]');
        if (anchorLink) {
            const id = anchorLink.getAttribute('href');
            try {
                const targetSection = document.querySelector(id);
                applyHighlight(targetSection);
                updateActiveNav(id.substring(1));
            } catch (err) {
                console.error("Could not highlight section:", err);
            }

            isScrollSpyPaused = true;
            clearTimeout(scrollSpyTimeoutId);
            const unpauseSpy = () => {
                isScrollSpyPaused = false;
                window.removeEventListener('scroll', unpauseSpy);
            };
            window.addEventListener('scroll', unpauseSpy, {once: true});
            scrollSpyTimeoutId = setTimeout(unpauseSpy, 1000);
        }
    });

    const sections = Array.from(sidebar.querySelectorAll('a[href^="#"]'))
        .map(link => document.querySelector(link.getAttribute('href')))
        .filter(section => section !== null);

    const examplesMainSection = document.getElementById('examples-main');
    if (examplesMainSection) {
        sections.push(examplesMainSection);
    }

    if (sections.length === 0) return;

    const handleScroll = () => {
        if (isProgrammaticScroll || isScrollSpyPaused) return;

        const scrollY = window.scrollY;
        const offset = 85;
        let currentSectionId = null;

        for (const section of sections) {
            if (section.offsetTop - offset <= scrollY) {
                currentSectionId = section.id;
            } else {
                break;
            }
        }

        updateActiveNav(currentSectionId);

        if (sidebar && sidebar.scrollHeight > sidebar.clientHeight) {
            const activeLinkInSidebar = sidebar.querySelector('a.active');
            if (activeLinkInSidebar) {
                activeLinkInSidebar.scrollIntoView({
                    behavior: 'smooth',
                    block: 'nearest'
                });
            }
        }
    };

    activeScrollListener = throttle(handleScroll, 100);
    window.addEventListener('scroll', activeScrollListener);

    if (runImmediately) {
        handleScroll();
    }
}

document.addEventListener('DOMContentLoaded', function () {
    const editorEl = document.getElementById('kreplica-editor');
    if (editorEl && !window.kreplicaEditor && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }
    initScrollSpy();
    scrollToActiveExample();
});