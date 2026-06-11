<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="score-line">
    <span class="stars" aria-label="评分">
        <span class="stars-back">★★★★★</span>
        <span class="stars-front" style="width: ${scorePercent}%;">★★★★★</span>
    </span>
    <strong>${score}</strong>
    <span>/ 10</span>
</div>
