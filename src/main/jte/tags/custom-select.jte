@param String label
@param String id
@param java.util.List<io.availe.kreplicadocs.model.view.SelectOption> options
@param String hxGet
@param String hxTarget
@param String hxPushUrl = null
@param String hxIndicator
@param String hxSwap = "innerHTML"

<div class="custom-select-wrapper">
    <label for="${id}">${label}</label>
    <select id="${id}"
            hx-get="${hxGet}"
            hx-target="${hxTarget}"
            hx-push-url="${hxPushUrl}"
            hx-indicator="${hxIndicator}"
            hx-swap="${hxSwap}">
        @for(var option : options)
            <option value="${option.getValue()}" selected="${option.getSelected()}">
                ${option.getLabel()}
            </option>
        @endfor
    </select>
</div>