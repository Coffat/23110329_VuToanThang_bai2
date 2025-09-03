package com.login.logindemo.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LogoutServlet handles user logout requests
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    
    /**
     * Handle GET requests - process logout
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processLogout(request, response);
    }
    
    /**
     * Handle POST requests - process logout
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processLogout(request, response);
    }
    
    /**
     * Process user logout
     */
    private void processLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response encoding for Vietnamese characters
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Get current session
        HttpSession session = request.getSession(false);
        
        String username = null;
        if (session != null) {
            // Get username before invalidating session for logging
            username = (String) session.getAttribute("username");
            
            // Invalidate the session
            session.invalidate();
            System.out.println("User logged out: " + (username != null ? username : "unknown"));
        }
        
        // Set success message for login page
        request.setAttribute("message", "Bạn đã đăng xuất thành công!");
        
        // Forward to login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
