<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Get user information from session
    String username = (String) session.getAttribute("username");
    String fullname = (String) session.getAttribute("fullname");
    String email = (String) session.getAttribute("email");
    String rolename = (String) session.getAttribute("rolename");
    Integer roleid = (Integer) session.getAttribute("roleid");
    String phone = (String) session.getAttribute("phone");
    
    if (username == null) username = "";
    if (fullname == null) fullname = username;
    if (email == null) email = "Chưa cập nhật";
    if (rolename == null) rolename = "User";
    if (roleid == null) roleid = 3;
    if (phone == null) phone = "Chưa cập nhật";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - Hệ Thống Quản Lý</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

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

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .page-header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .page-header h1 {
            font-size: 36px;
            margin-bottom: 10px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .page-header p {
            font-size: 18px;
            opacity: 0.9;
        }

        .profile-container {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .profile-sidebar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            height: fit-content;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            font-weight: bold;
            margin: 0 auto 20px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .profile-name {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .profile-role {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .role-badge {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .role-badge.admin {
            background-color: #dc3545;
        }

        .role-badge.manager {
            background-color: #ffc107;
            color: #000;
        }

        .profile-stats {
            border-top: 1px solid #eee;
            padding-top: 20px;
        }

        .stat-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
        }

        .stat-value {
            color: #333;
            font-weight: bold;
            font-size: 14px;
        }

        .profile-main {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .profile-section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }

        .info-label {
            font-weight: bold;
            color: #333;
            font-size: 14px;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: #666;
            font-size: 16px;
            word-break: break-word;
        }

        .session-info {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            border-radius: 15px;
            padding: 25px;
            margin-top: 20px;
        }

        .session-info h3 {
            margin-top: 0;
            color: #1976d2;
            font-size: 20px;
            margin-bottom: 15px;
        }

        .session-detail {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid rgba(25, 118, 210, 0.1);
        }

        .session-detail:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .session-label {
            font-weight: 600;
            color: #1976d2;
        }

        .session-value {
            color: #424242;
            font-family: monospace;
            background: rgba(255, 255, 255, 0.7);
            padding: 4px 8px;
            border-radius: 4px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #545b62;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

        .permissions-list {
            margin-top: 20px;
        }

        .permission-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .permission-item:last-child {
            border-bottom: none;
        }

        .permission-icon {
            color: #28a745;
            font-size: 16px;
        }

        .permission-text {
            color: #333;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .profile-container {
                grid-template-columns: 1fr;
            }
            
            .nav-links {
                display: none;
            }
            
            .container {
                padding: 20px 15px;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="home" class="logo">🏠 Hệ Thống Quản Lý</a>
            <div class="nav-links">
                <a href="home" class="nav-link">Trang Chủ</a>
                <a href="category" class="nav-link">Danh Mục</a>
                <a href="profile.jsp" class="nav-link active">Hồ Sơ</a>
            </div>
            <div class="user-info">
                <span>Xin chào, <strong><%= fullname %></strong></span>
                <a href="logout" class="nav-link" onclick="return confirm('Bạn có chắc muốn đăng xuất?')">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1>Hồ Sơ Cá Nhân</h1>
            <p>Quản lý thông tin tài khoản và cài đặt cá nhân</p>
        </div>

        <!-- Profile Container -->
        <div class="profile-container">
            <!-- Sidebar -->
            <div class="profile-sidebar">
                <div class="profile-avatar">
                    <%= fullname.substring(0, 1).toUpperCase() %>
                </div>
                <div class="profile-name"><%= fullname %></div>
                <div class="profile-role">@<%= username %></div>
                <div class="role-badge <%= roleid == 1 ? "admin" : (roleid == 2 ? "manager" : "member") %>">
                    <%= rolename %>
                </div>
                
                <div class="profile-stats">
                    <div class="stat-item">
                        <span class="stat-label">Trạng thái:</span>
                        <span class="stat-value">🟢 Hoạt động</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-label">Lần đăng nhập:</span>
                        <span class="stat-value">Hôm nay</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-label">Quyền hạn:</span>
                        <span class="stat-value">
                            <%= roleid == 1 ? "Toàn quyền" : (roleid == 2 ? "Quản lý" : "Cơ bản") %>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Main Profile Content -->
            <div class="profile-main">
                <!-- Personal Information -->
                <div class="profile-section">
                    <h2 class="section-title">Thông Tin Cá Nhân</h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Tên đăng nhập</div>
                            <div class="info-value"><%= username %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Họ và tên</div>
                            <div class="info-value"><%= fullname %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <div class="info-value"><%= email %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Số điện thoại</div>
                            <div class="info-value"><%= phone %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Vai trò</div>
                            <div class="info-value"><%= rolename %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">ID Người dùng</div>
                            <div class="info-value">#<%= session.getAttribute("userId") != null ? session.getAttribute("userId") : "N/A" %></div>
                        </div>
                    </div>
                </div>

                <!-- Permissions -->
                <div class="profile-section">
                    <h2 class="section-title">Quyền Hạn</h2>
                    <div class="permissions-list">
                        <div class="permission-item">
                            <span class="permission-icon">✅</span>
                            <span class="permission-text">Xem và chỉnh sửa hồ sơ cá nhân</span>
                        </div>
                        <div class="permission-item">
                            <span class="permission-icon">✅</span>
                            <span class="permission-text">Quản lý danh mục cá nhân</span>
                        </div>
                        <div class="permission-item">
                            <span class="permission-icon">✅</span>
                            <span class="permission-text">Đổi mật khẩu</span>
                        </div>
                        <% if (roleid == 1) { %>
                        <div class="permission-item">
                            <span class="permission-icon">✅</span>
                            <span class="permission-text">Quản trị toàn bộ hệ thống</span>
                        </div>
                        <div class="permission-item">
                            <span class="permission-icon">✅</span>
                            <span class="permission-text">Xem tất cả danh mục</span>
                        </div>
                        <% } else if (roleid == 2) { %>
                        <div class="permission-item">
                            <span class="permission-icon">✅</span>
                            <span class="permission-text">Quản lý hoạt động cấp trung</span>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Session Information -->
                <div class="session-info">
                    <h3>Thông Tin Phiên Làm Việc</h3>
                    <div class="session-detail">
                        <span class="session-label">Thời gian đăng nhập:</span>
                        <span class="session-value" id="loginTime"></span>
                    </div>
                    <div class="session-detail">
                        <span class="session-label">ID Phiên:</span>
                        <span class="session-value"><%= session.getId() %></span>
                    </div>
                    <div class="session-detail">
                        <span class="session-label">Trạng thái:</span>
                        <span class="session-value">🟢 Đang hoạt động</span>
                    </div>
                    <div class="session-detail">
                        <span class="session-label">Thời gian hoạt động:</span>
                        <span class="session-value" id="sessionDuration"></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="home" class="btn btn-secondary">
                🏠 Về trang chủ
            </a>
            <a href="forgot-password" class="btn btn-primary">
                🔐 Đổi mật khẩu
            </a>
            <a href="logout" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn đăng xuất?')">
                🚪 Đăng xuất
            </a>
        </div>
    </div>

    <script>
        // Set login time and session duration
        document.addEventListener('DOMContentLoaded', function() {
            // Set current time as login time
            const now = new Date();
            document.getElementById('loginTime').textContent = now.toLocaleString('vi-VN');
            
            // Calculate session duration (simple example)
            const sessionStart = now;
            
            function updateSessionDuration() {
                const now = new Date();
                const duration = Math.floor((now - sessionStart) / 1000); // seconds
                const minutes = Math.floor(duration / 60);
                const seconds = duration % 60;
                document.getElementById('sessionDuration').textContent = 
                    `${minutes} phút ${seconds} giây`;
            }
            
            // Update every second
            updateSessionDuration();
            setInterval(updateSessionDuration, 1000);

            // Add smooth animations
            const cards = document.querySelectorAll('.info-item');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'all 0.3s ease';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
