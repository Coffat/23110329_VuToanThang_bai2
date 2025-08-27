package com.login.logindemo.dao;

import com.login.logindemo.config.DBConnection;
import com.login.logindemo.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 * Data Access Object for User operations
 * Handles all database operations related to User entity
 */
public class UserDAO {
    
    /**
     * Authenticate user login credentials
     * @param username Username or email
     * @param password Password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String username, String password) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // SQL query to check user credentials - supports both username and email login
        String sql = "SELECT id, email, username, fullname, password, avatar, roleid, phone, createdDate " +
                    "FROM [User] WHERE (username = ? OR email = ?) AND password = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, username); // Check both username and email
            pstmt.setString(3, password);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUsername(rs.getString("username"));
                user.setFullname(rs.getString("fullname"));
                user.setPassword(rs.getString("password"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                
                // Handle date conversion
                java.sql.Date createdDate = rs.getDate("createdDate");
                if (createdDate != null) {
                    user.setCreatedDate(createdDate.toLocalDate());
                }
                
                System.out.println("User authentication successful for: " + user.getUsername());
            } else {
                System.out.println("Authentication failed for username: " + username);
            }
            
        } catch (SQLException e) {
            System.err.println("Error during user authentication: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.returnConnection(conn);
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    /**
     * Find user by username
     * @param username Username to search for
     * @return User object if found, null otherwise
     */
    public User findByUsername(String username) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT id, email, username, fullname, password, avatar, roleid, phone, createdDate " +
                    "FROM [User] WHERE username = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUsername(rs.getString("username"));
                user.setFullname(rs.getString("fullname"));
                user.setPassword(rs.getString("password"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                
                java.sql.Date createdDate = rs.getDate("createdDate");
                if (createdDate != null) {
                    user.setCreatedDate(createdDate.toLocalDate());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error finding user by username: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    /**
     * Find user by email
     * @param email Email to search for
     * @return User object if found, null otherwise
     */
    public User findByEmail(String email) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT id, email, username, fullname, password, avatar, roleid, phone, createdDate " +
                    "FROM [User] WHERE email = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUsername(rs.getString("username"));
                user.setFullname(rs.getString("fullname"));
                user.setPassword(rs.getString("password"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                
                java.sql.Date createdDate = rs.getDate("createdDate");
                if (createdDate != null) {
                    user.setCreatedDate(createdDate.toLocalDate());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error finding user by email: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.returnConnection(conn);
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    /**
     * Register new user
     * @param user User object to register
     * @return true if registration successful, false otherwise
     */
    public boolean registerUser(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        // SQL query to insert new user
        String sql = "INSERT INTO [User] (email, username, fullname, password, avatar, roleid, phone, createdDate) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getFullname());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getAvatar() != null ? user.getAvatar() : "");
            pstmt.setInt(6, user.getRoleid());
            pstmt.setString(7, user.getPhone() != null ? user.getPhone() : "");
            
            // Convert LocalDate to java.sql.Date
            if (user.getCreatedDate() != null) {
                pstmt.setDate(8, java.sql.Date.valueOf(user.getCreatedDate()));
            } else {
                pstmt.setDate(8, java.sql.Date.valueOf(java.time.LocalDate.now()));
            }
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("User registered successfully: " + user.getUsername());
                return true;
            } else {
                System.out.println("No rows affected during user registration");
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Error during user registration: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.returnConnection(conn);
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}
