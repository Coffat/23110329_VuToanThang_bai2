<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi Hệ Thống - 500</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
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
            max-width: 700px;
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
            background: var(--danger-gradient);
        }

        .error-code {
            font-size: 6rem;
            font-weight: 900;
            margin-bottom: 1rem;
            background: var(--danger-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .error-icon {
            font-size: 4rem;
            margin-bottom: 2rem;
            color: #dc3545;
            opacity: 0.8;
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
            margin: 2rem 0;
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

        .btn-outline-danger {
            border: 2px solid #dc3545;
            color: #dc3545;
            background: transparent;
            border-radius: 12px;
            padding: 10px 22px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .btn-outline-danger:hover {
            background: #dc3545;
            color: white;
            transform: translateY(-2px);
        }

        .error-details {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }

        .error-details h6 {
            color: #495057;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .error-details-content {
            display: none;
            background: white;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            border-left: 4px solid #dc3545;
        }

        .error-details.expanded .error-details-content {
            display: block;
        }

        .error-details .toggle-icon {
            margin-left: auto;
            transition: transform 0.3s ease;
        }

        .error-details.expanded .toggle-icon {
            transform: rotate(180deg);
        }

        .troubleshooting {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }

        .troubleshooting h6 {
            color: #1976d2;
            margin-bottom: 1rem;
        }

        .troubleshooting ul {
            margin-bottom: 0;
            padding-left: 1.2rem;
        }

        .troubleshooting li {
            color: #424242;
            margin-bottom: 0.5rem;
        }

        .support-info {
            background: #fff3cd;
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
        }

        .support-info h6 {
            color: #856404;
            margin-bottom: 1rem;
        }

        .support-info p {
            color: #664d03;
            margin-bottom: 0;
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
            .btn-outline-danger {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-exclamation-circle error-icon"></i>
        <div class="error-code">500</div>
        <div class="error-message">Lỗi Hệ Thống</div>
        <div class="error-description">
            Xin lỗi, đã xảy ra lỗi không mong muốn trong hệ thống. 
            Nhóm kỹ thuật đã được thông báo và đang khắc phục sự cố.
        </div>

        <div class="action-buttons">
            <%
                String contextPath = request.getContextPath();
                boolean isLoggedIn = session.getAttribute("user") != null;
            %>
            
            <% if (isLoggedIn) { %>
                <a href="<%= contextPath %>/" class="btn-gradient-primary">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
            <% } else { %>
                <a href="<%= contextPath %>/login" class="btn-gradient-primary">
                    <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                </a>
            <% } %>
            
            <button type="button" class="btn-outline-danger" onclick="window.history.back()">
                <i class="fas fa-arrow-left me-2"></i>Quay Lại
            </button>
            
            <button type="button" class="btn btn-outline-info" onclick="location.reload()">
                <i class="fas fa-refresh me-2"></i>Thử Lại
            </button>
        </div>

        <!-- Error Details (for debugging - only show in development) -->
        <div class="error-details" onclick="toggleErrorDetails()">
            <h6>
                <i class="fas fa-bug me-2"></i>Chi tiết lỗi (Dành cho nhà phát triển)
                <i class="fas fa-chevron-down toggle-icon"></i>
            </h6>
            <div class="error-details-content">
                <% if (exception != null) { %>
                    <strong>Exception Type:</strong> <%= exception.getClass().getSimpleName() %><br>
                    <strong>Message:</strong> <%= exception.getMessage() != null ? exception.getMessage() : "No message available" %><br>
                    <strong>Request URI:</strong> <%= request.getRequestURI() %><br>
                    <strong>Method:</strong> <%= request.getMethod() %><br>
                    <strong>Time:</strong> <%= new java.util.Date() %><br>
                    <strong>Session ID:</strong> <%= session.getId() %><br>
                    <strong>User Agent:</strong> <%= request.getHeader("User-Agent") %><br>
                <% } else { %>
                    <p>Không có thông tin chi tiết về lỗi.</p>
                <% } %>
            </div>
        </div>

        <!-- Troubleshooting Tips -->
        <div class="troubleshooting">
            <h6><i class="fas fa-tools me-2"></i>Gợi ý khắc phục</h6>
            <ul>
                <li>Thử làm mới trang (F5 hoặc Ctrl+R)</li>
                <li>Xóa cache và cookie của trình duyệt</li>
                <li>Kiểm tra kết nối internet</li>
                <li>Thử lại sau vài phút</li>
                <li>Sử dụng trình duyệt khác</li>
            </ul>
        </div>

        <!-- Support Information -->
        <div class="support-info">
            <h6><i class="fas fa-life-ring me-2"></i>Cần hỗ trợ?</h6>
            <p>
                Nếu lỗi tiếp tục xảy ra, vui lòng liên hệ với nhóm hỗ trợ kỹ thuật 
                và cung cấp mã lỗi: <strong>ERR-500-<%= System.currentTimeMillis() %></strong>
            </p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle error details
        function toggleErrorDetails() {
            const errorDetails = document.querySelector('.error-details');
            errorDetails.classList.toggle('expanded');
        }

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
            const buttons = document.querySelectorAll('.action-buttons > *');
            buttons.forEach((button, index) => {
                button.style.opacity = '0';
                button.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    button.style.transition = 'all 0.6s ease';
                    button.style.opacity = '1';
                    button.style.transform = 'translateY(0)';
                }, 600 + (index * 150));
            });

            // Log error for analytics
            console.error('500 Internal Server Error:', {
                url: window.location.href,
                userAgent: navigator.userAgent,
                timestamp: new Date().toISOString(),
                referrer: document.referrer
            });

            // Auto retry after 10 seconds (optional)
            setTimeout(() => {
                if (confirm('Tự động thử lại trang? Điều này có thể giúp khắc phục lỗi tạm thời.')) {
                    location.reload();
                }
            }, 10000);
        });

        // Report error function
        function reportError() {
            const errorInfo = {
                url: window.location.href,
                userAgent: navigator.userAgent,
                timestamp: new Date().toISOString(),
                errorCode: 'ERR-500-<%= System.currentTimeMillis() %>'
            };
            
            // In a real application, this would send to an error reporting service
            console.log('Error reported:', errorInfo);
            alert('Lỗi đã được báo cáo. Cảm ơn bạn đã giúp chúng tôi cải thiện hệ thống!');
        }

        // Add report error button
        document.addEventListener('DOMContentLoaded', function() {
            const supportInfo = document.querySelector('.support-info');
            const reportBtn = document.createElement('button');
            reportBtn.className = 'btn btn-sm btn-outline-warning mt-2';
            reportBtn.innerHTML = '<i class="fas fa-flag me-1"></i>Báo cáo lỗi';
            reportBtn.onclick = reportError;
            supportInfo.appendChild(reportBtn);
        });
    </script>
</body>
</html>
