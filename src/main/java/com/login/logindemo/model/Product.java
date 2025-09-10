package com.login.logindemo.model;

import java.time.LocalDateTime;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String image;
    private boolean status;
    private int userId;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;

    public Product() {}

    public Product(String name, String description, double price, String image, boolean status, int userId) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
        this.status = status;
        this.userId = userId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public LocalDateTime getCreatedDate() { return createdDate; }
    public void setCreatedDate(LocalDateTime createdDate) { this.createdDate = createdDate; }
    public LocalDateTime getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(LocalDateTime updatedDate) { this.updatedDate = updatedDate; }
}


