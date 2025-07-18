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
</head>
<body>
<div class="page-wrapper">
    <header class="main-header">
        <div class="nav-container">
            <a href="/" class="nav-logo">KReplica</a>
            <nav>
                <ul class="nav-links">
                    <li><a href="/" class="${currentPage == "index" ? "active" : ""}">Home</a></li>
                    <li><a href="/getting-started" class="${currentPage == "getting-started" ? "active" : ""}">Getting Started</a></li>
                    <li><a href="/concepts" class="${currentPage == "concepts" ? "active" : ""}">Core Concepts</a></li>
                    <li><a href="/examples" class="${currentPage == "examples" ? "active" : ""}">Examples</a></li>
                    <li><a href="/faq" class="${currentPage == "faq" ? "active" : ""}">FAQ</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="main-content">
        ${content}
    </main>

    <footer class="main-footer">
        <p>&copy; ${java.time.Year.now().getValue()} KReplica Project. All rights reserved.</p>
    </footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js"></script>
</body>
</html>