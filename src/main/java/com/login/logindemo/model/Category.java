package com.login.logindemo.model;

import java.time.LocalDateTime;

/**
 * Category Entity Model
 * Represents a category that belongs to a user
 */
public class Category {
    private int id;
    private String name;
    private String description;
    private String image;
    private boolean status;
    private int userId;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    
    // For JOIN operations
    private String username;
    private String userFullname;
    
    // Constructors
    public Category() {
    }
    
    public Category(String name, String description, String image, boolean status, int userId) {
        this.name = name;
        this.description = description;
        this.image = image;
        this.status = status;
        this.userId = userId;
        this.createdDate = LocalDateTime.now();
        this.updatedDate = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getImage() {
        return image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    
    public boolean isStatus() {
        return status;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public LocalDateTime getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getUserFullname() {
        return userFullname;
    }
    
    public void setUserFullname(String userFullname) {
        this.userFullname = userFullname;
    }
    
    // Utility methods
    public String getStatusText() {
        return status ? "Hoạt động" : "Không hoạt động";
    }
    
    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", image='" + image + '\'' +
                ", status=" + status +
                ", userId=" + userId +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                '}';
    }
}
