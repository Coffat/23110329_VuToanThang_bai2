package com.login.logindemo.controller;

import com.login.logindemo.model.Product;
import com.login.logindemo.model.User;
import com.login.logindemo.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class ProductServlet extends HttpServlet {
    private ProductService service;

    @Override
    public void init() throws ServletException {
        service = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("product-form.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("product", service.getById(id));
                request.getRequestDispatcher("product-form.jsp").forward(request, response);
                break;
            default:
                User u = (User) session.getAttribute("user");
                List<Product> products = u.getRoleid() == 1 ? service.getAll() : service.getByUser(u.getId());
                request.setAttribute("products", products);
                request.getRequestDispatcher("product-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User current = (User) session.getAttribute("user");

        String action = request.getParameter("action");
        if (action == null) action = "create";

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            service.delete(id);
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        boolean status = "1".equals(request.getParameter("status"));
        String validation = service.validate(name, priceStr);
        if (validation != null) {
            request.setAttribute("error", validation);
            request.getRequestDispatcher("product-form.jsp").forward(request, response);
            return;
        }
        double price = Double.parseDouble(priceStr);

        String imagePath = null;
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null) {
            String uploadsDir = request.getServletContext().getRealPath("/uploads/products");
            if (uploadsDir == null) uploadsDir = request.getServletContext().getResource("/").getPath() + "uploads/products";
            Path uploadPath = Paths.get(uploadsDir);
            if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);
            String ext = getExt(filePart.getSubmittedFileName());
            String fileName = UUID.randomUUID() + (ext.isEmpty()?"":"."+ext);
            Path filePath = uploadPath.resolve(fileName);
            filePart.write(filePath.toString());
            imagePath = "uploads/products/" + fileName;
        }

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = service.getById(id);
            p.setName(name); p.setDescription(description); p.setPrice(price); p.setStatus(status);
            if (imagePath != null) p.setImage(imagePath);
            service.update(p);
        } else {
            Product p = new Product(name, description, price, imagePath, status, current.getId());
            service.create(p);
        }

        response.sendRedirect(request.getContextPath() + "/product");
    }

    private String getExt(String file) {
        int i = file.lastIndexOf('.');
        return i>=0? file.substring(i+1):"";
    }
}


