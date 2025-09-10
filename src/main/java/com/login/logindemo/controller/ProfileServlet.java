package com.login.logindemo.controller;

import com.login.logindemo.model.User;
import com.login.logindemo.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, fileSizeThreshold = 1024 * 1024)
public class ProfileServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
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

        request.getRequestDispatcher("profile.jsp").forward(request, response);
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

        User currentUser = (User) session.getAttribute("user");
        String fullname = nullToEmpty(request.getParameter("fullname")).trim();
        String phone = nullToEmpty(request.getParameter("phone")).trim();

        // Handle avatar upload (optional)
        String savedAvatarRelativePath = null;
        try {
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isBlank()) {
                String uploadsDir = request.getServletContext().getRealPath("/uploads/avatars");
                if (uploadsDir == null) {
                    uploadsDir = request.getServletContext().getResource("/").getPath() + "uploads/avatars";
                }
                Path uploadPath = Paths.get(uploadsDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                String ext = getExtension(filePart.getSubmittedFileName());
                String fileName = UUID.randomUUID() + (ext.isEmpty() ? "" : ("." + ext));
                Path filePath = uploadPath.resolve(fileName);
                filePart.write(filePath.toString());

                savedAvatarRelativePath = "uploads/avatars/" + fileName;
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Tải ảnh thất bại: " + ex.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        boolean updated = userService.updateProfile(currentUser.getId(), fullname, phone, savedAvatarRelativePath);
        if (updated) {
            // Update session attributes (both bean and individual fields if used elsewhere)
            currentUser.setFullname(fullname);
            currentUser.setPhone(phone);
            if (savedAvatarRelativePath != null) {
                currentUser.setAvatar(savedAvatarRelativePath);
            }
            session.setAttribute("user", currentUser);
            session.setAttribute("fullname", fullname);
            session.setAttribute("phone", phone);
            if (savedAvatarRelativePath != null) session.setAttribute("avatar", savedAvatarRelativePath);

            request.setAttribute("success", "Cập nhật hồ sơ thành công!");
        } else {
            request.setAttribute("error", "Cập nhật hồ sơ thất bại!");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private String nullToEmpty(String v) {
        return v == null ? "" : v;
    }

    private String getExtension(String fileName) {
        if (fileName == null) return "";
        int idx = fileName.lastIndexOf('.')
                ;
        return idx >= 0 ? fileName.substring(idx + 1) : "";
    }
}


