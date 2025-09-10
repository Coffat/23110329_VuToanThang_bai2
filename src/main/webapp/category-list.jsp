<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.login.logindemo.model.Category" %>
<%@ page import="com.login.logindemo.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
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
    
    <!-- Include Header -->
    <jsp:include page="components/header.jsp" />
    
    <style>
        .page-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .search-section {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .stats-section {
            margin-bottom: 2rem;
        }

        .stat-card-small {
            background: white;
            border-radius: 12px;
            padding: 1rem;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border: none;
            transition: all 0.3s ease;
        }

        .stat-card-small:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-icon-small {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .categories-table-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .table-header {
            background: var(--primary-gradient);
            color: white;
            padding: 1rem 1.5rem;
        }

        .category-image-cell {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
        }

        .category-placeholder {
            width: 80px;
            height: 80px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 1.5rem;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            border-radius: 6px;
            border: none;
            transition: all 0.3s ease;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .search-highlight {
            background: linear-gradient(120deg, #a8edea 0%, #fed6e3 100%);
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-action {
                width: 100%;
                margin-bottom: 0.25rem;
            }

            .category-image-cell,
            .category-placeholder {
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Page Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-folder-open me-2"></i>Quản Lý Danh Mục
                    </h1>
                    <p class="text-muted mb-0">Tạo, chỉnh sửa và quản lý các danh mục của bạn</p>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <a href="<%= request.getContextPath() %>/" class="btn btn-outline-secondary">
                        <i class="fas fa-home me-1"></i>Trang chủ
                    </a>
                    <a href="<%= request.getContextPath() %>/category?action=add" class="btn btn-gradient-success">
                        <i class="fas fa-plus me-1"></i>Thêm Danh Mục
                    </a>
                    <% if (currentUser != null && currentUser.getRoleid() == 1) { %>
                    <div class="dropdown">
                        <button class="btn btn-gradient-primary dropdown-toggle" type="button" 
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-filter me-1"></i>Bộ lọc
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/category?view=all">
                                <i class="fas fa-globe me-2"></i>Xem tất cả
                            </a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/category?view=mine">
                                <i class="fas fa-user me-2"></i>Danh mục của tôi
                            </a></li>
                        </ul>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger alert-custom">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <%= error %>
            </div>
        <% } %>

        <% if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success alert-custom">
                <i class="fas fa-check-circle me-2"></i>
                <%= success %>
            </div>
        <% } %>

        <!-- Statistics -->
        <div class="stats-section">
            <div class="row g-3">
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card-small">
                        <i class="fas fa-folder stat-icon-small"></i>
                        <div class="fw-bold fs-4"><%= categories.size() %></div>
                        <small class="text-muted">Tổng Danh Mục</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card-small">
                        <i class="fas fa-check-circle stat-icon-small"></i>
                        <div class="fw-bold fs-4 text-success">
                            <%= categories.stream().mapToInt(c -> c.isStatus() ? 1 : 0).sum() %>
                        </div>
                        <small class="text-muted">Đang Hoạt Động</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card-small">
                        <i class="fas fa-times-circle stat-icon-small"></i>
                        <div class="fw-bold fs-4 text-warning">
                            <%= categories.stream().mapToInt(c -> !c.isStatus() ? 1 : 0).sum() %>
                        </div>
                        <small class="text-muted">Không Hoạt Động</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card-small">
                        <i class="fas fa-user stat-icon-small"></i>
                        <div class="fw-bold fs-4 text-info">
                            <%= currentUser != null ? currentUser.getFullname() : "N/A" %>
                        </div>
                        <small class="text-muted">Người dùng hiện tại</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form action="<%= request.getContextPath() %>/category" method="get" class="row g-3 align-items-end">
                <input type="hidden" name="action" value="search">
                <div class="col-md-8">
                    <label for="keyword" class="form-label fw-bold">
                        <i class="fas fa-search me-1"></i>Tìm kiếm danh mục
                    </label>
                    <input type="text" 
                           class="form-control form-control-custom" 
                           id="keyword"
                           name="keyword" 
                           placeholder="Nhập tên danh mục hoặc mô tả..." 
                           value="<%= searchKeyword %>">
                </div>
                <div class="col-md-4">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-gradient-primary flex-fill">
                            <i class="fas fa-search me-1"></i>Tìm kiếm
                        </button>
                        <% if (!searchKeyword.isEmpty()) { %>
                        <a href="<%= request.getContextPath() %>/category" class="btn btn-outline-secondary">
                            <i class="fas fa-times"></i>
                        </a>
                        <% } %>
                    </div>
                </div>
            </form>
            
            <% if (!searchKeyword.isEmpty()) { %>
            <div class="mt-3">
                <div class="search-highlight d-inline-block">
                    <i class="fas fa-search me-1"></i>
                    Kết quả tìm kiếm cho: "<%= searchKeyword %>"
                </div>
            </div>
            <% } %>
        </div>

        <!-- Categories Table -->
        <div class="categories-table-container">
            <div class="table-header">
                <h5 class="mb-0">
                    <i class="fas fa-list me-2"></i>Danh Sách Danh Mục
                    <% if (!searchKeyword.isEmpty()) { %>
                        <small class="opacity-75">(Có <%= categories.size() %> kết quả)</small>
                    <% } %>
                </h5>
            </div>
            
            <% if (categories.isEmpty()) { %>
                <div class="empty-state">
                    <% if (searchKeyword.isEmpty()) { %>
                        <i class="fas fa-folder-open"></i>
                        <h5>Chưa có danh mục nào</h5>
                        <p class="text-muted">Hãy tạo danh mục đầu tiên của bạn</p>
                        <a href="<%= request.getContextPath() %>/category?action=add" class="btn btn-gradient-primary">
                            <i class="fas fa-plus me-2"></i>Tạo danh mục đầu tiên
                        </a>
                    <% } else { %>
                        <i class="fas fa-search"></i>
                        <h5>Không tìm thấy kết quả</h5>
                        <p class="text-muted">Không có danh mục nào phù hợp với từ khóa "<%= searchKeyword %>"</p>
                        <a href="<%= request.getContextPath() %>/category" class="btn btn-gradient-primary">
                            <i class="fas fa-arrow-left me-2"></i>Xem tất cả danh mục
                        </a>
                    <% } %>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th width="5%">ID</th>
                                <th width="10%">Hình ảnh</th>
                                <th width="20%">Tên danh mục</th>
                                <th width="25%">Mô tả</th>
                                <th width="15%">Người tạo</th>
                                <th width="10%">Trạng thái</th>
                                <th width="10%">Ngày tạo</th>
                                <th width="15%">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Category category : categories) { %>
                            <tr>
                                <td class="fw-bold text-primary">#<%= category.getId() %></td>
                                <td>
                                    <% if (category.getImage() != null && !category.getImage().isEmpty()) { %>
                                        <img src="<%= category.getImage() %>" 
                                             alt="Category Image" 
                                             class="category-image-cell">
                                    <% } else { %>
                                        <div class="category-placeholder">
                                            <i class="fas fa-folder"></i>
                                        </div>
                                    <% } %>
                                </td>
                                <td>
                                    <strong><%= category.getName() %></strong>
                                </td>
                                <td>
                                    <% if (category.getDescription() != null && !category.getDescription().isEmpty()) { %>
                                        <% if (category.getDescription().length() > 80) { %>
                                            <span title="<%= category.getDescription() %>">
                                                <%= category.getDescription().substring(0, 80) %>...
                                            </span>
                                        <% } else { %>
                                            <%= category.getDescription() %>
                                        <% } %>
                                    <% } else { %>
                                        <em class="text-muted">Chưa có mô tả</em>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="user-avatar-small me-2">
                                            <%= category.getUserFullname().substring(0, 1).toUpperCase() %>
                                        </div>
                                        <%= category.getUserFullname() %>
                                    </div>
                                </td>
                                <td>
                                    <span class="status-badge <%= category.isStatus() ? "status-active" : "status-inactive" %>">
                                        <i class="fas fa-circle me-1"></i>
                                        <%= category.isStatus() ? "Hoạt động" : "Ngừng hoạt động" %>
                                    </span>
                                </td>
                                <td>
                                    <% if (category.getCreatedDate() != null) { %>
                                        <small><%= category.getCreatedDate().toLocalDate() %></small>
                                    <% } else { %>
                                        <small class="text-muted">N/A</small>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <% if (currentUser != null && (currentUser.getRoleid() == 1 || category.getUserId() == currentUser.getId())) { %>
                                            <a href="<%= request.getContextPath() %>/category?action=edit&id=<%= category.getId() %>" 
                                               class="btn btn-warning btn-action">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<%= request.getContextPath() %>/category?action=toggle&id=<%= category.getId() %>" 
                                               class="btn <%= category.isStatus() ? "btn-secondary" : "btn-success" %> btn-action"
                                               onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái?')"
                                               title="<%= category.isStatus() ? "Tắt" : "Bật" %> danh mục">
                                                <i class="fas fa-<%= category.isStatus() ? "toggle-off" : "toggle-on" %>"></i>
                                            </a>
                                            <a href="<%= request.getContextPath() %>/category?action=delete&id=<%= category.getId() %>" 
                                               class="btn btn-danger btn-action"
                                               onclick="return confirm('Bạn có chắc muốn xóa danh mục này? Thao tác này không thể hoàn tác!')"
                                               title="Xóa danh mục">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        <% } else { %>
                                            <span class="badge bg-light text-dark">
                                                <i class="fas fa-eye me-1"></i>Chỉ xem
                                            </span>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="components/footer.jsp" />

    <style>
        .user-avatar-small {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 0.8rem;
        }
    </style>
</body>
</html>