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
     * Update user profile fields (fullname, phone, optional avatar)
     */
    public boolean updateProfile(int userId, String fullname, String phone, String avatarRelativePathOrNull) {
        if (userId <= 0) return false;
        if (fullname == null || fullname.trim().isEmpty()) return false;
        if (phone == null) phone = "";
        return userDAO.updateProfile(userId, fullname.trim(), phone.trim(), avatarRelativePathOrNull);
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
    
    /**
     * Reset password by email
     * @param email User email
     * @param newPassword New password
     * @param confirmPassword Confirm new password
     * @return true if reset successful, false otherwise
     */
    public boolean resetPassword(String email, String newPassword, String confirmPassword) {
        try {
            // Validate input
            if (email == null || email.trim().isEmpty()) {
                System.out.println("Email cannot be empty");
                return false;
            }
            
            if (newPassword == null || newPassword.trim().isEmpty()) {
                System.out.println("New password cannot be empty");
                return false;
            }
            
            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                System.out.println("Confirm password cannot be empty");
                return false;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                System.out.println("Passwords do not match");
                return false;
            }
            
            if (newPassword.length() < 6) {
                System.out.println("Password must be at least 6 characters");
                return false;
            }
            
            // Check if email exists
            User user = userDAO.findByEmail(email.trim());
            if (user == null) {
                System.out.println("Email not found: " + email);
                return false;
            }
            
            // Update password
            boolean success = userDAO.updatePasswordByEmail(email.trim(), newPassword);
            
            if (success) {
                System.out.println("Password reset successful for email: " + email);
                return true;
            } else {
                System.out.println("Password reset failed for email: " + email);
                return false;
            }
            
        } catch (Exception e) {
            System.err.println("Error during password reset: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Validate password reset input
     * @param email Email
     * @param newPassword New password
     * @param confirmPassword Confirm password
     * @return Error message if validation fails, null if validation passes
     */
    public String validatePasswordResetInput(String email, String newPassword, String confirmPassword) {
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        
        if (!isValidEmail(email)) {
            return "Email không hợp lệ";
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            return "Mật khẩu mới không được để trống";
        }
        
        if (newPassword.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            return "Vui lòng xác nhận mật khẩu mới";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            return "Mật khẩu xác nhận không khớp";
        }
        
        return null; // No validation errors
    }
    
    /**
     * Validate email format
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }
}
