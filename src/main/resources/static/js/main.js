document.body.addEventListener('htmx:afterSwap', function (evt) {
    Prism.highlightAllUnder(evt.detail.elt);
    initScrollSpy();

    const requestPath = new URL(evt.detail.xhr.responseURL).pathname;
    if (requestPath.startsWith('/guides/')) {
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
    const onGuidesPage = document.querySelector('.examples-container');
    const activeExampleLink = document.querySelector('.examples-sidebar a[href^="/guides/"][class="active"]');
    const interactiveExamplesSection = document.getElementById('examples-main');

    if (onGuidesPage && activeExampleLink && interactiveExamplesSection) {
        interactiveExamplesSection.scrollIntoView({behavior: 'smooth', block: 'start'});
    }
}

let scrollSpyTimeoutId;
let isScrollSpyPaused = false;
let activeScrollListener = null;

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

function setActiveSidebarLink(sidebar, targetLink) {
    if (!sidebar || !targetLink) return;
    const currentActive = sidebar.querySelector('a.active');
    if (currentActive === targetLink) return;

    const allLinks = sidebar.querySelectorAll('a');
    allLinks.forEach(link => link.classList.remove('active'));
    targetLink.classList.add('active');
}

function initScrollSpy() {
    if (activeScrollListener) {
        window.removeEventListener('scroll', activeScrollListener);
        activeScrollListener = null;
    }

    const sidebar = document.getElementById('guide-sidebar-links');
    if (!sidebar) return;

    sidebar.addEventListener('click', function (e) {
        const anchorLink = e.target.closest('a[href^="#"]');
        if (anchorLink) {
            try {
                const id = anchorLink.getAttribute('href');
                const targetSection = document.querySelector(id);
                applyHighlight(targetSection);
            } catch (err) {
                console.error("Could not highlight section:", err);
            }
        }

        const target = e.target.closest('a');
        if (target) {
            setActiveSidebarLink(sidebar, target);

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
        if (isScrollSpyPaused) return;

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

        if (currentSectionId) {
            let linkToActivate;
            if (currentSectionId === 'examples-main') {
                const pathParts = window.location.pathname.split('/');
                const slug = pathParts[pathParts.length - 1];
                if (slug && slug !== 'guides') {
                    linkToActivate = sidebar.querySelector(`a[href="/guides/${slug}"]`);
                } else {
                    linkToActivate = sidebar.querySelector('a[href^="/guides/"]');
                }
            } else {
                linkToActivate = sidebar.querySelector(`a[href="#${currentSectionId}"]`);
            }
            if (linkToActivate) {
                setActiveSidebarLink(sidebar, linkToActivate);
            }
        } else {
            setActiveSidebarLink(sidebar, sidebar.querySelector('a[href="#top"]'));
        }
    };

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