(function () {
    window.initKReplicaPlayground = function () {
        if (window.kreplicaEditor) {
            return;
        }

        require.config({paths: {vs: 'https://unpkg.com/monaco-editor@0.45.0/min/vs'}});
        require(['vs/editor/editor.main'], function () {
            fetch('/api/completions')
                .then(response => response.json())
                .then(completionsData => {
                    const KREPLICA_COMPLETIONS = completionsData.map(item => ({
                        label: item.label,
                        kind: monaco.languages.CompletionItemKind[item.kind] || monaco.languages.CompletionItemKind.Text,
                        insertText: item.insertText,
                        insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet
                    }));

                    const hiddenTextarea = document.querySelector('textarea[name="source"]');
                    const initialCode = hiddenTextarea ? hiddenTextarea.value : '';
                    const editorNode = document.getElementById('kreplica-editor');

                    window.kreplicaEditor = monaco.editor.create(
                        editorNode,
                        {
                            value: initialCode,
                            language: 'kotlin',
                            automaticLayout: true,
                            theme: 'vs-dark',
                            minimap: {enabled: false},
                            folding: true,
                            scrollBeyondLastLine: false
                        }
                    );

                    const updateEditorHeight = () => {
                        if (window.kreplicaEditor) {
                            const contentHeight = window.kreplicaEditor.getContentHeight();
                            editorNode.style.height = `${contentHeight}px`;
                        }
                    };

                    monaco.languages.registerCompletionItemProvider('kotlin', {
                        triggerCharacters: ['@', '.'],
                        provideCompletionItems: function () {
                            return {suggestions: KREPLICA_COMPLETIONS};
                        }
                    });

                    window.kreplicaEditor.onDidChangeModelContent(() => {
                        if (hiddenTextarea) {
                            hiddenTextarea.value = window.kreplicaEditor.getValue();
                        }
                        updateEditorHeight();
                    });

                    updateEditorHeight();
                });
        });
    };

    window.clearPlaygroundOutput = function() {
        const output = document.getElementById('playground-output');
        if (output) {
            output.innerHTML = '<div class="placeholder-text">Click "Run" to see the generated code.</div>';
        }
    };

    window.resetPlayground = function() {
        clearPlaygroundOutput();

        const editorArea = document.querySelector('.playground-editor-area');
        if (!editorArea) return;

        const slug = editorArea.dataset.templateSlug;
        if (!slug) return;

        const url = `/playground/templates?template-select=${slug}`;
        htmx.ajax('GET', url, { target: '#editor-source-container', swap: 'innerHTML' });
    };
})();