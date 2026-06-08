package com.example.filmevaluate.config;

import com.example.filmevaluate.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getServletPath();
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        if (uri.startsWith("/admin") && !"ADMIN".equals(loginUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return false;
        }
        return true;
    }
}
