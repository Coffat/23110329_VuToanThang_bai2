package com.login.logindemo.service;

import com.login.logindemo.dao.ProductDAO;
import com.login.logindemo.model.Product;

import java.util.List;

public class ProductService {
    private final ProductDAO dao = new ProductDAO();

    public List<Product> getAll() { return dao.findAll(); }
    public List<Product> getByUser(int userId) { return dao.findByUser(userId); }
    public Product getById(int id) { return dao.findById(id); }

    public String validate(String name, String priceStr) {
        if (name == null || name.trim().isEmpty()) return "Tên sản phẩm không được để trống";
        try { double v = Double.parseDouble(priceStr); if (v < 0) return "Giá không hợp lệ"; } catch (Exception e) { return "Giá không hợp lệ"; }
        return null;
    }

    public boolean create(Product p) { return dao.insert(p); }
    public boolean update(Product p) { return dao.update(p); }
    public boolean delete(int id) { return dao.delete(id); }
}


