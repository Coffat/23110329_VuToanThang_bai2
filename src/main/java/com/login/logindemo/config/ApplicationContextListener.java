package com.login.logindemo.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Application Context Listener to handle application lifecycle events
 * Manages database connection pool initialization and cleanup
 */
@WebListener
public class ApplicationContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=== Application Starting ===");
        System.out.println("Java Version: " + System.getProperty("java.version"));
        System.out.println("Tomcat Version: 11.0.10");
        System.out.println("Initializing database connection pool...");
        
        try {
            // Test database connection on startup
            if (DBConnection.testConnection()) {
                System.out.println("Database connection test: SUCCESS");
            } else {
                System.err.println("WARNING: Database connection test: FAILED");
                System.err.println("Application will continue but database operations may fail");
                System.err.println("Please check:");
                System.err.println("1. SQL Server is running on localhost:1433");
                System.err.println("2. Database 'BT2' exists");
                System.err.println("3. User 'sa' with password 'Admin@123' has access");
            }
        } catch (Exception e) {
            System.err.println("ERROR during application startup: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("=== Application Started Successfully ===");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=== Application Shutting Down ===");
        
        // Shutdown database connection pool
        System.out.println("Shutting down database connection pool...");
        DBConnection.shutdownPool();
        
        System.out.println("=== Application Shutdown Complete ===");
    }
}
