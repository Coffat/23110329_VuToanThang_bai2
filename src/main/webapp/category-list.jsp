<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.login.logindemo.model.Category" %>
<%@ page import="com.login.logindemo.model.User" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
    @SuppressWarnings("unchecked")
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    User currentUser = (User) request.getAttribute("currentUser");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    if (categories == null) categories = new java.util.ArrayList<>();
    if (searchKeyword == null) searchKeyword = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh mục</title>
</head>
<body>
    <h1>Danh mục</h1>
    <p>
        <a href="home">Trang chủ</a> |
        <a href="profile.jsp">Hồ sơ</a> |
        <a href="category?action=add">Thêm danh mục</a>
        <% if (currentUser != null && currentUser.getRoleid() == 1) { %>
            | <a href="category?view=all">Xem tất cả</a>
            | <a href="category?view=mine">Danh mục của tôi</a>
        <% } %>
    </p>

    <% if (error != null && !error.isEmpty()) { %>
        <p><%= error %></p>
    <% } %>
    <% if (success != null && !success.isEmpty()) { %>
        <p><%= success %></p>
    <% } %>

    <form action="category" method="get">
        <input type="hidden" name="action" value="search">
        <input type="text" name="keyword" value="<%= searchKeyword %>" placeholder="Từ khóa">
        <button type="submit">Tìm</button>
        <% if (!searchKeyword.isEmpty()) { %>
            <a href="category">Xóa lọc</a>
        <% } %>
    </form>

    <% if (categories.isEmpty()) { %>
        <p>Không có danh mục nào.</p>
    <% } else { %>
        <table border="1" cellpadding="6" cellspacing="0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Mô tả</th>
                    <th>Người tạo</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% for (Category c : categories) { %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getDescription() == null ? "" : c.getDescription() %></td>
                    <td><%= c.getUserFullname() %></td>
                    <td><%= c.isStatus() ? "Hoạt động" : "Ngừng" %></td>
                    <td><%= c.getCreatedDate() != null ? c.getCreatedDate().toLocalDate() : "" %></td>
                    <td>
                        <a href="category?action=edit&id=<%= c.getId() %>">Sửa</a>
                        |
                        <a href="category?action=toggle&id=<%= c.getId() %>" onclick="return confirm('Đổi trạng thái?')">
                            <%= c.isStatus() ? "Tắt" : "Bật" %>
                        </a>
                        |
                        <a href="category?action=delete&id=<%= c.getId() %>" onclick="return confirm('Xóa danh mục?')">Xóa</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.login.logindemo.model.Category" %>
<%@ page import="com.login.logindemo.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
    
    @SuppressWarnings("unchecked")
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    User currentUser = (User) request.getAttribute("currentUser");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    
    if (categories == null) categories = new java.util.ArrayList<>();
    if (searchKeyword == null) searchKeyword = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Hệ Thống Quản Lý</title>
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
            max-width: 1200px;
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
            color: #333;
            margin: 0;
            font-size: 28px;
        }

        .header-actions {
            display: flex;
            gap: 10px;
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

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-success:hover {
            background-color: #1e7e34;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #000;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
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

        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-bar input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }

        .table tr:hover {
            background-color: #f5f5f5;
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .category-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }

        .no-data {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 40px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .stat-number {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            opacity: 0.9;
        }
    </style>
        @media (max-width: 768px) {
            .nav-links { display: none; }
            .container { padding: 20px 15px; }
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
            <h1>Quản Lý Danh Mục</h1>
            <div class="header-actions">
                <a href="home" class="btn btn-secondary">🏠 Trang chủ</a>
                <a href="profile.jsp" class="btn btn-secondary">👤 Hồ sơ</a>
                <a href="category?action=add" class="btn btn-success">+ Thêm Danh Mục</a>
                <% if (currentUser != null && currentUser.getRoleid() == 1) { %>
                <a href="category?view=all" class="btn btn-primary">Xem Tất Cả</a>
                <% } %>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number"><%= categories.size() %></div>
                <div class="stat-label">Tổng Danh Mục</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= categories.stream().mapToInt(c -> c.isStatus() ? 1 : 0).sum() %></div>
                <div class="stat-label">Đang Hoạt Động</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= categories.stream().mapToInt(c -> !c.isStatus() ? 1 : 0).sum() %></div>
                <div class="stat-label">Không Hoạt Động</div>
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

            <!-- Search Bar -->
            <form action="category" method="get" class="search-bar">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Tìm kiếm danh mục..." value="<%= searchKeyword %>">
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                <% if (!searchKeyword.isEmpty()) { %>
                <a href="category" class="btn btn-secondary">Xóa bộ lọc</a>
                <% } %>
            </form>

            <!-- Categories Table -->
            <% if (categories.isEmpty()) { %>
                <div class="no-data">
                    <% if (searchKeyword.isEmpty()) { %>
                        Chưa có danh mục nào. <a href="category?action=add">Tạo danh mục đầu tiên</a>
                    <% } else { %>
                        Không tìm thấy danh mục nào phù hợp với từ khóa "<%= searchKeyword %>"
                    <% } %>
                </div>
            <% } else { %>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th>Mô tả</th>
                            <th>Người tạo</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Category category : categories) { %>
                        <tr>
                            <td><%= category.getId() %></td>
                            <td>
                                <% if (category.getImage() != null && !category.getImage().isEmpty()) { %>
                                    <img src="<%= category.getImage() %>" alt="Category Image" class="category-image">
                                <% } else { %>
                                    <div class="category-image" style="background-color: #e9ecef; display: flex; align-items: center; justify-content: center; color: #6c757d;">
                                        📁
                                    </div>
                                <% } %>
                            </td>
                            <td><strong><%= category.getName() %></strong></td>
                            <td>
                                <% if (category.getDescription() != null && !category.getDescription().isEmpty()) { %>
                                    <%= category.getDescription().length() > 50 ? 
                                        category.getDescription().substring(0, 50) + "..." : 
                                        category.getDescription() %>
                                <% } else { %>
                                    <em>Chưa có mô tả</em>
                                <% } %>
                            </td>
                            <td><%= category.getUserFullname() %></td>
                            <td>
                                <span class="status-badge <%= category.isStatus() ? "status-active" : "status-inactive" %>">
                                    <%= category.getStatusText() %>
                                </span>
                            </td>
                            <td>
                                <% if (category.getCreatedDate() != null) { %>
                                    <%= category.getCreatedDate().toLocalDate() %>
                                <% } %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <% if (currentUser.getRoleid() == 1 || category.getUserId() == currentUser.getId()) { %>
                                        <a href="category?action=edit&id=<%= category.getId() %>" class="btn btn-warning">Sửa</a>
                                        <a href="category?action=toggle&id=<%= category.getId() %>" 
                                           class="btn <%= category.isStatus() ? "btn-secondary" : "btn-success" %>"
                                           onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái?')">
                                            <%= category.isStatus() ? "Tắt" : "Bật" %>
                                        </a>
                                        <a href="category?action=delete&id=<%= category.getId() %>" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">
                                            Xóa
                                        </a>
                                    <% } else { %>
                                        <span class="btn btn-secondary" style="opacity: 0.5;">Chỉ xem</span>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>

    <script>
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
