@param gg.jte.Content content
@param String title = "KReplica Docs"
@param String currentPage = null

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css">
    <script src="https://unpkg.com/htmx.org@1.9.12"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <header class="main-header" x-data="{ isOpen: false }" @keydown.escape.window="isOpen = false">
        <div class="nav-container">
            <a href="/" class="nav-logo"
               hx-get="/"
               hx-target=".main-content"
               hx-push-url="true"
               hx-indicator=".page-progress">KReplica</a>

            <button type="button" class="hamburger-button" @click="isOpen = !isOpen" aria-label="Toggle Menu">
                <svg x-show="!isOpen" class="hamburger-icon" xmlns="http://www.w3.org/2000/svg" height="24px"
                     viewBox="0 0 24 24" width="24px">
                    <path d="M0 0h24v24H0z" fill="none"/>
                    <path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"/>
                </svg>
                <svg x-show="isOpen" class="hamburger-icon" xmlns="http://www.w3.org/2000/svg" height="24px"
                     viewBox="0 0 24 24" width="24px" style="display: none;">
                    <path d="M0 0h24v24H0z" fill="none"/>
                    <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/>
                </svg>
            </button>

            <div class="nav-menu-container"
                 x-show="isOpen"
                 x-transition
                 @click.outside="isOpen = false"
                 style="display: none;">
                <nav class="main-nav" id="mobile-nav-links">
                    @template.fragments.nav-links(currentPage = currentPage, isMobile = true)
                </nav>
            </div>

            <nav class="desktop-nav" id="desktop-nav-links">
                @template.fragments.nav-links(currentPage = currentPage, isMobile = false)
            </nav>

        </div>
        <div class="page-progress htmx-indicator"></div>
    </header>

    <main class="main-content">
        ${content}
    </main>

    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-brand">
                <a href="/" class="nav-logo">KReplica</a>
                <p>&copy; ${java.time.Year.now().getValue()} KReplica Project. All rights reserved.</p>
            </div>
            <div class="footer-links">
                <a href="https://github.com/your-repo/kreplica" target="_blank" rel="noreferrer">GitHub</a>
                <a href="https://github.com/your-repo/kreplica/issues" target="_blank" rel="noreferrer">Report an
                    Issue</a>
                <a href="https://www.availe.io" target="_blank" rel="noreferrer">Personal Website</a>
            </div>
        </div>
    </footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js"></script>
<script>
    document.body.addEventListener('htmx:afterSwap', function (evt) {
        Prism.highlightAllUnder(evt.detail.elt);
    });
</script>
</body>
</html>