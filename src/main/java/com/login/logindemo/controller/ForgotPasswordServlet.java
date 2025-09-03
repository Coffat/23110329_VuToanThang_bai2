package com.login.logindemo.controller;

import com.login.logindemo.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * ForgotPasswordServlet handles password reset requests
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    /**
     * Handle GET requests - display forgot password form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is already logged in
        if (request.getSession(false) != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Forward to forgot password page
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
    
    /**
     * Handle POST requests - process password reset
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response encoding for Vietnamese characters
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if ("check-email".equals(action)) {
            handleEmailCheck(request, response);
        } else if ("reset-password".equals(action)) {
            handlePasswordReset(request, response);
        } else {
            // Default action is check email
            handleEmailCheck(request, response);
        }
    }
    
    /**
     * Handle email verification step
     */
    private void handleEmailCheck(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        // Validate email input
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Check if email exists
        if (!userService.isEmailExists(email.trim())) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống");
            request.setAttribute("email", email);
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Email exists, proceed to password reset form
        request.setAttribute("email", email.trim());
        request.setAttribute("step", "reset");
        request.setAttribute("success", "Email hợp lệ! Vui lòng nhập mật khẩu mới.");
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
    
    /**
     * Handle password reset step
     */
    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        String validationError = userService.validatePasswordResetInput(email, newPassword, confirmPassword);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("email", email);
            request.setAttribute("step", "reset");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Reset password
        boolean success = userService.resetPassword(email, newPassword, confirmPassword);
        
        if (success) {
            // Password reset successful
            request.setAttribute("success", "Mật khẩu đã được đổi thành công! Vui lòng đăng nhập với mật khẩu mới.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Password reset failed
            request.setAttribute("error", "Đổi mật khẩu thất bại! Vui lòng thử lại.");
            request.setAttribute("email", email);
            request.setAttribute("step", "reset");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }
}
