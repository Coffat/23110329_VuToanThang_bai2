package com.login.logindemo.dao;

import com.login.logindemo.config.DBConnection;
import com.login.logindemo.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Category operations
 * Handles all database operations related to Category entity
 */
public class CategoryDAO {
    
    /**
     * Create a new category
     * @param category Category object to create
     * @return true if creation successful, false otherwise
     */
    public boolean createCategory(Category category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO Category (name, description, image, status, user_id, created_date, updated_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setString(3, category.getImage());
            pstmt.setBoolean(4, category.isStatus());
            pstmt.setInt(5, category.getUserId());
            
            // Convert LocalDateTime to Timestamp
            LocalDateTime now = LocalDateTime.now();
            pstmt.setObject(6, now);
            pstmt.setObject(7, now);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Category created successfully: " + category.getName());
                return true;
            } else {
                System.out.println("No rows affected during category creation");
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Error creating category: " + e.getMessage());
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
    
    /**
     * Get category by ID
     * @param id Category ID
     * @return Category object if found, null otherwise
     */
    public Category getCategoryById(int id) {
        Category category = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT c.*, u.username, u.fullname " +
                    "FROM Category c " +
                    "INNER JOIN [User] u ON c.user_id = u.id " +
                    "WHERE c.id = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                category = mapResultSetToCategory(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting category by ID: " + e.getMessage());
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
        
        return category;
    }
    
    /**
     * Get all categories
     * @return List of all categories
     */
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT c.*, u.username, u.fullname " +
                    "FROM Category c " +
                    "INNER JOIN [User] u ON c.user_id = u.id " +
                    "ORDER BY c.created_date DESC";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Category category = mapResultSetToCategory(rs);
                categories.add(category);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all categories: " + e.getMessage());
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
        
        return categories;
    }
    
    /**
     * Get categories by user ID
     * @param userId User ID
     * @return List of categories belonging to the user
     */
    public List<Category> getCategoriesByUserId(int userId) {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT c.*, u.username, u.fullname " +
                    "FROM Category c " +
                    "INNER JOIN [User] u ON c.user_id = u.id " +
                    "WHERE c.user_id = ? " +
                    "ORDER BY c.created_date DESC";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Category category = mapResultSetToCategory(rs);
                categories.add(category);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting categories by user ID: " + e.getMessage());
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
        
        return categories;
    }
    
    /**
     * Update category
     * @param category Category object with updated data
     * @return true if update successful, false otherwise
     */
    public boolean updateCategory(Category category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE Category SET name = ?, description = ?, image = ?, status = ?, updated_date = ? WHERE id = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setString(3, category.getImage());
            pstmt.setBoolean(4, category.isStatus());
            pstmt.setObject(5, LocalDateTime.now());
            pstmt.setInt(6, category.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Category updated successfully: " + category.getName());
                return true;
            } else {
                System.out.println("No category found with ID: " + category.getId());
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Error updating category: " + e.getMessage());
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
    
    /**
     * Delete category by ID
     * @param id Category ID
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteCategory(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "DELETE FROM Category WHERE id = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Category deleted successfully with ID: " + id);
                return true;
            } else {
                System.out.println("No category found with ID: " + id);
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Error deleting category: " + e.getMessage());
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
    
    /**
     * Search categories by name
     * @param keyword Search keyword
     * @return List of categories matching the search
     */
    public List<Category> searchCategoriesByName(String keyword) {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT c.*, u.username, u.fullname " +
                    "FROM Category c " +
                    "INNER JOIN [User] u ON c.user_id = u.id " +
                    "WHERE c.name LIKE ? OR c.description LIKE ? " +
                    "ORDER BY c.created_date DESC";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Category category = mapResultSetToCategory(rs);
                categories.add(category);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching categories: " + e.getMessage());
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
        
        return categories;
    }
    
    /**
     * Map ResultSet to Category object
     * @param rs ResultSet
     * @return Category object
     * @throws SQLException
     */
    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDescription(rs.getString("description"));
        category.setImage(rs.getString("image"));
        category.setStatus(rs.getBoolean("status"));
        category.setUserId(rs.getInt("user_id"));
        
        // Convert timestamp to LocalDateTime
        if (rs.getTimestamp("created_date") != null) {
            category.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_date") != null) {
            category.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
        }
        
        // Set user information
        category.setUsername(rs.getString("username"));
        category.setUserFullname(rs.getString("fullname"));
        
        return category;
    }
}
