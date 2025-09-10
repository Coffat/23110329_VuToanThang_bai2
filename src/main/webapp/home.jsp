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
    
    <!-- Include Header -->
    <jsp:include page="components/header.jsp" />
    
    <!-- Custom styles for homepage -->
    <style>
        .hero-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem 2rem;
            text-align: center;
            color: white;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .hero-section h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .hero-section p {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .welcome-card {
            background: var(--primary-gradient);
            color: white;
            border: none;
            margin-bottom: 2rem;
        }

        .stats-row {
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border: none;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            display: block;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .stat-label {
            color: #6c757d;
            font-weight: 500;
            margin-bottom: 0;
        }

        .features-section .card {
            border: none;
            border-radius: 20px;
            transition: all 0.3s ease;
            height: 100%;
            overflow: hidden;
        }

        .features-section .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .feature-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .quick-actions {
            background: white;
            border: none;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .action-btn {
            background: var(--secondary-gradient);
            border: none;
            color: white;
            border-radius: 15px;
            padding: 1rem;
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            text-align: center;
            margin-bottom: 1rem;
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(240, 147, 251, 0.3);
            color: white;
        }

        .action-btn:last-child {
            margin-bottom: 0;
        }

        .action-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            display: block;
        }

        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .management-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .management-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .management-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .management-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .management-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .management-description {
            color: #6c757d;
            margin-bottom: 1.5rem;
        }

        .management-actions {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .management-btn {
            padding: 0.75rem 1rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .management-btn i {
            margin-right: 0.5rem;
        }

        .btn-view {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .btn-add {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .btn-manage {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
        }

        .btn-view:hover, .btn-add:hover, .btn-manage:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2rem;
            }
            
            .hero-section p {
                font-size: 1rem;
            }
            
            .hero-section {
                padding: 2rem 1rem;
            }

            .management-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Animation for cards */
        .fade-in-up {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .fade-in-up.visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <div class="container-fluid px-0">
        <!-- Hero Section -->
        <div class="container mt-4">
            <div class="hero-section fade-in-up">
                <h1>🏠 Hệ Thống Quản Lý Tổng Hợp</h1>
                <p>Nền tảng quản lý danh mục và sản phẩm hiện đại, giúp bạn tổ chức và quản lý dữ liệu một cách hiệu quả</p>
                <div class="d-flex gap-3 justify-content-center flex-wrap">
                    <a href="<%= request.getContextPath() %>/category" class="btn btn-gradient-primary btn-lg">
                        <i class="fas fa-folder me-2"></i>Quản Lý Danh Mục
                    </a>
                    <a href="<%= request.getContextPath() %>/product" class="btn btn-gradient-secondary btn-lg">
                        <i class="fas fa-box me-2"></i>Quản Lý Sản Phẩm
                    </a>
                </div>
            </div>
        </div>

        <!-- Welcome Card -->
        <div class="container">
            <div class="card card-custom welcome-card fade-in-up">
                <div class="card-body text-center py-4">
                    <h2 class="card-title mb-3">
                        <i class="fas fa-hand-wave me-2"></i>Xin chào, <%= fullname %>!
                    </h2>
                    <p class="card-text mb-0">
                        Chúc bạn có một ngày làm việc hiệu quả với vai trò <strong><%= rolename %></strong>
                    </p>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="container">
            <div class="row stats-row g-4 fade-in-up">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <i class="fas fa-users stat-icon"></i>
                        <div class="stat-number">100+</div>
                        <p class="stat-label">Người dùng hoạt động</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <i class="fas fa-folder stat-icon"></i>
                        <div class="stat-number">50+</div>
                        <p class="stat-label">Danh mục được tạo</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <i class="fas fa-box stat-icon"></i>
                        <div class="stat-number">500+</div>
                        <p class="stat-label">Sản phẩm quản lý</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <i class="fas fa-shield-alt stat-icon"></i>
                        <div class="stat-number">100%</div>
                        <p class="stat-label">Bảo mật dữ liệu</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Management Section -->
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="mb-3">
                    <i class="fas fa-cogs me-2"></i>Quản Lý Hệ Thống
                </h2>
                <p class="text-muted">Truy cập nhanh các chức năng quản lý chính</p>
            </div>

            <div class="management-grid fade-in-up">
                <!-- Category Management -->
                <div class="management-card">
                    <div class="management-header">
                        <i class="fas fa-folder-open management-icon"></i>
                        <h3 class="management-title">Quản Lý Danh Mục</h3>
                        <p class="management-description">
                            Tạo, chỉnh sửa và tổ chức các danh mục sản phẩm. 
                            Quản lý phân loại và cấu trúc danh mục hiệu quả.
                        </p>
                    </div>
                    <div class="management-actions">
                        <a href="<%= request.getContextPath() %>/category" class="management-btn btn-view">
                            <i class="fas fa-list"></i>Xem Danh Sách Danh Mục
                        </a>
                        <a href="<%= request.getContextPath() %>/category?action=add" class="management-btn btn-add">
                            <i class="fas fa-plus"></i>Thêm Danh Mục Mới
                        </a>
                        <a href="<%= request.getContextPath() %>/category?view=all" class="management-btn btn-manage">
                            <i class="fas fa-cog"></i>Quản Lý Nâng Cao
                        </a>
                    </div>
                </div>

                <!-- Product Management -->
                <div class="management-card">
                    <div class="management-header">
                        <i class="fas fa-box management-icon"></i>
                        <h3 class="management-title">Quản Lý Sản Phẩm</h3>
                        <p class="management-description">
                            Quản lý toàn bộ sản phẩm, giá cả, kho hàng. 
                            Theo dõi tình trạng và cập nhật thông tin sản phẩm.
                        </p>
                    </div>
                    <div class="management-actions">
                        <a href="<%= request.getContextPath() %>/product" class="management-btn btn-view">
                            <i class="fas fa-list"></i>Xem Danh Sách Sản Phẩm
                        </a>
                        <a href="<%= request.getContextPath() %>/product?action=add" class="management-btn btn-add">
                            <i class="fas fa-plus"></i>Thêm Sản Phẩm Mới
                        </a>
                        <a href="<%= request.getContextPath() %>/product?view=inventory" class="management-btn btn-manage">
                            <i class="fas fa-warehouse"></i>Quản Lý Kho Hàng
                        </a>
                    </div>
                </div>

                <!-- User Management (Admin only) -->
                <% if (roleid == 1) { %>
                <div class="management-card">
                    <div class="management-header">
                        <i class="fas fa-users-cog management-icon"></i>
                        <h3 class="management-title">Quản Lý Người Dùng</h3>
                        <p class="management-description">
                            Quản lý tài khoản người dùng, phân quyền và 
                            theo dõi hoạt động của hệ thống.
                        </p>
                    </div>
                    <div class="management-actions">
                        <a href="<%= request.getContextPath() %>/user" class="management-btn btn-view">
                            <i class="fas fa-list"></i>Danh Sách Người Dùng
                        </a>
                        <a href="<%= request.getContextPath() %>/user?action=add" class="management-btn btn-add">
                            <i class="fas fa-user-plus"></i>Thêm Người Dùng
                        </a>
                        <a href="<%= request.getContextPath() %>/user?view=permissions" class="management-btn btn-manage">
                            <i class="fas fa-key"></i>Quản Lý Quyền
                        </a>
                    </div>
                </div>
                <% } %>

                <!-- Reports & Analytics -->
                <div class="management-card">
                    <div class="management-header">
                        <i class="fas fa-chart-line management-icon"></i>
                        <h3 class="management-title">Báo Cáo & Thống Kê</h3>
                        <p class="management-description">
                            Xem báo cáo chi tiết, thống kê và phân tích 
                            dữ liệu để đưa ra quyết định kinh doanh.
                        </p>
                    </div>
                    <div class="management-actions">
                        <a href="<%= request.getContextPath() %>/reports" class="management-btn btn-view">
                            <i class="fas fa-chart-bar"></i>Xem Báo Cáo
                        </a>
                        <a href="<%= request.getContextPath() %>/analytics" class="management-btn btn-add">
                            <i class="fas fa-analytics"></i>Phân Tích Dữ Liệu
                        </a>
                        <a href="<%= request.getContextPath() %>/export" class="management-btn btn-manage">
                            <i class="fas fa-download"></i>Xuất Dữ Liệu
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="container">
            <div class="quick-actions fade-in-up">
                <h3 class="text-center mb-4">
                    <i class="fas fa-bolt me-2"></i>Thao Tác Nhanh
                </h3>
                <div class="row g-3">
                    <div class="col-lg-2 col-md-4 col-6">
                        <a href="<%= request.getContextPath() %>/category?action=add" class="action-btn">
                            <i class="fas fa-folder-plus action-icon"></i>
                            <div class="fw-bold">Tạo Danh Mục</div>
                        </a>
                    </div>
                    <div class="col-lg-2 col-md-4 col-6">
                        <a href="<%= request.getContextPath() %>/product?action=add" class="action-btn">
                            <i class="fas fa-plus-square action-icon"></i>
                            <div class="fw-bold">Thêm Sản Phẩm</div>
                        </a>
                    </div>
                    <div class="col-lg-2 col-md-4 col-6">
                        <a href="<%= request.getContextPath() %>/category" class="action-btn">
                            <i class="fas fa-list action-icon"></i>
                            <div class="fw-bold">Danh Sách</div>
                        </a>
                    </div>
                    <div class="col-lg-2 col-md-4 col-6">
                        <a href="<%= request.getContextPath() %>/search" class="action-btn">
                            <i class="fas fa-search action-icon"></i>
                            <div class="fw-bold">Tìm Kiếm</div>
                        </a>
                    </div>
                    <div class="col-lg-2 col-md-4 col-6">
                        <a href="<%= request.getContextPath() %>/profile.jsp" class="action-btn">
                            <i class="fas fa-cog action-icon"></i>
                            <div class="fw-bold">Cài Đặt</div>
                        </a>
                    </div>
                    <div class="col-lg-2 col-md-4 col-6">
                        <a href="<%= request.getContextPath() %>/logout" class="action-btn"
                           onclick="return confirm('Bạn có chắc muốn đăng xuất?')">
                            <i class="fas fa-sign-out-alt action-icon"></i>
                            <div class="fw-bold">Đăng Xuất</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="components/footer.jsp" />

    <!-- Additional JavaScript for animations -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Intersection Observer for fade-in animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('visible');
                    }
                });
            }, observerOptions);

            // Observe all fade-in elements
            document.querySelectorAll('.fade-in-up').forEach(element => {
                observer.observe(element);
            });

            // Staggered animation for stat cards
            setTimeout(() => {
                document.querySelectorAll('.stat-card').forEach((card, index) => {
                    card.style.transitionDelay = `${index * 100}ms`;
                });
            }, 100);

            // Counter animation for stat numbers
            function animateCounters() {
                const counters = document.querySelectorAll('.stat-number');
                counters.forEach(counter => {
                    const text = counter.textContent;
                    const hasPlus = text.includes('+');
                    const hasPercent = text.includes('%');
                    
                    let targetNumber;
                    if (hasPercent) {
                        targetNumber = parseFloat(text);
                    } else {
                        targetNumber = parseInt(text);
                    }
                    
                    if (isNaN(targetNumber)) return;
                    
                    let current = 0;
                    const increment = targetNumber / 50;
                    
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= targetNumber) {
                            current = targetNumber;
                            clearInterval(timer);
                        }
                        
                        let display = Math.floor(current);
                        counter.textContent = display + (hasPlus ? '+' : '') + (hasPercent ? '%' : '');
                    }, 30);
                });
            }

            // Start counter animation after elements are visible
            setTimeout(animateCounters, 1000);

            // Add hover effects to management cards
            document.querySelectorAll('.management-card').forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px) scale(1.02)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(-5px) scale(1)';
                });
            });

            // Welcome message based on time of day
            const now = new Date();
            const hour = now.getHours();
            let greeting = 'Xin chào';
            
            if (hour < 12) {
                greeting = 'Chào buổi sáng';
            } else if (hour < 18) {
                greeting = 'Chào buổi chiều';
            } else {
                greeting = 'Chào buổi tối';
            }
            
            const welcomeTitle = document.querySelector('.welcome-card .card-title');
            if (welcomeTitle) {
                welcomeTitle.innerHTML = `<i class="fas fa-hand-wave me-2"></i>${greeting}, <%= fullname %>!`;
            }
        });
    </script>
</body>
</html>
