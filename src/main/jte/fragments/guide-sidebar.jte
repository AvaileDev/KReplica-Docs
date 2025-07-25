@param io.availe.kreplicadocs.model.view.GuideViewModel vm

<div id="guide-sidebar-links">
    <h4>Guide Sections</h4>
    <ul>
        @for(var section : vm.getGuideNav())
            <li>
                <a href="#${section.getId()}">${section.getTitle()}</a>
                @if(!section.getSubsections().isEmpty())
                    <ul>
                        @for(var subsection : section.getSubsections())
                            <li>
                                <a href="#${subsection.getId()}">${subsection.getTitle()}</a>
                            </li>
                        @endfor
                    </ul>
                @endif
            </li>
        @endfor
    </ul>
</div>