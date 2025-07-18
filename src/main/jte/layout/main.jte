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
    <header class="main-header">
        <div class="nav-container">
            <a href="/" class="nav-logo"
               hx-get="/"
               hx-target=".main-content"
               hx-push-url="true"
               hx-indicator=".page-progress">KReplica</a>
            <nav>
                <ul class="nav-links">
                    <li><a href="/"
                           class="${currentPage == "index" ? "active" : ""}"
                           hx-get="/"
                           hx-target=".main-content"
                           hx-push-url="true"
                           hx-indicator=".page-progress">Home</a></li>
                    <li><a href="/getting-started"
                           class="${currentPage == "getting-started" ? "active" : ""}"
                           hx-get="/getting-started"
                           hx-target=".main-content"
                           hx-push-url="true"
                           hx-indicator=".page-progress">Getting Started</a></li>
                    <li><a href="/concepts"
                           class="${currentPage == "concepts" ? "active" : ""}"
                           hx-get="/concepts"
                           hx-target=".main-content"
                           hx-push-url="true"
                           hx-indicator=".page-progress">Core Concepts</a></li>
                    <li><a href="/examples"
                           class="${currentPage == "examples" ? "active" : ""}"
                           hx-get="/examples"
                           hx-target=".main-content"
                           hx-push-url="true"
                           hx-indicator=".page-progress">Examples</a></li>
                    <li><a href="/faq"
                           class="${currentPage == "faq" ? "active" : ""}"
                           hx-get="/faq"
                           hx-target=".main-content"
                           hx-push-url="true"
                           hx-indicator=".page-progress">FAQ</a></li>
                </ul>
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
                <a href="https://github.com/your-repo/kreplica" target="_blank">GitHub</a>
                <a href="/concepts">Core Concepts</a>
                <a href="/examples">Examples</a>
            </div>
        </div>
    </footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js"></script>
</body>
</html>