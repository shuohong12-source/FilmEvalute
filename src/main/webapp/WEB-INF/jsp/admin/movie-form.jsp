<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>影片表单 - 电影评分系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<main class="container narrow">
    <h1>影片信息</h1>
    <jsp:include page="../common/messages.jsp"/>
    <form class="panel form" method="post" action="${ctx}${action}">
        <label>片名
            <input type="text" name="title" value="${movie.title}" required>
        </label>
        <label>导演
            <input type="text" name="director" value="${movie.director}">
        </label>
        <label>主演
            <input type="text" name="actors" value="${movie.actors}">
        </label>
        <label>类型
            <input type="text" name="genre" value="${movie.genre}">
        </label>
        <label>上映年份
            <input type="number" name="releaseYear" value="${movie.releaseYear}">
        </label>
        <label>海报地址
            <input type="text" name="posterUrl" value="${movie.posterUrl}">
        </label>
        <label>简介
            <textarea name="description" rows="5">${movie.description}</textarea>
        </label>
        <button class="primary" type="submit">保存</button>
    </form>
</main>
</body>
</html>
