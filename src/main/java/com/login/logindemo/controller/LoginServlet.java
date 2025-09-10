package com.login.logindemo.controller;

import com.login.logindemo.model.User;
import com.login.logindemo.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LoginServlet handles user authentication requests
 * Follows MVC pattern as the Controller layer
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    /**
     * Handle GET requests - display login form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/logout":
                handleLogout(request, response);
                break;
            case "/login":
            default:
                showLoginForm(request, response);
                break;
        }
    }
    
    /**
     * Handle POST requests - process login
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        if ("/login".equals(action)) {
            handleLogin(request, response);
        } else {
            response.sendRedirect("login");
        }
    }
    
    /**
     * Show login form
     */
    private void showLoginForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
                    // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
            
            // Forward to login page
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in showLoginForm: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error: " + e.getMessage());
        }
    }
    
    /**
     * Handle login authentication
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response encoding for Vietnamese characters
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Set content type
        response.setContentType("text/html; charset=UTF-8");
        
        // Get login parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        // Validate input
        String validationError = userService.validateLoginInput(username, password);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("username", username); // Preserve username
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userService.authenticateUser(username, password);
        
        if (user != null) {
            // Login successful
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullname", user.getFullname());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("roleid", user.getRoleid());
            session.setAttribute("rolename", userService.getRoleName(user.getRoleid()));
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Set session creation time
            session.setAttribute("loginTime", new java.util.Date());
            
            // Handle "Remember Me" functionality
            if ("on".equals(remember)) {
                // In a real application, you would set cookies here
                // For this demo, we'll just extend the session timeout
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
            }
            
            // Log successful login
            System.out.println("User logged in successfully: " + user.getUsername() + 
                             " at " + new java.util.Date());
            
            // Redirect to home page
            response.sendRedirect(request.getContextPath() + "/");
            
        } else {
            // Login failed
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.setAttribute("username", username); // Preserve username
            
            // Log failed login attempt
            System.out.println("Failed login attempt for username: " + username + 
                             " at " + new java.util.Date());
            
            // Forward back to login page with error
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle logout
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            String username = (String) session.getAttribute("username");
            
            // Invalidate session
            session.invalidate();
            
            // Log logout
            System.out.println("User logged out: " + username + " at " + new java.util.Date());
        }
        
        // Redirect to login page with logout message
        request.setAttribute("message", "Bạn đã đăng xuất thành công!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
