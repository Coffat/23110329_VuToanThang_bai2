<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Quản Lý</title>
    
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
        }

        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 480px;
            width: 100%;
        }

        .login-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .login-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .login-body {
            padding: 2rem;
        }

        .form-control-custom {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control-custom:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .btn-login {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .test-accounts {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1rem;
            margin-top: 1.5rem;
        }

        .test-account {
            background: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 0.75rem;
            margin-bottom: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .test-account:hover {
            background: #e9ecef;
            transform: translateY(-1px);
        }

        .test-account:last-child {
            margin-bottom: 0;
        }

        .divider {
            text-align: center;
            margin: 1.5rem 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #dee2e6;
        }

        .divider span {
            background: white;
            padding: 0 1rem;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .social-login {
            display: flex;
            gap: 1rem;
        }

        .btn-social {
            flex: 1;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 500;
            border: none;
            transition: all 0.3s ease;
        }

        .alert-custom {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
        }

        .floating-elements {
            position: fixed;
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
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 20%;
            right: 10%;
            animation-delay: 2s;
        }

        .floating-element:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        @media (max-width: 576px) {
            .login-card {
                margin: 0;
                border-radius: 0;
                min-height: 100vh;
            }
            
            .login-header {
                padding: 1.5rem;
            }
            
            .login-body {
                padding: 1.5rem;
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

    <div class="login-container">
        <div class="login-card">
            <!-- Header -->
            <div class="login-header">
                <i class="fas fa-lock fa-2x mb-3"></i>
                <h1>Đăng Nhập</h1>
                <p class="mb-0">Vui lòng nhập thông tin để truy cập hệ thống</p>
            </div>

            <!-- Body -->
            <div class="login-body">
                <%
                    String error = (String) request.getAttribute("error");
                    String message = (String) request.getAttribute("message");
                    String username = (String) request.getAttribute("username");
                    if (username == null) username = "";
                %>
                
                <!-- Error Message -->
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger alert-custom">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <%= error %>
                    </div>
                <% } %>

                <!-- Success Message -->
                <% if (message != null && !message.isEmpty()) { %>
                    <div class="alert alert-success alert-custom">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= message %>
                    </div>
                <% } %>

                <!-- Login Form -->
                <form action="login" method="post" id="loginForm" novalidate>
                    <div class="mb-3">
                        <label for="username" class="form-label fw-bold">
                            <i class="fas fa-user me-2"></i>Tên đăng nhập hoặc Email
                        </label>
                        <input type="text" 
                               class="form-control form-control-custom" 
                               id="username" 
                               name="username" 
                               value="<%= username %>" 
                               placeholder="Nhập tên đăng nhập hoặc email"
                               required>
                        <div class="invalid-feedback">
                            Vui lòng nhập tên đăng nhập hoặc email.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label fw-bold">
                            <i class="fas fa-lock me-2"></i>Mật khẩu
                        </label>
                        <div class="input-group">
                            <input type="password" 
                                   class="form-control form-control-custom" 
                                   id="password" 
                                   name="password" 
                                   placeholder="Nhập mật khẩu"
                                   required>
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
                                <i class="fas fa-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            Vui lòng nhập mật khẩu.
                        </div>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="remember" name="remember">
                        <label class="form-check-label" for="remember">
                            Ghi nhớ đăng nhập
                        </label>
                    </div>

                    <button type="submit" class="btn btn-login btn-primary w-100 mb-3">
                        <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                    </button>
                </form>

                <!-- Links -->
                <div class="text-center mb-3">
                    <a href="forgot-password" class="text-decoration-none">
                        <i class="fas fa-key me-1"></i>Quên mật khẩu?
                    </a>
                </div>

                <!-- Test Accounts -->
                <div class="test-accounts">
                    <h6 class="mb-3">
                        <i class="fas fa-vial me-2"></i>Tài khoản test:
                    </h6>
                    
                    <div class="test-account" onclick="fillLogin('admin', 'admin123')">
                        <div class="d-flex justify-content-between align-items-center">
                            <span><strong>Admin:</strong> admin</span>
                            <small class="text-muted">admin123</small>
                        </div>
                    </div>
                    
                    <div class="test-account" onclick="fillLogin('manager', 'manager123')">
                        <div class="d-flex justify-content-between align-items-center">
                            <span><strong>Manager:</strong> manager</span>
                            <small class="text-muted">manager123</small>
                        </div>
                    </div>
                    
                    <div class="test-account" onclick="fillLogin('trungnh', '123456')">
                        <div class="d-flex justify-content-between align-items-center">
                            <span><strong>User:</strong> trungnh</span>
                            <small class="text-muted">123456</small>
                        </div>
                    </div>
                </div>

                <!-- Register Link -->
                <div class="divider">
                    <span>hoặc</span>
                </div>

                <div class="text-center">
                    <p class="mb-0">Chưa có tài khoản? 
                        <a href="register" class="text-decoration-none fw-bold">
                            Đăng ký ngay
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Function to fill login form with test credentials
        function fillLogin(username, password) {
            document.getElementById('username').value = username;
            document.getElementById('password').value = password;
            
            // Remove validation classes
            document.getElementById('username').classList.remove('is-invalid');
            document.getElementById('password').classList.remove('is-invalid');
        }

        // Toggle password visibility
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const form = this;
            const username = document.getElementById('username');
            const password = document.getElementById('password');
            
            let isValid = true;

            // Reset validation
            form.classList.remove('was-validated');
            [username, password].forEach(field => {
                field.classList.remove('is-invalid', 'is-valid');
            });

            // Validate username
            if (!username.value.trim()) {
                username.classList.add('is-invalid');
                isValid = false;
            } else if (username.value.trim().length < 3) {
                username.classList.add('is-invalid');
                username.nextElementSibling.textContent = 'Tên đăng nhập phải có ít nhất 3 ký tự.';
                isValid = false;
            } else {
                username.classList.add('is-valid');
            }

            // Validate password
            if (!password.value.trim()) {
                password.parentNode.querySelector('.invalid-feedback').textContent = 'Vui lòng nhập mật khẩu.';
                password.classList.add('is-invalid');
                isValid = false;
            } else if (password.value.trim().length < 6) {
                password.parentNode.querySelector('.invalid-feedback').textContent = 'Mật khẩu phải có ít nhất 6 ký tự.';
                password.classList.add('is-invalid');
                isValid = false;
            } else {
                password.classList.add('is-valid');
            }

            if (isValid) {
                // Add loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang đăng nhập...';
                
                // Submit form
                form.submit();
            }
        });

        // Real-time validation
        ['username', 'password'].forEach(fieldId => {
            const field = document.getElementById(fieldId);
            field.addEventListener('input', function() {
                if (this.classList.contains('is-invalid') && this.value.trim()) {
                    this.classList.remove('is-invalid');
                }
            });
        });

        // Focus first input field on page load
        window.addEventListener('load', function() {
            document.getElementById('username').focus();
        });

        // Add enter key support for test accounts
        document.querySelectorAll('.test-account').forEach(account => {
            account.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    this.click();
                }
            });
            account.setAttribute('tabindex', '0');
        });
    </script>
</body>
</html>
