/* ---------------------------------------------------------
   Custom JS for MkDocs Material
   --------------------------------------------------------- */

/* Smooth scroll for internal links */
document.addEventListener("DOMContentLoaded", function () {
    const links = document.querySelectorAll('a[href^="#"]');
    for (const link of links) {
        link.addEventListener("click", function (e) {
            const target = document.querySelector(this.getAttribute("href"));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: "smooth" });
            }
        });
    }
});

/* Add a console message for fun */
console.log("%cMkDocs site loaded successfully!", "color: #4CAF50; font-size: 14px;");