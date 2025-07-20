document.body.addEventListener('htmx:afterSwap', function (evt) {
    Prism.highlightAllUnder(evt.detail.elt);
});

document.body.addEventListener('htmx:beforeSwap', function (evt) {
    if (window.kreplicaEditor) {
        window.kreplicaEditor.dispose();
        window.kreplicaEditor = null;
    }
});

document.body.addEventListener('htmx:afterSwap', function (e) {
    if (document.getElementById('kreplica-editor') && !window.kreplicaEditor && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }
});

document.addEventListener('DOMContentLoaded', function () {
    if (document.getElementById('kreplica-editor') && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }
});

document.addEventListener('click', function (e) {
    const link = e.target.closest('#examples-sidebar-links a[href^="#"]');
    if (!link) return;

    const container = document.getElementById('examples-sidebar-links');
    if (!container) return;

    container.querySelectorAll('a.active').forEach(function (a) {
        a.classList.remove('active');
    });
    link.classList.add('active');
});