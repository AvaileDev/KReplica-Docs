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

                    window.kreplicaEditor = monaco.editor.create(document.getElementById('kreplica-editor'), {
                        value: initialCode,
                        language: 'kotlin',
                        automaticLayout: true,
                        theme: 'vs-dark',
                        minimap: {enabled: false}
                    });

                    monaco.languages.registerCompletionItemProvider('kotlin', {
                        triggerCharacters: ['@', '.'],
                        provideCompletionItems: function () {
                            return {suggestions: KREPLICA_COMPLETIONS};
                        }
                    });

                    if (hiddenTextarea) {
                        window.kreplicaEditor.onDidChangeModelContent(function () {
                            hiddenTextarea.value = window.kreplicaEditor.getValue();
                        });
                    }
                });
        });
    };
})();