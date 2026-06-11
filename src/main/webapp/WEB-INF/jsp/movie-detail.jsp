<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${movie.title} - 电影评分系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp"/>
<main class="container">
    <jsp:include page="common/messages.jsp"/>
    <section class="detail">
        <img class="poster" src="${empty movie.posterUrl ? ctx.concat('/static/css/poster-placeholder.svg') : movie.posterUrl}" alt="${movie.title}">
        <div>
            <h1>${movie.title}</h1>
            <c:set var="score" value="${averageScore}" scope="request"/>
            <c:set var="scorePercent" value="${scorePercent}" scope="request"/>
            <jsp:include page="common/rating.jsp"/>
            <p><strong>导演：</strong>${movie.director}</p>
            <p><strong>主演：</strong>${movie.actors}</p>
            <p><strong>类型：</strong>${movie.genre}</p>
            <p><strong>上映年份：</strong>${movie.releaseYear}</p>
            <p class="description">${movie.description}</p>
        </div>
    </section>

    <section class="panel">
        <h2>评分</h2>
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <p>登录后可以给影片评分。</p>
                <a class="button-link" href="${ctx}/login">去登录</a>
            </c:when>
            <c:otherwise>
                <form class="rating-form" method="post" action="${ctx}/movies/${movie.id}/ratings">
                    <input id="scoreInput" type="hidden" name="score" value="${empty userRating ? 0 : userRating.score}">
                    <div>
                        <strong>我的评分</strong>
                        <div class="rate-stars" data-current="${empty userRating ? 0 : userRating.score}">
                            <button type="button" class="rate-star" data-score="2" aria-label="2 分">★</button>
                            <button type="button" class="rate-star" data-score="4" aria-label="4 分">★</button>
                            <button type="button" class="rate-star" data-score="6" aria-label="6 分">★</button>
                            <button type="button" class="rate-star" data-score="8" aria-label="8 分">★</button>
                            <button type="button" class="rate-star" data-score="10" aria-label="10 分">★</button>
                        </div>
                        <p class="rate-hint">
                            <span id="scoreText">
                                <c:choose>
                                    <c:when test="${empty userRating}">请选择评分</c:when>
                                    <c:otherwise>${userRating.score} 分</c:otherwise>
                                </c:choose>
                            </span>
                        </p>
                    </div>
                    <button class="primary" type="submit">提交评分</button>
                </form>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="panel">
        <h2>发表评论</h2>
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <p>登录后可以发表评论。</p>
            </c:when>
            <c:otherwise>
                <form class="form" method="post" action="${ctx}/movies/${movie.id}/comments">
                    <textarea name="content" rows="4" required placeholder="写下你的看法"></textarea>
                    <button class="primary" type="submit">发布评论</button>
                </form>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="panel">
        <h2>评论列表</h2>
        <c:forEach items="${comments}" var="comment">
            <article class="comment">
                <strong>${comment.nickname}</strong>
                <p>${comment.content}</p>
                <small>${comment.createdAt}</small>
            </article>
        </c:forEach>
        <c:if test="${empty comments}">
            <p class="empty">暂无评论。</p>
        </c:if>
    </section>
</main>
<script src="${ctx}/static/js/rating.js"></script>
</body>
</html>
