<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>登录 - 电影评分系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp"/>
<main class="container narrow">
    <h1>用户登录</h1>
    <jsp:include page="common/messages.jsp"/>
    <form class="panel form" method="post" action="${ctx}/login">
        <label>用户名
            <input type="text" name="username" required>
        </label>
        <label>密码
            <input type="password" name="password" required>
        </label>
        <button class="primary" type="submit">登录</button>
        <p>没有账号？<a href="${ctx}/register">立即注册</a></p>
    </form>
</main>
</body>
</html>
