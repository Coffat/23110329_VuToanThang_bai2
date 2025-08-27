package com.login.logindemo;

import com.login.logindemo.config.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Test Servlet to diagnose issues
 */
@WebServlet("/test")
public class TestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Test Page</title></head><body>");
        out.println("<h1>Test Page - Login Demo</h1>");
        
        // Test 1: Basic Servlet
        out.println("<h2>Test 1: Servlet Working</h2>");
        out.println("<p style='color: green;'>✅ Servlet is working correctly!</p>");
        
        // Test 2: Database Connection
        out.println("<h2>Test 2: Database Connection</h2>");
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                out.println("<p style='color: green;'>✅ Database connection successful!</p>");
                out.println("<p>Database: " + conn.getMetaData().getDatabaseProductName() + "</p>");
                out.println("<p>Version: " + conn.getMetaData().getDatabaseProductVersion() + "</p>");
                DBConnection.returnConnection(conn);
            } else {
                out.println("<p style='color: red;'>❌ Database connection failed!</p>");
            }
        } catch (SQLException e) {
            out.println("<p style='color: red;'>❌ Database connection error: " + e.getMessage() + "</p>");
            out.println("<p>SQL State: " + e.getSQLState() + "</p>");
            out.println("<p>Error Code: " + e.getErrorCode() + "</p>");
        }
        
        // Test 3: System Info
        out.println("<h2>Test 3: System Information</h2>");
        out.println("<p>Java Version: " + System.getProperty("java.version") + "</p>");
        out.println("<p>Java Home: " + System.getProperty("java.home") + "</p>");
        out.println("<p>User Directory: " + System.getProperty("user.dir") + "</p>");
        
        // Test 4: Links
        out.println("<h2>Test 4: Application Links</h2>");
        out.println("<p><a href='login.jsp'>Login Page</a></p>");
        out.println("<p><a href='index.jsp'>Index Page</a></p>");
        
        out.println("</body></html>");
    }
}
