@param java.util.Map<String, String> files

<div x-data="{ activeTab: '${files.entrySet().stream().findFirst().get().getKey()}' }">
    <div class="playground-tabs" role="tablist">
        @for(var entry : files.entrySet())
            <button role="tab"
                    :class="activeTab === '${entry.getKey()}' ? 'active' : ''"
                    @click="activeTab = '${entry.getKey()}'">
                ${entry.getKey()}
            </button>
        @endfor
    </div>

    <div class="playground-content">
        @for(var entry : files.entrySet())
            <div x-show="activeTab === '${entry.getKey()}'" x-cloak>
                @template.tags.code(language="kotlin", content=@`${entry.getValue()}`)
            </div>
        @endfor
    </div>
</div>