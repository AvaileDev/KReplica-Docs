(function () {
    window.initKReplicaPlayground = function () {
        if (window.kreplicaEditor) {
            return;
        }
        require.config({paths: {vs: 'https://unpkg.com/monaco-editor@0.45.0/min/vs'}});
        require(['vs/editor/editor.main'], function () {
            var KREPLICA_COMPLETIONS = [
                {
                    label: '@Replicate.Model',
                    insertText: '@Replicate.Model(',
                    kind: monaco.languages.CompletionItemKind.Keyword
                },
                {
                    label: '@Replicate.Property',
                    insertText: '@Replicate.Property(',
                    kind: monaco.languages.CompletionItemKind.Keyword
                },
                {
                    label: '@Replicate.SchemaVersion',
                    insertText: '@Replicate.SchemaVersion(',
                    kind: monaco.languages.CompletionItemKind.Keyword
                },
                {
                    label: '@Replicate.Apply',
                    insertText: '@Replicate.Apply(',
                    kind: monaco.languages.CompletionItemKind.Keyword
                },
                {
                    label: '@Replicate.Hide',
                    insertText: '@Replicate.Hide',
                    kind: monaco.languages.CompletionItemKind.Keyword
                },
                {
                    label: 'DtoVariant.DATA',
                    insertText: 'DtoVariant.DATA',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'DtoVariant.CREATE',
                    insertText: 'DtoVariant.CREATE',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'DtoVariant.PATCH',
                    insertText: 'DtoVariant.PATCH',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'NominalTyping.ENABLED',
                    insertText: 'NominalTyping.ENABLED',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'NominalTyping.DISABLED',
                    insertText: 'NominalTyping.DISABLED',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'AutoContextual.ENABLED',
                    insertText: 'AutoContextual.ENABLED',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'AutoContextual.DISABLED',
                    insertText: 'AutoContextual.DISABLED',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'Patchable.Unchanged',
                    insertText: 'Patchable.Unchanged',
                    kind: monaco.languages.CompletionItemKind.EnumMember
                },
                {
                    label: 'Patchable.Set',
                    insertText: 'Patchable.Set(',
                    kind: monaco.languages.CompletionItemKind.Function
                },
                {
                    label: 'KReplicaDataVariant',
                    insertText: 'KReplicaDataVariant',
                    kind: monaco.languages.CompletionItemKind.Interface
                },
                {
                    label: 'KReplicaCreateVariant',
                    insertText: 'KReplicaCreateVariant',
                    kind: monaco.languages.CompletionItemKind.Interface
                },
                {
                    label: 'KReplicaPatchVariant',
                    insertText: 'KReplicaPatchVariant',
                    kind: monaco.languages.CompletionItemKind.Interface
                }
            ];
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
    };
})();