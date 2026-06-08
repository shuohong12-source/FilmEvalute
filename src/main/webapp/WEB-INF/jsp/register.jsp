<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>注册 - 电影评分系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp"/>
<main class="container narrow">
    <h1>用户注册</h1>
    <jsp:include page="common/messages.jsp"/>
    <form class="panel form" method="post" action="${ctx}/register">
        <label>用户名
            <input type="text" name="username" required>
        </label>
        <label>密码
            <input type="password" name="password" required>
        </label>
        <button class="primary" type="submit">注册</button>
        <p>已有账号？<a href="${ctx}/login">去登录</a></p>
    </form>
</main>
</body>
</html>
