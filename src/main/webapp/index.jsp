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
    
    if (username == null) username = "";
    if (fullname == null) fullname = username;
    if (email == null) email = "Chưa cập nhật";
    if (rolename == null) rolename = "User";
    if (roleid == null) roleid = 3;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Hệ Thống Quản Lý</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
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
            font-weight: 600;
        }

        .header-actions {
            display: flex;
            gap: 10px;
        }

        .nav-btn {
            background-color: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 16px;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .nav-btn:hover {
            background-color: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        .card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .card h2 {
            color: #333;
            margin-top: 0;
            margin-bottom: 15px;
        }

        .info-row {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: bold;
            color: #333;
        }

        .info-value {
            color: #666;
            margin-left: 10px;
        }

        .role-badge {
            background-color: #007bff;
            color: white;
            padding: 2px 8px;
            border-radius: 3px;
            font-size: 12px;
        }

        .role-badge.admin {
            background-color: #dc3545;
        }

        .role-badge.manager {
            background-color: #ffc107;
            color: #000;
        }

        .session-info {
            background: #e7f3ff;
            border: 1px solid #b3d7ff;
            border-radius: 4px;
            padding: 15px;
            margin-top: 15px;
        }

        .session-info h3 {
            margin-top: 0;
            color: #0056b3;
        }

        .session-info p {
            margin: 5px 0;
            color: #0056b3;
            font-size: 13px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }

        .action-icon {
            font-size: 24px;
            margin-bottom: 8px;
        }

        .action-text {
            font-weight: 600;
            font-size: 14px;
        }

        .card {
            background: white;
            border: none;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>Chào mừng, <%= fullname %>!</h1>
            <div class="header-actions">
                <a href="profile" class="nav-btn">Hồ sơ</a>
                <a href="logout" class="logout-btn">Đăng Xuất</a>
            </div>
        </div>

        <!-- User Information Card -->
        <div class="card">
            <h2>Thông Tin Người Dùng</h2>
            
            <div class="info-row">
                <span class="info-label">Tên đăng nhập:</span>
                <span class="info-value"><%= username %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span class="info-value"><%= email %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Họ và tên:</span>
                <span class="info-value"><%= fullname %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Vai trò:</span>
                <span class="role-badge <%= roleid == 1 ? "admin" : (roleid == 2 ? "manager" : "member") %>">
                    <%= rolename %>
                </span>
            </div>

            <!-- Session Information -->
            <div class="session-info">
                <h3>Thông Tin Phiên Làm Việc</h3>
                <p><strong>Thời gian đăng nhập:</strong> <script>document.write(new Date().toLocaleString('vi-VN'));</script></p>
                <p><strong>ID Phiên:</strong> <%= session.getId() %></p>
                <p><strong>Trạng thái:</strong> Đang hoạt động</p>
            </div>
        </div>

        <!-- System Status -->
        <div class="card">
            <h2>Trạng Thái Hệ Thống</h2>
            <p>Đăng nhập thành công vào hệ thống quản lý.</p>
            <p><strong>Role của bạn:</strong> <%= rolename %></p>
            
            <%
                if (roleid == 1) {
                    out.println("<p>Bạn có quyền quản trị toàn bộ hệ thống.</p>");
                } else if (roleid == 2) {
                    out.println("<p>Bạn có quyền quản lý các hoạt động cấp trung.</p>");
                } else {
                    out.println("<p>Bạn có quyền truy cập các chức năng cơ bản.</p>");
                }
            %>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <h2>Thao Tác Nhanh</h2>
            <div class="quick-actions">
                <a href="profile" class="action-btn">
                    <span class="action-icon">👤</span>
                    <span class="action-text">Hồ sơ</span>
                </a>
                <a href="settings" class="action-btn">
                    <span class="action-icon">⚙️</span>
                    <span class="action-text">Cài đặt</span>
                </a>
                <a href="help" class="action-btn">
                    <span class="action-icon">❓</span>
                    <span class="action-text">Trợ giúp</span>
                </a>
                <a href="logout" class="action-btn">
                    <span class="action-icon">🚪</span>
                    <span class="action-text">Đăng xuất</span>
                </a>
            </div>
        </div>
    </div>

    <script>
        // Add logout confirmation
        document.addEventListener('DOMContentLoaded', function() {
            const logoutBtn = document.querySelector('.logout-btn');
            logoutBtn.addEventListener('click', function(e) {
                if (!confirm('Bạn có chắc chắn muốn đăng xuất không?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
