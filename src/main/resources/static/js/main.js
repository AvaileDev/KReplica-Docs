document.body.addEventListener('htmx:afterSwap', function (evt) {
    Prism.highlightAllUnder(evt.detail.elt);
    initScrollSpy();

    const requestPath = new URL(evt.detail.xhr.responseURL).pathname;
    if (requestPath.startsWith('/guides')) {
        setTimeout(() => scrollToActiveExample(), 0);
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

function scrollToActiveExample() {
    const onGuidesPage = document.querySelector('.examples-container');
    const activeExampleLink = document.querySelector('.examples-sidebar a[href^="/guides/"][class="active"]');

    if (onGuidesPage && activeExampleLink) {
        document.getElementById('interactive-examples')?.scrollIntoView();
    }
}

function initScrollSpy() {
    const sidebar = document.getElementById('guide-sidebar-links');
    if (!sidebar) return;

    const sectionLinks = sidebar.querySelectorAll('a[href^="#"]');
    const exampleLinks = sidebar.querySelectorAll('a[href^="/guides/"]');
    const sections = [];

    sectionLinks.forEach(link => {
        const section = document.querySelector(link.getAttribute('href'));
        if (section) {
            sections.push(section);
        }
    });

    if (sections.length === 0) return;

    const observer = new IntersectionObserver((entries) => {
        let bestVisible = null;
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                if (!bestVisible || entry.intersectionRatio > bestVisible.intersectionRatio) {
                    bestVisible = entry;
                }
            }
        });

        if (bestVisible) {
            sectionLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === `#${bestVisible.target.id}`) {
                    link.classList.add('active');
                }
            });

            if (bestVisible.target.id !== 'interactive-examples') {
                exampleLinks.forEach(link => link.classList.remove('active'));
            }
        }
    }, {
        threshold: [0, 0.25, 0.5, 0.75, 1],
        rootMargin: "-65px 0px -40% 0px"
    });

    sections.forEach(section => observer.observe(section));

    const anyExampleActive = Array.from(exampleLinks).some(link => link.classList.contains('active'));
    if (anyExampleActive) {
        sectionLinks.forEach(link => link.classList.remove('active'));
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