@param String label
@param boolean isActive = false
@param String hxGet
@param String hxTarget
@param String hxPushUrl = null
@param String hxIndicator = null
@param String hxSwap = "innerHTML"

<button role="tab"
        aria-selected="${isActive}"
        class="${isActive ? "active" : ""}"
        hx-get="${hxGet}"
        hx-target="${hxTarget}"
        hx-push-url="${hxPushUrl}"
        hx-indicator="${hxIndicator}"
        hx-swap="${hxSwap}">
    ${label}
</button>