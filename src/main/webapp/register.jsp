<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Hệ Thống Quản Lý</title>
    
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

        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
        }

        .register-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .register-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .register-body {
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

        .btn-register {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .alert-custom {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
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

        .password-strength {
            margin-top: 0.5rem;
        }

        .strength-bar {
            height: 4px;
            border-radius: 2px;
            background: #e9ecef;
            overflow: hidden;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            width: 0%;
        }

        .strength-weak { background: #dc3545; width: 25%; }
        .strength-fair { background: #ffc107; width: 50%; }
        .strength-good { background: #17a2b8; width: 75%; }
        .strength-strong { background: #28a745; width: 100%; }

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
            top: 15%;
            left: 15%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 25%;
            right: 15%;
            animation-delay: 2s;
        }

        .floating-element:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 25%;
            left: 25%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        @media (max-width: 576px) {
            .register-card {
                margin: 0;
                border-radius: 0;
                min-height: 100vh;
            }
            
            .register-header {
                padding: 1.5rem;
            }
            
            .register-body {
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

    <div class="register-container">
        <div class="register-card">
            <!-- Header -->
            <div class="register-header">
                <i class="fas fa-user-plus fa-2x mb-3"></i>
                <h1>Đăng Ký Tài Khoản</h1>
                <p class="mb-0">Vui lòng điền thông tin để tạo tài khoản mới</p>
            </div>

            <!-- Body -->
            <div class="register-body">
                <%
                    String error = (String) request.getAttribute("error");
                    String success = (String) request.getAttribute("success");
                %>
                
                <!-- Error Message -->
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger alert-custom">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <%= error %>
                    </div>
                <% } %>

                <!-- Success Message -->
                <% if (success != null && !success.isEmpty()) { %>
                    <div class="alert alert-success alert-custom">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= success %>
                    </div>
                <% } %>

                <!-- Register Form -->
                <form action="register" method="post" id="registerForm" novalidate>
                    <!-- Full Name -->
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-bold">
                            <i class="fas fa-user me-2"></i>Họ và tên <span class="text-danger">*</span>
                        </label>
                        <input type="text" 
                               class="form-control form-control-custom" 
                               id="fullname" 
                               name="fullname" 
                               value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>"
                               placeholder="Nhập họ và tên của bạn"
                               required>
                        <div class="invalid-feedback">
                            Vui lòng nhập họ và tên.
                        </div>
                    </div>

                    <!-- Username and Email Row -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label fw-bold">
                                <i class="fas fa-at me-2"></i>Tên đăng nhập <span class="text-danger">*</span>
                            </label>
                            <input type="text" 
                                   class="form-control form-control-custom" 
                                   id="username" 
                                   name="username" 
                                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                                   placeholder="Tên đăng nhập"
                                   required>
                            <div class="invalid-feedback">
                                Tên đăng nhập phải có ít nhất 3 ký tự.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label fw-bold">
                                <i class="fas fa-envelope me-2"></i>Email <span class="text-danger">*</span>
                            </label>
                            <input type="email" 
                                   class="form-control form-control-custom" 
                                   id="email" 
                                   name="email" 
                                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                   placeholder="your@email.com"
                                   required>
                            <div class="invalid-feedback">
                                Vui lòng nhập email hợp lệ.
                            </div>
                        </div>
                    </div>

                    <!-- Password Row -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label fw-bold">
                                <i class="fas fa-lock me-2"></i>Mật khẩu <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <input type="password" 
                                       class="form-control form-control-custom" 
                                       id="password" 
                                       name="password" 
                                       placeholder="Mật khẩu"
                                       required>
                                <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('password')">
                                    <i class="fas fa-eye" id="toggleIconPassword"></i>
                                </button>
                            </div>
                            <div class="password-strength">
                                <div class="strength-bar">
                                    <div class="strength-fill" id="strengthBar"></div>
                                </div>
                                <small class="text-muted" id="strengthText">Mật khẩu phải có ít nhất 6 ký tự</small>
                            </div>
                            <div class="invalid-feedback">
                                Mật khẩu phải có ít nhất 6 ký tự.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="confirmPassword" class="form-label fw-bold">
                                <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <input type="password" 
                                       class="form-control form-control-custom" 
                                       id="confirmPassword" 
                                       name="confirmPassword" 
                                       placeholder="Xác nhận mật khẩu"
                                       required>
                                <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('confirmPassword')">
                                    <i class="fas fa-eye" id="toggleIconConfirm"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">
                                Mật khẩu xác nhận không khớp.
                            </div>
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="mb-3">
                        <label for="phone" class="form-label fw-bold">
                            <i class="fas fa-phone me-2"></i>Số điện thoại
                        </label>
                        <input type="tel" 
                               class="form-control form-control-custom" 
                               id="phone" 
                               name="phone" 
                               value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                               placeholder="0123456789">
                        <div class="invalid-feedback">
                            Số điện thoại không hợp lệ.
                        </div>
                    </div>

                    <!-- Terms -->
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="terms" required>
                        <label class="form-check-label" for="terms">
                            Tôi đồng ý với <a href="#" class="text-decoration-none">Điều khoản sử dụng</a> 
                            và <a href="#" class="text-decoration-none">Chính sách bảo mật</a>
                        </label>
                        <div class="invalid-feedback">
                            Bạn phải đồng ý với điều khoản sử dụng.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-register btn-primary w-100 mb-3">
                        <i class="fas fa-user-plus me-2"></i>Tạo Tài Khoản
                    </button>
                </form>

                <!-- Login Link -->
                <div class="divider">
                    <span>hoặc</span>
                </div>

                <div class="text-center">
                    <p class="mb-0">Đã có tài khoản? 
                        <a href="login" class="text-decoration-none fw-bold">
                            Đăng nhập ngay
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Toggle password visibility
        function togglePassword(fieldId) {
            const passwordField = document.getElementById(fieldId);
            const toggleIcon = document.getElementById('toggleIcon' + (fieldId === 'password' ? 'Password' : 'Confirm'));
            
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

        // Password strength checker
        function checkPasswordStrength(password) {
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            let text = '';
            
            if (password.length >= 6) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            strengthBar.className = 'strength-fill';
            
            switch (strength) {
                case 0:
                case 1:
                    strengthBar.classList.add('strength-weak');
                    text = 'Mật khẩu yếu';
                    break;
                case 2:
                    strengthBar.classList.add('strength-fair');
                    text = 'Mật khẩu trung bình';
                    break;
                case 3:
                    strengthBar.classList.add('strength-good');
                    text = 'Mật khẩu tốt';
                    break;
                case 4:
                case 5:
                    strengthBar.classList.add('strength-strong');
                    text = 'Mật khẩu mạnh';
                    break;
            }
            
            strengthText.textContent = text;
        }

        // Email validation
        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        // Phone validation
        function isValidPhone(phone) {
            return /^[0-9]{10,11}$/.test(phone.replace(/\s/g, ''));
        }

        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const form = this;
            const fullname = document.getElementById('fullname');
            const username = document.getElementById('username');
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const phone = document.getElementById('phone');
            const terms = document.getElementById('terms');
            
            let isValid = true;

            // Reset validation
            [fullname, username, email, password, confirmPassword, phone, terms].forEach(field => {
                field.classList.remove('is-invalid', 'is-valid');
            });

            // Validate fullname
            if (!fullname.value.trim()) {
                fullname.classList.add('is-invalid');
                isValid = false;
            } else {
                fullname.classList.add('is-valid');
            }

            // Validate username
            if (!username.value.trim() || username.value.trim().length < 3) {
                username.classList.add('is-invalid');
                isValid = false;
            } else {
                username.classList.add('is-valid');
            }

            // Validate email
            if (!email.value.trim() || !isValidEmail(email.value.trim())) {
                email.classList.add('is-invalid');
                isValid = false;
            } else {
                email.classList.add('is-valid');
            }

            // Validate password
            if (!password.value.trim() || password.value.trim().length < 6) {
                password.classList.add('is-invalid');
                isValid = false;
            } else {
                password.classList.add('is-valid');
            }

            // Validate confirm password
            if (!confirmPassword.value.trim() || password.value !== confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                isValid = false;
            } else {
                confirmPassword.classList.add('is-valid');
            }

            // Validate phone (optional but if provided must be valid)
            if (phone.value.trim() && !isValidPhone(phone.value.trim())) {
                phone.classList.add('is-invalid');
                isValid = false;
            } else if (phone.value.trim()) {
                phone.classList.add('is-valid');
            }

            // Validate terms
            if (!terms.checked) {
                terms.classList.add('is-invalid');
                isValid = false;
            } else {
                terms.classList.add('is-valid');
            }

            if (isValid) {
                // Add loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang tạo tài khoản...';
                
                // Submit form
                form.submit();
            }
        });

        // Real-time validation
        document.getElementById('password').addEventListener('input', function() {
            checkPasswordStrength(this.value);
            if (this.classList.contains('is-invalid') && this.value.length >= 6) {
                this.classList.remove('is-invalid');
            }
        });

        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            if (this.classList.contains('is-invalid') && this.value === password) {
                this.classList.remove('is-invalid');
            }
        });

        ['fullname', 'username', 'email'].forEach(fieldId => {
            const field = document.getElementById(fieldId);
            field.addEventListener('input', function() {
                if (this.classList.contains('is-invalid') && this.value.trim()) {
                    this.classList.remove('is-invalid');
                }
            });
        });

        // Focus first input field on page load
        window.addEventListener('load', function() {
            document.getElementById('fullname').focus();
        });
    </script>
</body>
</html>
