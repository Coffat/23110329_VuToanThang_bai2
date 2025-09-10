 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Get user information from session
    String username = (String) session.getAttribute("username");
    String fullname = (String) session.getAttribute("fullname");
    String rolename = (String) session.getAttribute("rolename");
    Integer roleid = (Integer) session.getAttribute("roleid");
    
    if (username == null) username = "";
    if (fullname == null) fullname = username;
    if (rolename == null) rolename = "User";
    if (roleid == null) roleid = 3;
    
    // Get current page for active navigation
    String currentPage = request.getRequestURI();
    String contextPath = request.getContextPath();
%>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Custom CSS -->
<style>
    :root {
        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
    }

    body {
        background: var(--primary-gradient);
        min-height: 100vh;
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .navbar-custom {
        background: rgba(255, 255, 255, 0.95) !important;
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand {
        font-weight: 700;
        font-size: 1.5rem;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .nav-link {
        font-weight: 500;
        padding: 8px 16px !important;
        border-radius: 20px;
        transition: all 0.3s ease;
        color: #333 !important;
    }

    .nav-link:hover, .nav-link.active {
        background: var(--primary-gradient);
        color: white !important;
        transform: translateY(-2px);
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: var(--primary-gradient);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        margin-right: 10px;
    }

    .dropdown-toggle::after {
        display: none;
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .card-custom {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .btn-gradient-primary {
        background: var(--primary-gradient);
        border: none;
        color: white;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-gradient-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        color: white;
    }

    .btn-gradient-secondary {
        background: var(--secondary-gradient);
        border: none;
        color: white;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-gradient-secondary:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(240, 147, 251, 0.3);
        color: white;
    }

    .btn-gradient-success {
        background: var(--success-gradient);
        border: none;
        color: white;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-gradient-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(79, 172, 254, 0.3);
        color: white;
    }

    .btn-gradient-warning {
        background: var(--warning-gradient);
        border: none;
        color: white;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-gradient-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(250, 112, 154, 0.3);
        color: white;
    }

    .alert-custom {
        border: none;
        border-radius: 10px;
        padding: 15px 20px;
    }

    .table-custom {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    }

    .table-custom th {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border: none;
        font-weight: 600;
        padding: 15px;
    }

    .table-custom td {
        border: none;
        padding: 15px;
        border-bottom: 1px solid #f1f3f4;
    }

    .table-custom tr:hover {
        background-color: #f8f9fa;
    }

    .form-control-custom {
        border: 2px solid #e9ecef;
        border-radius: 10px;
        padding: 12px 15px;
        transition: all 0.3s ease;
    }

    .form-control-custom:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
    }

    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
    }

    .status-active {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
        border: 1px solid rgba(40, 167, 69, 0.2);
    }

    .status-inactive {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        border: 1px solid rgba(220, 53, 69, 0.2);
    }
</style>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="<%= contextPath %>/">
            <i class="fas fa-home me-2"></i>Hệ Thống Quản Lý
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("/home") || currentPage.contains("/index") || currentPage.equals(contextPath + "/") ? "active" : "" %>" 
                       href="<%= contextPath %>/">
                        <i class="fas fa-home me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("/category") ? "active" : "" %>" 
                       href="<%= contextPath %>/category">
                        <i class="fas fa-folder me-1"></i>Danh Mục
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("/profile") ? "active" : "" %>" 
                       href="<%= contextPath %>/profile.jsp">
                        <i class="fas fa-user me-1"></i>Hồ Sơ
                    </a>
                </li>
            </ul>
            
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" 
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="user-avatar">
                            <%= fullname.substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="d-none d-md-block">
                            <div class="fw-bold"><%= fullname %></div>
                            <small class="text-muted"><%= rolename %></small>
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><h6 class="dropdown-header">Xin chào, <%= fullname %>!</h6></li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="<%= contextPath %>/profile.jsp">
                                <i class="fas fa-user me-2"></i>Hồ Sơ Cá Nhân
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<%= contextPath %>/forgot-password">
                                <i class="fas fa-key me-2"></i>Đổi Mật Khẩu
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="<%= contextPath %>/logout"
                               onclick="return confirm('Bạn có chắc muốn đăng xuất?')">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng Xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
