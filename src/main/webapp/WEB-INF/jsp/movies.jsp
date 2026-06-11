<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>影片列表 - 电影评分系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp"/>
<main class="container">
    <section class="page-head">
        <div>
            <h1>影片列表</h1>
            <p>查看影片信息、评分和评论。</p>
        </div>
        <form class="search" method="get" action="${ctx}/movies">
            <input type="text" name="keyword" value="${keyword}" placeholder="搜索片名、导演、类型">
            <button type="submit">搜索</button>
        </form>
    </section>
    <jsp:include page="common/messages.jsp"/>
    <div class="movie-grid">
        <c:forEach items="${movies}" var="movie">
            <article class="movie-card">
                <img src="${empty movie.posterUrl ? ctx.concat('/static/css/poster-placeholder.svg') : movie.posterUrl}" alt="${movie.title}">
                <div>
                    <h2><a href="${ctx}/movies/${movie.id}">${movie.title}</a></h2>
                    <c:set var="score" value="${movie.averageScore}" scope="request"/>
                    <c:set var="scorePercent" value="${movie.scorePercent}" scope="request"/>
                    <jsp:include page="common/rating.jsp"/>
                    <p>导演：${movie.director}</p>
                    <p>类型：${movie.genre}</p>
                    <p>上映年份：${movie.releaseYear}</p>
                    <a class="button-link" href="${ctx}/movies/${movie.id}">查看详情</a>
                </div>
            </article>
        </c:forEach>
        <c:if test="${empty movies}">
            <p class="empty">暂无影片。</p>
        </c:if>
    </div>
</main>
</body>
</html>
