package com.login.logindemo.service;

import com.login.logindemo.dao.CategoryDAO;
import com.login.logindemo.model.Category;

import java.util.List;

/**
 * Service layer for Category operations
 * Contains business logic for category-related operations
 */
public class CategoryService {
    
    private CategoryDAO categoryDAO;
    
    public CategoryService() {
        this.categoryDAO = new CategoryDAO();
    }
    
    /**
     * Create a new category
     * @param category Category object to create
     * @return true if creation successful, false otherwise
     */
    public boolean createCategory(Category category) {
        try {
            // Basic validation
            if (category == null) {
                System.out.println("Category object is null");
                return false;
            }
            
            if (category.getName() == null || category.getName().trim().isEmpty()) {
                System.out.println("Category name cannot be empty");
                return false;
            }
            
            if (category.getUserId() <= 0) {
                System.out.println("Invalid user ID");
                return false;
            }
            
            // Call DAO to create category
            boolean success = categoryDAO.createCategory(category);
            
            if (success) {
                System.out.println("Category creation successful: " + category.getName());
                return true;
            } else {
                System.out.println("Category creation failed: " + category.getName());
                return false;
            }
            
        } catch (Exception e) {
            System.err.println("Error during category creation: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get category by ID
     * @param id Category ID
     * @return Category object if found, null otherwise
     */
    public Category getCategoryById(int id) {
        if (id <= 0) {
            System.out.println("Invalid category ID: " + id);
            return null;
        }
        
        return categoryDAO.getCategoryById(id);
    }
    
    /**
     * Get all categories
     * @return List of all categories
     */
    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }
    
    /**
     * Get categories by user ID
     * @param userId User ID
     * @return List of categories belonging to the user
     */
    public List<Category> getCategoriesByUserId(int userId) {
        if (userId <= 0) {
            System.out.println("Invalid user ID: " + userId);
            return List.of(); // Return empty list
        }
        
        return categoryDAO.getCategoriesByUserId(userId);
    }
    
    /**
     * Update category
     * @param category Category object with updated data
     * @return true if update successful, false otherwise
     */
    public boolean updateCategory(Category category) {
        try {
            // Basic validation
            if (category == null) {
                System.out.println("Category object is null");
                return false;
            }
            
            if (category.getId() <= 0) {
                System.out.println("Invalid category ID");
                return false;
            }
            
            if (category.getName() == null || category.getName().trim().isEmpty()) {
                System.out.println("Category name cannot be empty");
                return false;
            }
            
            // Call DAO to update category
            boolean success = categoryDAO.updateCategory(category);
            
            if (success) {
                System.out.println("Category update successful: " + category.getName());
                return true;
            } else {
                System.out.println("Category update failed: " + category.getName());
                return false;
            }
            
        } catch (Exception e) {
            System.err.println("Error during category update: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Delete category by ID
     * @param id Category ID
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteCategory(int id) {
        if (id <= 0) {
            System.out.println("Invalid category ID: " + id);
            return false;
        }
        
        try {
            boolean success = categoryDAO.deleteCategory(id);
            
            if (success) {
                System.out.println("Category deletion successful with ID: " + id);
                return true;
            } else {
                System.out.println("Category deletion failed with ID: " + id);
                return false;
            }
            
        } catch (Exception e) {
            System.err.println("Error during category deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Search categories by name
     * @param keyword Search keyword
     * @return List of categories matching the search
     */
    public List<Category> searchCategories(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllCategories(); // Return all if no keyword
        }
        
        return categoryDAO.searchCategoriesByName(keyword.trim());
    }
    
    /**
     * Validate category input
     * @param name Category name
     * @param description Category description
     * @param userId User ID
     * @return Error message if validation fails, null if validation passes
     */
    public String validateCategoryInput(String name, String description, int userId) {
        if (name == null || name.trim().isEmpty()) {
            return "Tên danh mục không được để trống";
        }
        
        if (name.length() > 255) {
            return "Tên danh mục không được vượt quá 255 ký tự";
        }
        
        if (description != null && description.length() > 500) {
            return "Mô tả không được vượt quá 500 ký tự";
        }
        
        if (userId <= 0) {
            return "ID người dùng không hợp lệ";
        }
        
        return null; // No validation errors
    }
    
    /**
     * Check if user owns the category
     * @param categoryId Category ID
     * @param userId User ID
     * @return true if user owns the category, false otherwise
     */
    public boolean isOwner(int categoryId, int userId) {
        Category category = getCategoryById(categoryId);
        return category != null && category.getUserId() == userId;
    }
    
    /**
     * Get categories count by user
     * @param userId User ID
     * @return Number of categories owned by user
     */
    public int getCategoriesCountByUser(int userId) {
        List<Category> categories = getCategoriesByUserId(userId);
        return categories.size();
    }
    
    /**
     * Toggle category status (active/inactive)
     * @param categoryId Category ID
     * @return true if toggle successful, false otherwise
     */
    public boolean toggleCategoryStatus(int categoryId) {
        Category category = getCategoryById(categoryId);
        if (category != null) {
            category.setStatus(!category.isStatus());
            return updateCategory(category);
        }
        return false;
    }
}
