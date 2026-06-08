<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<header class="topbar">
    <a class="brand" href="${ctx}/movies">电影评分系统</a>
    <nav>
        <a href="${ctx}/movies">影片列表</a>
        <c:if test="${sessionScope.loginUser.role == 'ADMIN'}">
            <a href="${ctx}/admin/movies">影片管理</a>
        </c:if>
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <a href="${ctx}/login">登录</a>
                <a href="${ctx}/register">注册</a>
            </c:when>
            <c:otherwise>
                <span>${sessionScope.loginUser.nickname}</span>
                <form class="inline-form" method="post" action="${ctx}/logout">
                    <button type="submit">退出</button>
                </form>
            </c:otherwise>
        </c:choose>
    </nav>
</header>
