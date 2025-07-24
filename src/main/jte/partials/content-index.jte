@param io.availe.kreplicadocs.model.view.IndexViewModel vm

<div class="hero-section">
    <h1>DTO generation for Kotlin CRUD APIs</h1>
    <p>KReplica generates Kotlin code from interfaces, with explicit control over Create, Data, and Patch variants.</p>
</div>

<h2>Get Started in 60 Seconds</h2>
<p>Add the KSP and KReplica plugins to your module's <code>build.gradle.kts</code> file to start generating DTOs
    automatically.</p>

@template.tags.code(language = "kotlin", content = @`
    plugins {
    id("com.google.devtools.ksp") version "..."
    id("io.availe.kreplica") version "5.0.0"
    }
`)

@if(vm.getFeatureExample() != null)
    <div class="feature-highlight">
        <h2>The Core Workflow</h2>

        <div class="workflow-container" x-data="{ activeStep: 1 }">
            <div class="workflow-tabs" role="tablist">
                @for(var step : vm.getFeatureExample().getFeatureTourSteps())
                    <button role="tab"
                            :class="{ 'active': activeStep === ${step.getPart()} }"
                            @click="activeStep = ${step.getPart()}">
                        ${step.getTitle()}
                    </button>
                @endfor
            </div>

            @for(var step : vm.getFeatureExample().getFeatureTourSteps())
                <div class="workflow-content" x-show="activeStep === ${step.getPart()}" x-cloak>
                    <p>${step.getDescription()}</p>
                    @if(step.getSubSteps().isEmpty())
                        @template.tags.code(language="kotlin", content=@`${vm.getFeatureExample().getContent(step.getFileName())}`)
                    @else
                        <div class="sub-workflow-container"
                             x-data="{ activeSubStep: '${step.getSubSteps().get(0).getFileName()}' }">
                            <div class="playground-tabs" role="tablist">
                                @for(var subStep : step.getSubSteps())
                                    <button role="tab"
                                            :class="{ 'active': activeSubStep === '${subStep.getFileName()}' }"
                                            @click="activeSubStep = '${subStep.getFileName()}'">
                                        ${subStep.getTitle()}
                                    </button>
                                @endfor
                            </div>
                            @for(var subStep : step.getSubSteps())
                                <div x-show="activeSubStep === '${subStep.getFileName()}'" x-cloak>
                                    <p class="sub-step-description">${subStep.getDescription()}</p>
                                    @template.tags.code(language="kotlin", content=@`${vm.getFeatureExample().getContent(subStep.getFileName())}`)
                                </div>
                            @endfor
                        </div>
                    @endif
                </div>
            @endfor
        </div>

        <div class="tour-cta">
            <a href="/guides"
               class="button-primary"
               hx-get="/guides"
               hx-target=".main-content"
               hx-push-url="/guides"
               hx-indicator=".page-progress">See More in the Guides</a>
        </div>
    </div>
@endif