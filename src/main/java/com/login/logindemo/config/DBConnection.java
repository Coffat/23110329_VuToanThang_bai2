package com.login.logindemo.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

/**
 * Database connection utility class for SQL Server with connection pooling
 * Follows the configuration specified: username=sa, password=Admin@123, database=BT2
 */
public class DBConnection {
    // Database connection parameters
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=BT2;encrypt=false;trustServerCertificate=true;integratedSecurity=false;loginTimeout=30;autoReconnect=true;applicationName=LoginDemo";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "Admin@123";
    
    // Driver class name
    private static final String DRIVER_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    
    // Connection pool settings
    private static final int POOL_SIZE = 10;
    private static final BlockingQueue<Connection> connectionPool = new ArrayBlockingQueue<>(POOL_SIZE);
    private static volatile boolean poolInitialized = false;
    
    // Static initialization block to load driver once
    static {
        try {
            Class.forName(DRIVER_CLASS);
            System.out.println("SQL Server JDBC Driver loaded successfully in static block!");
            initializeConnectionPool();
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load SQL Server JDBC Driver in static block: " + e.getMessage());
        }
    }
    
    /**
     * Initialize connection pool
     */
    private static void initializeConnectionPool() {
        if (poolInitialized) return;
        
        try {
            // Try to create at least one connection to test
            Connection testConn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            connectionPool.offer(testConn);
            
            // If successful, create more connections
            for (int i = 1; i < POOL_SIZE; i++) {
                try {
                    Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                    connectionPool.offer(conn);
                } catch (SQLException e) {
                    System.err.println("Failed to create connection " + i + ": " + e.getMessage());
                    break;
                }
            }
            poolInitialized = true;
            System.out.println("Connection pool initialized with " + connectionPool.size() + " connections");
        } catch (SQLException e) {
            System.err.println("Failed to initialize connection pool: " + e.getMessage());
            System.err.println("Database connection details:");
            System.err.println("URL: " + DB_URL);
            System.err.println("Username: " + DB_USERNAME);
            System.err.println("Please check if SQL Server is running and accessible");
        }
    }
    
    /**
     * Get database connection from pool
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Try to load driver again if not loaded in static block
            try {
                Class.forName(DRIVER_CLASS);
            } catch (ClassNotFoundException e) {
                System.err.println("SQL Server JDBC Driver not found: " + e.getMessage());
                throw new SQLException("Driver not found", e);
            }
            
            // Try to get connection from pool first
            Connection conn = connectionPool.poll();
            if (conn != null && !conn.isClosed()) {
                // Test if connection is still valid
                if (conn.isValid(5)) {
                    System.out.println("Database connection obtained from pool successfully!");
                    return conn;
                } else {
                    // Connection is invalid, close it and create a new one
                    try { conn.close(); } catch (SQLException ignored) {}
                }
            }
            
            // Create new connection if pool is empty or connection is invalid
            Connection newConn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            System.out.println("Database connection established successfully!");
            return newConn;
            
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection: " + e.getMessage());
            System.err.println("URL: " + DB_URL);
            System.err.println("Username: " + DB_USERNAME);
            throw e;
        }
    }
    
    /**
     * Return connection to pool
     */
    public static void returnConnection(Connection conn) {
        if (conn != null && poolInitialized) {
            try {
                if (!conn.isClosed() && conn.isValid(5)) {
                    // Reset connection state
                    conn.setAutoCommit(true);
                    connectionPool.offer(conn);
                    System.out.println("Database connection returned to pool successfully!");
                } else {
                    closeConnection(conn);
                }
            } catch (SQLException e) {
                System.err.println("Error returning connection to pool: " + e.getMessage());
                closeConnection(conn);
            }
        } else {
            closeConnection(conn);
        }
    }
    
    /**
     * Close database connection
     */
    public static void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Database connection closed successfully!");
            }
        } catch (SQLException e) {
            System.err.println("Error closing database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Test database connection
     * @return true if connection is successful, false otherwise
     */
    public static boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Database connection test: SUCCESS");
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Database connection test: FAILED - " + e.getMessage());
        } finally {
            returnConnection(conn);
        }
        return false;
    }
    
    /**
     * Shutdown connection pool
     */
    public static void shutdownPool() {
        Connection conn;
        while ((conn = connectionPool.poll()) != null) {
            closeConnection(conn);
        }
        poolInitialized = false;
        System.out.println("Connection pool shutdown completed");
    }
}
