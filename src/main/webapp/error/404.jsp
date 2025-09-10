<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Không Tồn Tại - 404</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            position: relative;
            overflow: hidden;
        }

        .error-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--primary-gradient);
        }

        .error-code {
            font-size: 6rem;
            font-weight: 900;
            margin-bottom: 1rem;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .error-icon {
            font-size: 4rem;
            margin-bottom: 2rem;
            color: #6c757d;
            opacity: 0.7;
        }

        .error-message {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 1rem;
        }

        .error-description {
            color: #6c757d;
            margin-bottom: 2rem;
            line-height: 1.6;
            font-size: 1.1rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .btn-gradient-primary {
            background: var(--primary-gradient);
            border: none;
            color: white;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .btn-gradient-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            color: white;
        }

        .btn-outline-secondary {
            border: 2px solid #6c757d;
            color: #6c757d;
            background: transparent;
            border-radius: 12px;
            padding: 10px 22px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .btn-outline-secondary:hover {
            background: #6c757d;
            color: white;
            transform: translateY(-2px);
        }

        .helpful-links {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #dee2e6;
        }

        .helpful-links h6 {
            color: #495057;
            margin-bottom: 1rem;
        }

        .link-item {
            display: inline-block;
            margin: 0.25rem 0.5rem;
        }

        .link-item a {
            color: #6c757d;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .link-item a:hover {
            color: #667eea;
        }

        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-element {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 60px;
            height: 60px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 100px;
            height: 100px;
            top: 60%;
            right: 10%;
            animation-delay: 3s;
        }

        .floating-element:nth-child(3) {
            width: 40px;
            height: 40px;
            bottom: 30%;
            left: 30%;
            animation-delay: 6s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-15px) rotate(120deg); }
            66% { transform: translateY(15px) rotate(240deg); }
        }

        @media (max-width: 768px) {
            .error-container {
                padding: 2rem;
                margin: 1rem;
            }
            
            .error-code {
                font-size: 4rem;
            }
            
            .error-message {
                font-size: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-gradient-primary,
            .btn-outline-secondary {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Floating background elements -->
    <div class="floating-elements">
        <div class="floating-element"></div>
        <div class="floating-element"></div>
        <div class="floating-element"></div>
    </div>

    <div class="error-container">
        <i class="fas fa-exclamation-triangle error-icon"></i>
        <div class="error-code">404</div>
        <div class="error-message">Trang Không Tồn Tại</div>
        <div class="error-description">
            Xin lỗi, trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển. 
            Có thể URL không chính xác hoặc trang đã được chuyển đến vị trí khác.
        </div>

        <div class="action-buttons">
            <%
                String contextPath = request.getContextPath();
                // Check if user is logged in
                boolean isLoggedIn = session.getAttribute("user") != null;
            %>
            
            <% if (isLoggedIn) { %>
                <a href="<%= contextPath %>/" class="btn-gradient-primary">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
                <a href="<%= contextPath %>/category" class="btn-outline-secondary">
                    <i class="fas fa-folder me-2"></i>Danh Mục
                </a>
            <% } else { %>
                <a href="<%= contextPath %>/login" class="btn-gradient-primary">
                    <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                </a>
                <a href="<%= contextPath %>/register" class="btn-outline-secondary">
                    <i class="fas fa-user-plus me-2"></i>Đăng Ký
                </a>
            <% } %>
        </div>

        <div class="helpful-links">
            <h6><i class="fas fa-compass me-2"></i>Liên kết hữu ích</h6>
            <div class="link-item">
                <a href="<%= contextPath %>/login">
                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                </a>
            </div>
            <% if (isLoggedIn) { %>
            <div class="link-item">
                <a href="<%= contextPath %>/">
                    <i class="fas fa-home me-1"></i>Trang chủ
                </a>
            </div>
            <div class="link-item">
                <a href="<%= contextPath %>/category">
                    <i class="fas fa-folder me-1"></i>Danh mục
                </a>
            </div>
            <div class="link-item">
                <a href="<%= contextPath %>/profile.jsp">
                    <i class="fas fa-user me-1"></i>Hồ sơ
                </a>
            </div>
            <% } else { %>
            <div class="link-item">
                <a href="<%= contextPath %>/register">
                    <i class="fas fa-user-plus me-1"></i>Đăng ký
                </a>
            </div>
            <div class="link-item">
                <a href="<%= contextPath %>/forgot-password">
                    <i class="fas fa-key me-1"></i>Quên mật khẩu
                </a>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Animate the error code
            const errorCode = document.querySelector('.error-code');
            errorCode.style.opacity = '0';
            errorCode.style.transform = 'scale(0.5)';
            
            setTimeout(() => {
                errorCode.style.transition = 'all 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
                errorCode.style.opacity = '1';
                errorCode.style.transform = 'scale(1)';
            }, 200);

            // Animate buttons
            const buttons = document.querySelectorAll('.action-buttons a');
            buttons.forEach((button, index) => {
                button.style.opacity = '0';
                button.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    button.style.transition = 'all 0.6s ease';
                    button.style.opacity = '1';
                    button.style.transform = 'translateY(0)';
                }, 600 + (index * 200));
            });

            // Add click tracking for analytics
            document.querySelectorAll('a').forEach(link => {
                link.addEventListener('click', function() {
                    console.log('404 page - Link clicked:', this.href);
                });
            });
        });

        // Auto redirect after 30 seconds if no interaction
        let redirectTimer = setTimeout(() => {
            const isLoggedIn = <%= isLoggedIn %>;
            const redirectUrl = isLoggedIn ? '<%= contextPath %>/' : '<%= contextPath %>/login';
            
            if (confirm('Bạn sẽ được chuyển hướng tự động. Tiếp tục?')) {
                window.location.href = redirectUrl;
            }
        }, 30000);

        // Clear timer if user interacts
        document.addEventListener('click', () => clearTimeout(redirectTimer));
        document.addEventListener('keypress', () => clearTimeout(redirectTimer));
    </script>
</body>
</html>
