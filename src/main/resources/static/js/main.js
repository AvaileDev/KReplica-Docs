document.body.addEventListener('htmx:afterSwap', function (evt) {
    Prism.highlightAllUnder(evt.detail.elt);
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

document.addEventListener('DOMContentLoaded', function () {
    if (document.getElementById('kreplica-editor') && typeof window.initKReplicaPlayground === 'function') {
        window.initKReplicaPlayground();
    }
});