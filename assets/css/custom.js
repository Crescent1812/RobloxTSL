/* ---------------------------------------------------------
   Custom JS for MkDocs Material
   --------------------------------------------------------- */

/* Smooth scrolling for internal anchor links */
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

/* Add a subtle console message */
console.log(
    "%cDocumentation loaded successfully!",
    "color: #3f51b5; font-size: 14px; font-weight: bold;"
);

/* Optional: Back-to-top button (auto-injected) */
document.addEventListener("DOMContentLoaded", function () {
    const btn = document.createElement("div");
    btn.id = "back-to-top";
    btn.innerHTML = "↑";
    btn.style.position = "fixed";
    btn.style.bottom = "20px";
    btn.style.right = "20px";
    btn.style.width = "40px";
    btn.style.height = "40px";
    btn.style.background = "#3f51b5";
    btn.style.color = "white";
    btn.style.borderRadius = "50%";
    btn.style.display = "flex";
    btn.style.alignItems = "center";
    btn.style.justifyContent = "center";
    btn.style.cursor = "pointer";
    btn.style.boxShadow = "0 4px 10px rgba(0,0,0,0.2)";
    btn.style.opacity = "0";
    btn.style.transition = "opacity 0.3s";
    document.body.appendChild(btn);

    window.addEventListener("scroll", () => {
        btn.style.opacity = window.scrollY > 300 ? "1" : "0";
    });

    btn.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });
});