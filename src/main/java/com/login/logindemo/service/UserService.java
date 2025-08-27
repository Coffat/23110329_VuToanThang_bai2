package com.login.logindemo.service;

import com.login.logindemo.dao.UserDAO;
import com.login.logindemo.model.User;

/**
 * Service layer for User operations
 * Contains business logic for user-related operations
 */
public class UserService {
    
    private UserDAO userDAO;
    
    public UserService() {
        this.userDAO = new UserDAO();
    }
    
    /**
     * Authenticate user login
     * @param username Username or email
     * @param password Password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String username, String password) {
        // Basic validation
        if (username == null || username.trim().isEmpty()) {
            System.out.println("Username cannot be empty");
            return null;
        }
        
        if (password == null || password.trim().isEmpty()) {
            System.out.println("Password cannot be empty");
            return null;
        }
        
        // Trim whitespace
        username = username.trim();
        password = password.trim();
        
        // Call DAO to authenticate
        User user = userDAO.authenticateUser(username, password);
        
        if (user != null) {
            System.out.println("Login successful for user: " + user.getUsername() + " (Role ID: " + user.getRoleid() + ")");
            return user;
        } else {
            System.out.println("Login failed for username: " + username);
            return null;
        }
    }
    
    /**
     * Check if username exists
     * @param username Username to check
     * @return true if exists, false otherwise
     */
    public boolean isUsernameExists(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        
        User user = userDAO.findByUsername(username.trim());
        return user != null;
    }
    
    /**
     * Check if email exists
     * @param email Email to check
     * @return true if exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        User user = userDAO.findByEmail(email.trim());
        return user != null;
    }
    
    /**
     * Get user role name based on role ID
     * @param roleId Role ID
     * @return Role name
     */
    public String getRoleName(int roleId) {
        switch (roleId) {
            case 1:
                return "Administrator";
            case 2:
                return "Manager";
            case 3:
                return "Employee";
            case 4:
                return "Customer";
            case 5:
                return "Member";
            default:
                return "Unknown";
        }
    }
    
    /**
     * Validate login input
     * @param username Username or email
     * @param password Password
     * @return Error message if validation fails, null if validation passes
     */
    public String validateLoginInput(String username, String password) {
        if (username == null || username.trim().isEmpty()) {
            return "Tên đăng nhập không được để trống";
        }
        
        if (password == null || password.trim().isEmpty()) {
            return "Mật khẩu không được để trống";
        }
        
        if (username.length() < 3) {
            return "Tên đăng nhập phải có ít nhất 3 ký tự";
        }
        
        if (password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        
        return null; // No validation errors
    }
    
    /**
     * Register new user
     * @param user User object to register
     * @return true if registration successful, false otherwise
     */
    public boolean registerUser(User user) {
        try {
            // Basic validation
            if (user == null) {
                System.out.println("User object is null");
                return false;
            }
            
            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                System.out.println("Username cannot be empty");
                return false;
            }
            
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                System.out.println("Password cannot be empty");
                return false;
            }
            
            // Call DAO to register user
            boolean success = userDAO.registerUser(user);
            
            if (success) {
                System.out.println("User registration successful: " + user.getUsername());
                return true;
            } else {
                System.out.println("User registration failed: " + user.getUsername());
                return false;
            }
            
        } catch (Exception e) {
            System.err.println("Error during user registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
