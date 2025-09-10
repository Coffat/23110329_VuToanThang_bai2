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
    
    <!-- Include Header -->
    <jsp:include page="components/header.jsp" />
    
    <style>
        .profile-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .profile-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="white" opacity="0.1"><path d="M0,50 Q250,0 500,50 T1000,50 L1000,100 L0,100 Z"/></svg>');
            background-size: cover;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            border: 4px solid rgba(255, 255, 255, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: bold;
            margin: 0 auto 1rem;
            position: relative;
            z-index: 1;
        }

        .profile-name {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .profile-role {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .info-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .info-card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 1.5rem;
            border-bottom: 1px solid #dee2e6;
        }

        .info-card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0;
            color: #495057;
        }

        .info-card-body {
            padding: 2rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #f1f3f4;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: var(--primary-gradient);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.25rem;
        }

        .info-value {
            color: #6c757d;
            margin-bottom: 0;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-item {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .stat-label {
            color: #6c757d;
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .security-section {
            background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .security-title {
            color: #856404;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .security-info {
            color: #664d03;
            margin-bottom: 1rem;
        }

        .breadcrumb-custom {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .breadcrumb-custom .breadcrumb {
            margin-bottom: 0;
            background: transparent;
        }

        .role-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-top: 0.5rem;
        }

        .role-admin {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .role-manager {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
        }

        .role-user {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            color: white;
        }

        @media (max-width: 768px) {
            .profile-header {
                padding: 1.5rem;
            }
            
            .profile-avatar {
                width: 100px;
                height: 100px;
                font-size: 2.5rem;
            }
            
            .profile-name {
                font-size: 1.5rem;
            }
            
            .info-card-body {
                padding: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav class="breadcrumb-custom">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="<%= request.getContextPath() %>/" class="text-decoration-none">
                        <i class="fas fa-home me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="fas fa-user me-1"></i>Hồ sơ cá nhân
                </li>
            </ol>
    </nav>

        <div class="profile-container">
            <!-- Profile Header -->
            <div class="profile-header">
                <div class="profile-avatar">
                    <%= fullname.substring(0, 1).toUpperCase() %>
                </div>
                <div class="profile-name"><%= fullname %></div>
                <div class="profile-role">
                    <%= rolename %>
                    <div class="role-badge role-<%= rolename.toLowerCase() %>">
                        <i class="fas fa-<%= roleid == 1 ? "crown" : roleid == 2 ? "user-tie" : "user" %> me-1"></i>
                        <%= rolename %>
                    </div>
                </div>
                </div>
                
            <!-- Stats Grid -->
            <div class="stats-grid">
                    <div class="stat-item">
                    <i class="fas fa-calendar-alt stat-icon"></i>
                    <div class="stat-number">
                        <%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd")) %>
                    </div>
                    <div class="stat-label">Ngày hôm nay</div>
                    </div>
                    <div class="stat-item">
                    <i class="fas fa-clock stat-icon"></i>
                    <div class="stat-number" id="currentTime">--:--</div>
                    <div class="stat-label">Giờ hiện tại</div>
                    </div>
                    <div class="stat-item">
                    <i class="fas fa-user-check stat-icon"></i>
                    <div class="stat-number">Online</div>
                    <div class="stat-label">Trạng thái</div>
                    </div>
                <div class="stat-item">
                    <i class="fas fa-shield-alt stat-icon"></i>
                    <div class="stat-number">Bảo mật</div>
                    <div class="stat-label">Tài khoản</div>
                </div>
            </div>

                <!-- Personal Information -->
            <div class="info-card">
                <div class="info-card-header">
                    <h5 class="info-card-title">
                        <i class="fas fa-user me-2"></i>Thông tin cá nhân
                    </h5>
                </div>
                <div class="info-card-body">
                    <form action="<%= request.getContextPath() %>/profile" method="post" enctype="multipart/form-data" class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" value="<%= fullname %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Tên đăng nhập</label>
                            <input type="text" class="form-control" value="<%= username %>" disabled>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Email</label>
                            <input type="email" class="form-control" value="<%= email %>" disabled>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="<%= phone %>">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-bold">Ảnh đại diện</label>
                            <input type="file" name="avatar" accept="image/*" class="form-control">
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Security Section -->
            <div class="security-section">
                <h6 class="security-title">
                    <i class="fas fa-shield-alt me-2"></i>Bảo mật tài khoản
                </h6>
                <p class="security-info">
                    Để đảm bảo an toàn cho tài khoản của bạn, hãy thường xuyên thay đổi mật khẩu và 
                    không chia sẻ thông tin đăng nhập với người khác.
                </p>
                <div class="d-flex gap-2 flex-wrap">
                    <a href="<%= request.getContextPath() %>/forgot-password" class="btn btn-gradient-warning">
                        <i class="fas fa-key me-2"></i>Đổi mật khẩu
                    </a>
                    <button type="button" class="btn btn-outline-info" onclick="showSecurityTips()">
                        <i class="fas fa-info-circle me-2"></i>Mẹo bảo mật
                    </button>
                    </div>
                </div>

            <!-- System Information -->
            <div class="info-card">
                <div class="info-card-header">
                    <h5 class="info-card-title">
                        <i class="fas fa-cog me-2"></i>Thông tin hệ thống
                    </h5>
                </div>
                <div class="info-card-body">
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Ngày tạo tài khoản</div>
                            <div class="info-value">Không có dữ liệu</div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-sign-in-alt"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Lần đăng nhập cuối</div>
                            <div class="info-value" id="lastLogin">Phiên hiện tại</div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Địa chỉ IP</div>
                            <div class="info-value"><%= request.getRemoteAddr() %></div>
                    </div>
                </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-desktop"></i>
                    </div>
                        <div class="info-content">
                            <div class="info-label">Trình duyệt</div>
                            <div class="info-value" id="userAgent">Đang tải...</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
            <div class="text-center">
        <div class="action-buttons">
                    <a href="<%= request.getContextPath() %>/" class="btn btn-gradient-primary btn-lg">
                        <i class="fas fa-home me-2"></i>Về trang chủ
                    </a>
                    <a href="<%= request.getContextPath() %>/category" class="btn btn-gradient-secondary btn-lg">
                        <i class="fas fa-folder me-2"></i>Quản lý danh mục
                    </a>
                    <a href="<%= request.getContextPath() %>/logout" 
                       class="btn btn-outline-danger btn-lg"
                       onclick="return confirm('Bạn có chắc muốn đăng xuất?')">
                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="components/footer.jsp" />

    <!-- Security Tips Modal -->
    <div class="modal fade" id="securityTipsModal" tabindex="-1" aria-labelledby="securityTipsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="securityTipsModalLabel">
                        <i class="fas fa-shield-alt me-2"></i>Mẹo bảo mật tài khoản
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6><i class="fas fa-key text-primary me-2"></i>Mật khẩu mạnh</h6>
                            <ul class="list-unstyled ps-3">
                                <li>• Ít nhất 8 ký tự</li>
                                <li>• Kết hợp chữ hoa, chữ thường</li>
                                <li>• Có số và ký tự đặc biệt</li>
                                <li>• Không sử dụng thông tin cá nhân</li>
                            </ul>
                            
                            <h6><i class="fas fa-user-secret text-warning me-2"></i>Bảo vệ thông tin</h6>
                            <ul class="list-unstyled ps-3">
                                <li>• Không chia sẻ mật khẩu</li>
                                <li>• Đăng xuất khi không sử dụng</li>
                                <li>• Không lưu mật khẩu trên máy chung</li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <h6><i class="fas fa-wifi text-success me-2"></i>An toàn mạng</h6>
                            <ul class="list-unstyled ps-3">
                                <li>• Tránh WiFi công cộng</li>
                                <li>• Kiểm tra URL trước khi đăng nhập</li>
                                <li>• Cập nhật trình duyệt thường xuyên</li>
                            </ul>
                            
                            <h6><i class="fas fa-bell text-info me-2"></i>Phát hiện bất thường</h6>
                            <ul class="list-unstyled ps-3">
                                <li>• Theo dõi hoạt động đăng nhập</li>
                                <li>• Báo cáo nếu có dấu hiệu lạ</li>
                                <li>• Thay đổi mật khẩu định kỳ</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <a href="<%= request.getContextPath() %>/forgot-password" class="btn btn-gradient-primary">
                        Đổi mật khẩu ngay
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Update current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString('vi-VN', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            document.getElementById('currentTime').textContent = timeString;
        }

        // Update time every second
        setInterval(updateTime, 1000);
        updateTime(); // Initial call

        // Display user agent
        document.getElementById('userAgent').textContent = navigator.userAgent.split(' ')[0] || 'Không xác định';

        // Show security tips modal
        function showSecurityTips() {
            const modal = new bootstrap.Modal(document.getElementById('securityTipsModal'));
            modal.show();
        }

        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Animate stat items
            const statItems = document.querySelectorAll('.stat-item');
            statItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                item.style.transition = 'all 0.6s ease';
                
                setTimeout(() => {
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, index * 150);
            });

            // Add click effect to info items
            document.querySelectorAll('.info-item').forEach(item => {
                item.addEventListener('click', function() {
                    this.style.transform = 'scale(0.98)';
                    setTimeout(() => {
                        this.style.transform = 'scale(1)';
                    }, 150);
                });
            });

            // Display last login time (simulated)
            const lastLoginTime = new Date();
            lastLoginTime.setMinutes(lastLoginTime.getMinutes() - 30);
            document.getElementById('lastLogin').textContent = 
                lastLoginTime.toLocaleString('vi-VN');
        });

        // Copy user info to clipboard
        function copyUserInfo() {
            const userInfo = `
Họ tên: <%= fullname %>
Username: <%= username %>
Email: <%= email %>
Phone: <%= phone %>
Role: <%= rolename %>
            `.trim();
            
            navigator.clipboard.writeText(userInfo).then(() => {
                // Show success toast
                const toast = document.createElement('div');
                toast.className = 'toast show position-fixed bottom-0 end-0 m-3';
                toast.innerHTML = `
                    <div class="toast-header">
                        <i class="fas fa-copy text-primary me-2"></i>
                        <strong class="me-auto">Đã sao chép</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                    </div>
                    <div class="toast-body">
                        Thông tin người dùng đã được sao chép vào clipboard.
                    </div>
                `;
                document.body.appendChild(toast);
                
                setTimeout(() => {
                    toast.remove();
                }, 3000);
            });
        }

        // Add copy button to personal info card
        document.addEventListener('DOMContentLoaded', function() {
            const personalInfoHeader = document.querySelector('.info-card-header h5');
            const copyBtn = document.createElement('button');
            copyBtn.className = 'btn btn-sm btn-outline-secondary ms-2';
            copyBtn.innerHTML = '<i class="fas fa-copy"></i>';
            copyBtn.title = 'Sao chép thông tin';
            copyBtn.onclick = copyUserInfo;
            personalInfoHeader.appendChild(copyBtn);
        });
    </script>
</body>
</html>