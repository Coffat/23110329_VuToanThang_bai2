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
    String rolename = (String) session.getAttribute("rolename");
    Integer roleid = (Integer) session.getAttribute("roleid");
    
    if (username == null) username = "";
    if (fullname == null) fullname = username;
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

        .nav-link:hover {
            background-color: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .hero-section {
            text-align: center;
            color: white;
            margin-bottom: 60px;
        }

        .hero-section h1 {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .hero-section p {
            font-size: 20px;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .welcome-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .welcome-card h2 {
            color: #333;
            font-size: 32px;
            margin-bottom: 15px;
        }

        .welcome-card p {
            color: #666;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            font-size: 48px;
            margin-bottom: 20px;
            display: block;
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #666;
            font-size: 16px;
            font-weight: 500;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            border-color: #667eea;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 60px;
            margin-bottom: 20px;
            display: block;
        }

        .feature-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .feature-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .feature-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .feature-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        .quick-actions {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .quick-actions h3 {
            text-align: center;
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 25px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            text-decoration: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .action-icon {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .action-text {
            font-weight: 600;
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .hero-section h1 {
                font-size: 32px;
            }
            
            .hero-section p {
                font-size: 16px;
            }
            
            .container {
                padding: 20px 15px;
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
                <a href="profile.jsp" class="nav-link">Hồ Sơ</a>
            </div>
            <div class="user-info">
                <span>Xin chào, <strong><%= fullname %></strong></span>
                <div class="user-avatar">
                    <%= fullname.substring(0, 1).toUpperCase() %>
                </div>
                <a href="logout" class="nav-link" onclick="return confirm('Bạn có chắc muốn đăng xuất?')">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Hero Section -->
        <div class="hero-section">
            <h1>Chào mừng đến với Hệ Thống Quản Lý</h1>
            <p>Một nền tảng toàn diện giúp bạn quản lý thông tin và dữ liệu một cách hiệu quả</p>
        </div>

        <!-- Welcome Card -->
        <div class="welcome-card">
            <h2>Xin chào, <%= fullname %>! 👋</h2>
            <p>Chúc bạn có một ngày làm việc hiệu quả với vai trò <strong><%= rolename %></strong></p>
        </div>

        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <span class="stat-icon">📊</span>
                <div class="stat-number">100+</div>
                <div class="stat-label">Người dùng hoạt động</div>
            </div>
            <div class="stat-card">
                <span class="stat-icon">📁</span>
                <div class="stat-number">50+</div>
                <div class="stat-label">Danh mục được tạo</div>
            </div>
            <div class="stat-card">
                <span class="stat-icon">⚡</span>
                <div class="stat-number">99.9%</div>
                <div class="stat-label">Thời gian hoạt động</div>
            </div>
            <div class="stat-card">
                <span class="stat-icon">🔒</span>
                <div class="stat-number">100%</div>
                <div class="stat-label">Bảo mật dữ liệu</div>
            </div>
        </div>

        <!-- Features -->
        <div class="features-grid">
            <div class="feature-card">
                <span class="feature-icon">📁</span>
                <div class="feature-title">Quản Lý Danh Mục</div>
                <div class="feature-description">
                    Tạo, chỉnh sửa và quản lý các danh mục của bạn một cách dễ dàng và hiệu quả.
                </div>
                <a href="category" class="feature-btn">Truy cập ngay</a>
            </div>
            
            <div class="feature-card">
                <span class="feature-icon">👤</span>
                <div class="feature-title">Hồ Sơ Cá Nhân</div>
                <div class="feature-description">
                    Xem và cập nhật thông tin cá nhân, quản lý tài khoản của bạn.
                </div>
                <a href="profile.jsp" class="feature-btn">Xem hồ sơ</a>
            </div>
            
            <div class="feature-card">
                <span class="feature-icon">🔐</span>
                <div class="feature-title">Bảo Mật Cao</div>
                <div class="feature-description">
                    Hệ thống được bảo vệ với các cơ chế bảo mật hiện đại và mã hóa dữ liệu.
                </div>
                <a href="forgot-password" class="feature-btn">Đổi mật khẩu</a>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h3>Thao Tác Nhanh</h3>
            <div class="actions-grid">
                <a href="category?action=add" class="action-btn">
                    <span class="action-icon">➕</span>
                    <span class="action-text">Tạo Danh Mục</span>
                </a>
                <a href="category" class="action-btn">
                    <span class="action-icon">📋</span>
                    <span class="action-text">Xem Danh Sách</span>
                </a>
                <a href="profile.jsp" class="action-btn">
                    <span class="action-icon">⚙️</span>
                    <span class="action-text">Cài Đặt</span>
                </a>
                <a href="logout" class="action-btn" onclick="return confirm('Bạn có chắc muốn đăng xuất?')">
                    <span class="action-icon">🚪</span>
                    <span class="action-text">Đăng Xuất</span>
                </a>
            </div>
        </div>
    </div>

    <script>
        // Add smooth scroll and animations
        document.addEventListener('DOMContentLoaded', function() {
            // Animate cards on scroll
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            // Observe all cards
            document.querySelectorAll('.stat-card, .feature-card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = 'all 0.6s ease';
                observer.observe(card);
            });

            // Add loading animation
            setTimeout(() => {
                document.querySelectorAll('.stat-card, .feature-card').forEach((card, index) => {
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, index * 100);
                });
            }, 500);
        });
    </script>
</body>
</html>