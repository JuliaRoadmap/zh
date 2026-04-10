document.addEventListener('DOMContentLoaded', function() {
    var article = document.querySelector('#documenter .docs-main article.content');
    if (!article) return;

    var container = document.createElement('div');
    container.className = 'giscus';
    container.style.marginTop = '2em';
    article.appendChild(container);

    var script = document.createElement('script');
    script.src = 'https://giscus.app/client.js';
    script.setAttribute('data-repo', 'JuliaRoadmap/zh');
    script.setAttribute('data-repo-id', 'R_kgDOHQYI2Q');
    script.setAttribute('data-category-id', 'DIC_kwDOHQYI2c4CO2c9');
    script.setAttribute('data-mapping', 'pathname');
    script.setAttribute('data-strict', '0');
    script.setAttribute('data-reactions-enabled', '1');
    script.setAttribute('data-emit-metadata', '0');
    script.setAttribute('data-input-position', 'bottom');
    script.setAttribute('data-theme', 'preferred_color_scheme');
    script.setAttribute('data-lang', 'zh-CN');
    script.setAttribute('crossorigin', 'anonymous');
    script.async = true;
    article.appendChild(script);
});
