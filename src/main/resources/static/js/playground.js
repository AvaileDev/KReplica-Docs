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

                    var hidden = document.querySelector('textarea[name="source"]');
                    var initialCode = hidden ? hidden.value : '';

                    window.kreplicaEditor = monaco.editor.create(document.getElementById('kreplica-editor'), {
                        value: initialCode,
                        language: 'kotlin',
                        automaticLayout: true
                    });
                    monaco.languages.registerCompletionItemProvider('kotlin', {
                        triggerCharacters: ['@', '.'],
                        provideCompletionItems: function () {
                            return {suggestions: KREPLICA_COMPLETIONS};
                        }
                    });
                    if (hidden) {
                        var sync = function () {
                            hidden.value = window.kreplicaEditor.getValue();
                        };
                        window.kreplicaEditor.onDidChangeModelContent(sync);
                        sync();
                    }
                });
        });
    };
})();