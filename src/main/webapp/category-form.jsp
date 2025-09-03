<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.login.logindemo.model.Category" %>
<%@ page import="com.login.logindemo.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
    
    Category category = (Category) request.getAttribute("category");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    
    // For form data preservation
    String name = (String) request.getAttribute("name");
    String description = (String) request.getAttribute("description");
    String image = (String) request.getAttribute("image");
    
    boolean isEdit = category != null;
    if (isEdit) {
        if (name == null) name = category.getName();
        if (description == null) description = category.getDescription();
        if (image == null) image = category.getImage();
    }
    
    if (name == null) name = "";
    if (description == null) description = "";
    if (image == null) image = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Sửa" : "Thêm" %> Danh Mục - Hệ Thống Quản Lý</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        /* Navbar (synced with homepage) */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
        }

        .nav-link {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            background-color: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .header h1 {
            color: white;
            margin: 0;
            font-size: 28px;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            font-size: 16px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .alert {
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group .help-text {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }

        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: 6px;
            margin-top: 10px;
            border: 1px solid #ddd;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkbox-group input[type="checkbox"] {
            width: auto;
            margin: 0;
        }

        .required {
            color: red;
        }

        .form-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            align-items: start;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation synced with homepage -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="home" class="logo">🏠 Hệ Thống Quản Lý</a>
            <div class="nav-links">
                <a href="home" class="nav-link">Trang Chủ</a>
                <a href="category" class="nav-link active">Danh Mục</a>
                <a href="profile.jsp" class="nav-link">Hồ Sơ</a>
            </div>
            <div class="user-info">
                <a href="logout" class="nav-link" onclick="return confirm('Bạn có chắc muốn đăng xuất?')">Đăng xuất</a>
            </div>
        </div>
    </nav>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><%= isEdit ? "Sửa" : "Thêm" %> Danh Mục</h1>
            <div style="display: flex; gap: 10px;">
                <a href="home" class="btn btn-secondary">🏠 Trang chủ</a>
                <a href="category" class="btn btn-secondary">← Danh sách</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="card">
            <!-- Messages -->
            <% if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-error">
                    <%= error %>
                </div>
            <% } %>

            <% if (success != null && !success.isEmpty()) { %>
                <div class="alert alert-success">
                    <%= success %>
                </div>
            <% } %>

            <!-- Form -->
            <form action="category" method="post" id="categoryForm" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "create" %>">
                <% if (isEdit) { %>
                <input type="hidden" name="id" value="<%= category.getId() %>">
                <% } %>

                <div class="form-row">
                    <div>
                        <!-- Category Name -->
                        <div class="form-group">
                            <label for="name">Tên danh mục <span class="required">*</span></label>
                            <input type="text" 
                                   id="name" 
                                   name="name" 
                                   value="<%= name %>" 
                                   placeholder="Nhập tên danh mục"
                                   required
                                   maxlength="255">
                            <div class="help-text">Tối đa 255 ký tự</div>
                        </div>

                        <!-- Description -->
                        <div class="form-group">
                            <label for="description">Mô tả</label>
                            <textarea id="description" 
                                      name="description" 
                                      placeholder="Nhập mô tả cho danh mục"
                                      maxlength="500"><%= description %></textarea>
                            <div class="help-text">Tối đa 500 ký tự</div>
                        </div>

                        <!-- Image URL -->
                        <div class="form-group">
                            <label for="image">URL hình ảnh</label>
                            <input type="url" 
                                   id="image" 
                                   name="image" 
                                   value="<%= image %>" 
                                   placeholder="https://example.com/image.jpg"
                                   onchange="previewImage()">
                            <div class="help-text">Nhập URL của hình ảnh đại diện cho danh mục</div>
                        </div>

                        <!-- Status -->
                        <div class="form-group">
                            <label>Trạng thái</label>
                            <div class="checkbox-group">
                                <input type="checkbox" 
                                       id="status" 
                                       name="status" 
                                       value="1" 
                                       <%= isEdit ? (category.isStatus() ? "checked" : "") : "checked" %>>
                                <label for="status">Hoạt động</label>
                            </div>
                            <div class="help-text">Danh mục hoạt động sẽ hiển thị cho người dùng</div>
                        </div>
                    </div>

                    <div>
                        <!-- Image Preview -->
                        <div class="form-group">
                            <label>Xem trước hình ảnh</label>
                            <div id="imagePreview">
                                <% if (!image.isEmpty()) { %>
                                    <img src="<%= image %>" alt="Preview" class="image-preview" id="previewImg">
                                <% } else { %>
                                    <div style="width: 200px; height: 150px; background-color: #f8f9fa; border: 2px dashed #dee2e6; display: flex; align-items: center; justify-content: center; color: #6c757d; border-radius: 6px;">
                                        <span>Chưa có hình ảnh</span>
                                    </div>
                                <% } %>
                            </div>
                        </div>

                        <% if (isEdit) { %>
                        <!-- Category Info -->
                        <div class="form-group">
                            <label>Thông tin danh mục</label>
                            <div style="padding: 15px; background-color: #f8f9fa; border-radius: 6px; font-size: 14px;">
                                <p><strong>ID:</strong> <%= category.getId() %></p>
                                <p><strong>Người tạo:</strong> <%= category.getUserFullname() %></p>
                                <p><strong>Ngày tạo:</strong> 
                                   <% if (category.getCreatedDate() != null) { %>
                                       <%= category.getCreatedDate().toLocalDate() %>
                                   <% } %>
                                </p>
                                <p><strong>Cập nhật cuối:</strong> 
                                   <% if (category.getUpdatedDate() != null) { %>
                                       <%= category.getUpdatedDate().toLocalDate() %>
                                   <% } %>
                                </p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="category" class="btn btn-secondary">Hủy</a>
                    <button type="submit" class="btn btn-primary">
                        <%= isEdit ? "Cập nhật" : "Tạo danh mục" %>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Image preview function
        function previewImage() {
            const imageUrl = document.getElementById('image').value;
            const previewContainer = document.getElementById('imagePreview');
            
            if (imageUrl) {
                // Check if image exists
                const img = new Image();
                img.onload = function() {
                    previewContainer.innerHTML = '<img src="' + imageUrl + '" alt="Preview" class="image-preview" id="previewImg">';
                };
                img.onerror = function() {
                    previewContainer.innerHTML = '<div style="width: 200px; height: 150px; background-color: #f8d7da; border: 2px dashed #f5c6cb; display: flex; align-items: center; justify-content: center; color: #721c24; border-radius: 6px;"><span>URL hình ảnh không hợp lệ</span></div>';
                };
                img.src = imageUrl;
            } else {
                previewContainer.innerHTML = '<div style="width: 200px; height: 150px; background-color: #f8f9fa; border: 2px dashed #dee2e6; display: flex; align-items: center; justify-content: center; color: #6c757d; border-radius: 6px;"><span>Chưa có hình ảnh</span></div>';
            }
        }

        // Form validation
        document.getElementById('categoryForm').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            
            if (name === '') {
                alert('Vui lòng nhập tên danh mục!');
                e.preventDefault();
                return;
            }
            
            if (name.length > 255) {
                alert('Tên danh mục không được vượt quá 255 ký tự!');
                e.preventDefault();
                return;
            }
            
            const description = document.getElementById('description').value;
            if (description.length > 500) {
                alert('Mô tả không được vượt quá 500 ký tự!');
                e.preventDefault();
                return;
            }
        });

        // Character counting
        document.getElementById('name').addEventListener('input', function() {
            const current = this.value.length;
            const max = 255;
            const helpText = this.parentNode.querySelector('.help-text');
            helpText.textContent = `${current}/${max} ký tự`;
            helpText.style.color = current > max * 0.9 ? '#dc3545' : '#6c757d';
        });

        document.getElementById('description').addEventListener('input', function() {
            const current = this.value.length;
            const max = 500;
            const helpText = this.parentNode.querySelector('.help-text');
            helpText.textContent = `${current}/${max} ký tự`;
            helpText.style.color = current > max * 0.9 ? '#dc3545' : '#6c757d';
        });

        // Focus first input on page load
        window.onload = function() {
            document.getElementById('name').focus();
        };

        // Auto hide success/error messages after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>
