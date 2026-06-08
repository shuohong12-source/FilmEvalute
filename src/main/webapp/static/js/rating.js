document.addEventListener("DOMContentLoaded", function () {
    var starBox = document.querySelector(".rate-stars");
    var scoreInput = document.getElementById("scoreInput");
    var scoreText = document.getElementById("scoreText");

    if (!starBox || !scoreInput || !scoreText) {
        return;
    }

    var stars = Array.prototype.slice.call(starBox.querySelectorAll(".rate-star"));
    var currentScore = parseInt(scoreInput.value || starBox.dataset.current || "0", 10);

    function paint(score) {
        stars.forEach(function (star) {
            var starScore = parseInt(star.dataset.score, 10);
            star.classList.toggle("active", starScore <= score);
        });
    }

    function choose(score) {
        currentScore = score;
        scoreInput.value = String(score);
        scoreText.textContent = score + " 分";
        paint(score);
    }

    stars.forEach(function (star) {
        var score = parseInt(star.dataset.score, 10);
        star.addEventListener("mouseenter", function () {
            paint(score);
            scoreText.textContent = score + " 分";
        });
        star.addEventListener("click", function () {
            choose(score);
        });
    });

    starBox.addEventListener("mouseleave", function () {
        paint(currentScore);
        scoreText.textContent = currentScore > 0 ? currentScore + " 分" : "请选择评分";
    });

    starBox.closest("form").addEventListener("submit", function (event) {
        if (parseInt(scoreInput.value || "0", 10) <= 0) {
            event.preventDefault();
            scoreText.textContent = "请先点击星星评分";
        }
    });

    paint(currentScore);
});
