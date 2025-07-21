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

    if (onGuidesPage && activeExampleLink) {
        document.getElementById('interactive-examples')?.scrollIntoView({behavior: 'smooth', block: 'start'});
    }
}

let scrollSpyTimeoutId;
let isScrollSpyPaused = false;

function setActiveSidebarLink(sidebar, targetLink) {
    if (!sidebar || !targetLink) return;
    const currentActive = sidebar.querySelector('a.active');
    if (currentActive === targetLink) return;

    const allLinks = sidebar.querySelectorAll('a');
    allLinks.forEach(link => link.classList.remove('active'));
    targetLink.classList.add('active');
}

function initScrollSpy() {
    const sidebar = document.getElementById('guide-sidebar-links');
    if (!sidebar) return;

    sidebar.addEventListener('click', function (e) {
        const anchorLink = e.target.closest('a[href^="#"]');
        if (anchorLink) {
            try {
                const id = anchorLink.getAttribute('href');
                const targetHeading = document.querySelector(id);
                applyHighlight(targetHeading?.closest('section'));
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
                clearTimeout(scrollSpyTimeoutId);
            };

            window.addEventListener('scroll', unpauseSpy, {once: true});

            scrollSpyTimeoutId = setTimeout(() => {
                isScrollSpyPaused = false;
                window.removeEventListener('scroll', unpauseSpy);
            }, 1000);
        }
    });

    const sectionsToObserve = [];
    const interactiveExampleSection = document.getElementById('interactive-examples');
    if (interactiveExampleSection) {
        sectionsToObserve.push(interactiveExampleSection);
    }
    sidebar.querySelectorAll('a[href^="#"]').forEach(link => {
        const section = document.querySelector(link.getAttribute('href'));
        if (section) {
            sectionsToObserve.push(section.closest('section'));
        }
    });

    if (sectionsToObserve.length === 0) return;

    const observer = new IntersectionObserver((entries) => {
        if (isScrollSpyPaused) return;

        let bestVisible = null;
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                if (!bestVisible || entry.intersectionRatio > bestVisible.intersectionRatio) {
                    bestVisible = entry;
                }
            }
        });

        if (bestVisible) {
            let linkToActivate;
            const headingInside = bestVisible.target.querySelector('h1, h2, h3, h4');

            if (bestVisible.target.id === 'interactive-examples') {
                const pathParts = window.location.pathname.split('/');
                const slug = pathParts[pathParts.length - 1];
                if (slug && slug !== 'guides') {
                    linkToActivate = sidebar.querySelector(`a[href="/guides/${slug}"]`);
                } else {
                    linkToActivate = sidebar.querySelector('a[href^="/guides/"]');
                }
            } else if (headingInside) {
                linkToActivate = sidebar.querySelector(`a[href="#${headingInside.id}"]`);
            }

            if (linkToActivate) {
                setActiveSidebarLink(sidebar, linkToActivate);
            }
        }
    }, {
        threshold: [0, 0.2, 0.4, 0.6, 0.8, 1],
        rootMargin: "-80px 0px -40% 0px"
    });

    sectionsToObserve.forEach(section => {
        if (section) observer.observe(section)
    });
}

document.addEventListener('DOMContentLoaded', function () {
    const editorEl = document.getElementById('kreplica-editor');
    if (editorEl && !window.kreplicaEditor && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }
    initScrollSpy();
    scrollToActiveExample();
});