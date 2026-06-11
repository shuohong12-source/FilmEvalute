<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>影片管理 - 电影评分系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<main class="container">
    <section class="page-head">
        <div>
            <h1>影片管理</h1>
            <p>管理员可以新增、修改、删除、查询影片。</p>
        </div>
        <a class="primary button-link" href="${ctx}/admin/movies/create">新增影片</a>
    </section>
    <jsp:include page="../common/messages.jsp"/>
    <form class="search" method="get" action="${ctx}/admin/movies">
        <input type="text" name="keyword" value="${keyword}" placeholder="搜索片名、导演、类型">
        <button type="submit">搜索</button>
    </form>
    <table class="table">
        <thead>
        <tr>
            <th>序号</th>
            <th>片名</th>
            <th>导演</th>
            <th>类型</th>
            <th>年份</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${movies}" var="movie" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${movie.title}</td>
                <td>${movie.director}</td>
                <td>${movie.genre}</td>
                <td>${movie.releaseYear}</td>
                <td class="actions">
                    <a href="${ctx}/admin/movies/${movie.id}/edit">编辑</a>
                    <form method="post" action="${ctx}/admin/movies/${movie.id}/delete">
                        <button type="submit" onclick="return confirm('确定删除这部影片吗？')">删除</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>
</body>
</html>
