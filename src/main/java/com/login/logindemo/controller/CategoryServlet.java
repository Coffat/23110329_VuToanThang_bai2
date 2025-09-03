package com.login.logindemo.controller;

import com.login.logindemo.model.Category;
import com.login.logindemo.model.User;
import com.login.logindemo.service.CategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * CategoryServlet handles CRUD operations for categories
 */
@WebServlet(name = "CategoryServlet", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {
    
    private CategoryService categoryService;
    
    @Override
    public void init() throws ServletException {
        categoryService = new CategoryService();
    }
    
    /**
     * Handle GET requests - display categories or forms
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                handleListCategories(request, response);
                break;
            case "add":
                handleShowAddForm(request, response);
                break;
            case "edit":
                handleShowEditForm(request, response);
                break;
            case "delete":
                handleDeleteCategory(request, response);
                break;
            case "search":
                handleSearchCategories(request, response);
                break;
            case "toggle":
                handleToggleStatus(request, response);
                break;
            default:
                handleListCategories(request, response);
                break;
        }
    }
    
    /**
     * Handle POST requests - process form submissions
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        switch (action) {
            case "create":
                handleCreateCategory(request, response);
                break;
            case "update":
                handleUpdateCategory(request, response);
                break;
            default:
                handleListCategories(request, response);
                break;
        }
    }
    
    /**
     * Handle list categories
     */
    private void handleListCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        List<Category> categories;
        String viewType = request.getParameter("view");
        
        if (isAdmin(currentUser)) {
            // Admin: default show all. If explicitly requesting "mine", show only own
            if ("mine".equalsIgnoreCase(viewType)) {
                categories = categoryService.getCategoriesByUserId(currentUser.getId());
            } else {
                categories = categoryService.getAllCategories();
            }
        } else {
            // Non-admin: always show own categories
            categories = categoryService.getCategoriesByUserId(currentUser.getId());
        }
        
        request.setAttribute("categories", categories);
        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("category-list.jsp").forward(request, response);
    }
    
    /**
     * Handle show add form
     */
    private void handleShowAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("category-form.jsp").forward(request, response);
    }
    
    /**
     * Handle show edit form
     */
    private void handleShowEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("id"));
        Category category = categoryService.getCategoryById(categoryId);
        
        if (category == null) {
            request.setAttribute("error", "Không tìm thấy danh mục!");
            handleListCategories(request, response);
            return;
        }
        
        // Check if user owns this category
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (!isAdmin(currentUser) && category.getUserId() != currentUser.getId()) {
            request.setAttribute("error", "Bạn không có quyền sửa danh mục này!");
            handleListCategories(request, response);
            return;
        }
        
        request.setAttribute("category", category);
        request.getRequestDispatcher("category-form.jsp").forward(request, response);
    }
    
    /**
     * Handle create category
     */
    private void handleCreateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        boolean status = "1".equals(request.getParameter("status"));
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Validate input
        String validationError = categoryService.validateCategoryInput(name, description, currentUser.getId());
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("name", name);
            request.setAttribute("description", description);
            request.setAttribute("image", image);
            request.getRequestDispatcher("category-form.jsp").forward(request, response);
            return;
        }
        
        // Create category
        Category category = new Category(name, description, image, status, currentUser.getId());
        boolean success = categoryService.createCategory(category);
        
        if (success) {
            request.setAttribute("success", "Tạo danh mục thành công!");
            handleListCategories(request, response);
        } else {
            request.setAttribute("error", "Tạo danh mục thất bại!");
            request.setAttribute("name", name);
            request.setAttribute("description", description);
            request.setAttribute("image", image);
            request.getRequestDispatcher("category-form.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle update category
     */
    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        boolean status = "1".equals(request.getParameter("status"));
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Get existing category
        Category category = categoryService.getCategoryById(categoryId);
        if (category == null) {
            request.setAttribute("error", "Không tìm thấy danh mục!");
            handleListCategories(request, response);
            return;
        }
        
        // Check ownership
        if (!isAdmin(currentUser) && category.getUserId() != currentUser.getId()) {
            request.setAttribute("error", "Bạn không có quyền sửa danh mục này!");
            handleListCategories(request, response);
            return;
        }
        
        // Validate input
        String validationError = categoryService.validateCategoryInput(name, description, currentUser.getId());
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("category", category);
            request.getRequestDispatcher("category-form.jsp").forward(request, response);
            return;
        }
        
        // Update category
        category.setName(name);
        category.setDescription(description);
        category.setImage(image);
        category.setStatus(status);
        
        boolean success = categoryService.updateCategory(category);
        
        if (success) {
            request.setAttribute("success", "Cập nhật danh mục thành công!");
            handleListCategories(request, response);
        } else {
            request.setAttribute("error", "Cập nhật danh mục thất bại!");
            request.setAttribute("category", category);
            request.getRequestDispatcher("category-form.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle delete category
     */
    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("id"));
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check ownership
        if (!isAdmin(currentUser) && !categoryService.isOwner(categoryId, currentUser.getId())) {
            request.setAttribute("error", "Bạn không có quyền xóa danh mục này!");
            handleListCategories(request, response);
            return;
        }
        
        boolean success = categoryService.deleteCategory(categoryId);
        
        if (success) {
            request.setAttribute("success", "Xóa danh mục thành công!");
        } else {
            request.setAttribute("error", "Xóa danh mục thất bại!");
        }
        
        handleListCategories(request, response);
    }
    
    /**
     * Handle search categories
     */
    private void handleSearchCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        List<Category> categories = categoryService.searchCategories(keyword);
        
        request.setAttribute("categories", categories);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("category-list.jsp").forward(request, response);
    }
    
    /**
     * Handle toggle category status
     */
    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("id"));
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check ownership
        if (!isAdmin(currentUser) && !categoryService.isOwner(categoryId, currentUser.getId())) {
            request.setAttribute("error", "Bạn không có quyền thay đổi trạng thái danh mục này!");
            handleListCategories(request, response);
            return;
        }
        
        boolean success = categoryService.toggleCategoryStatus(categoryId);
        
        if (success) {
            request.setAttribute("success", "Thay đổi trạng thái thành công!");
        } else {
            request.setAttribute("error", "Thay đổi trạng thái thất bại!");
        }
        
        handleListCategories(request, response);
    }
    
    /**
     * Check if user is admin
     */
    private boolean isAdmin(User user) {
        return user != null && user.getRoleid() == 1;
    }
}
