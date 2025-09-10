<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<%
    // Check if user is already logged in
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    
    String step = (String) request.getAttribute("step");
    String email = (String) request.getAttribute("email");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    
    if (step == null) step = "email";
    if (email == null) email = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Hệ Thống Quản Lý</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --warning-gradient: linear-gradient(135deg, #ffa726 0%, #fb8c00 100%);
        }

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .forgot-password-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .forgot-password-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
        }

        .card-header-custom {
            background: var(--warning-gradient);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .card-header-custom h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .card-body-custom {
            padding: 2rem;
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }

        .step {
            display: flex;
            align-items: center;
            position: relative;
        }

        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin: 0 1rem;
            transition: all 0.3s ease;
        }

        .step.active .step-number {
            background: var(--primary-gradient);
            color: white;
        }

        .step.completed .step-number {
            background: #28a745;
            color: white;
        }

        .step-line {
            width: 50px;
            height: 2px;
            background: #e9ecef;
            transition: all 0.3s ease;
        }

        .step.completed + .step .step-line {
            background: #28a745;
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

        .btn-primary-custom {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .alert-custom {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
        }

        .security-tips {
            background: linear-gradient(135deg, #e8f5e8 0%, #f0f8f0 100%);
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }

        .security-tips h6 {
            color: #2d5016;
            margin-bottom: 1rem;
        }

        .security-tips ul {
            margin-bottom: 0;
            padding-left: 1.2rem;
        }

        .security-tips li {
            color: #2d5016;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
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
            top: 60%;
            right: 15%;
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

        .email-preview {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            border-left: 4px solid #ffa726;
        }

        .countdown {
            font-weight: bold;
            color: #ffa726;
        }

        @media (max-width: 576px) {
            .forgot-password-card {
                margin: 0;
                border-radius: 0;
                min-height: 100vh;
            }
            
            .card-header-custom {
                padding: 1.5rem;
            }
            
            .card-body-custom {
                padding: 1.5rem;
            }

            .step-indicator {
                flex-direction: column;
                align-items: center;
            }

            .step-line {
                width: 2px;
                height: 30px;
                margin: 0.5rem 0;
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

    <div class="forgot-password-container">
        <div class="forgot-password-card">
            <!-- Header -->
            <div class="card-header-custom">
                <i class="fas fa-key fa-2x mb-3"></i>
                <h1>Khôi Phục Mật Khẩu</h1>
                <p class="mb-0">
                    <% if ("email".equals(step)) { %>
                        Nhập email để nhận hướng dẫn khôi phục
                    <% } else if ("verification".equals(step)) { %>
                        Kiểm tra email và nhập mã xác thực
                    <% } else { %>
                        Tạo mật khẩu mới cho tài khoản
                    <% } %>
                </p>
            </div>

            <!-- Body -->
            <div class="card-body-custom">
                <!-- Step Indicator -->
                <div class="step-indicator d-none d-md-flex">
                    <div class="step <%= "email".equals(step) ? "active" : "completed" %>">
                        <div class="step-number">1</div>
                    </div>
                    <div class="step-line"></div>
                    <div class="step <%= "verification".equals(step) ? "active" : ("reset".equals(step) ? "completed" : "") %>">
                        <div class="step-number">2</div>
                    </div>
                    <div class="step-line"></div>
                    <div class="step <%= "reset".equals(step) ? "active" : "" %>">
                        <div class="step-number">3</div>
                    </div>
                </div>

                <!-- Messages -->
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger alert-custom">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <%= error %>
                    </div>
                <% } %>

                <% if (success != null && !success.isEmpty()) { %>
                    <div class="alert alert-success alert-custom">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= success %>
                    </div>
                <% } %>

                <!-- Step 1: Email Input -->
                <% if ("email".equals(step)) { %>
                <form action="<%= request.getContextPath() %>/forgot-password" method="post" id="emailForm" novalidate>
                    <input type="hidden" name="step" value="email">
                    
                    <div class="mb-4">
                        <label for="email" class="form-label fw-bold">
                            <i class="fas fa-envelope me-2"></i>Địa chỉ email <span class="text-danger">*</span>
                        </label>
                        <input type="email" 
                               class="form-control form-control-custom" 
                               id="email" 
                               name="email" 
                               value="<%= email %>"
                               placeholder="Nhập địa chỉ email của bạn"
                               required>
                        <div class="invalid-feedback">
                            Vui lòng nhập địa chỉ email hợp lệ.
                        </div>
                        <small class="form-text text-muted">
                            Chúng tôi sẽ gửi hướng dẫn khôi phục mật khẩu đến email này.
                        </small>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 mb-3">
                        <i class="fas fa-paper-plane me-2"></i>Gửi hướng dẫn khôi phục
                    </button>
                </form>

                <!-- Step 2: Verification Code -->
                <% } else if ("verification".equals(step)) { %>
                <form action="<%= request.getContextPath() %>/forgot-password" method="post" id="verificationForm" novalidate>
                    <input type="hidden" name="step" value="verification">
                    <input type="hidden" name="email" value="<%= email %>">
                    
                    <div class="email-preview">
                        <strong>Email đã gửi đến:</strong> <%= email %>
                        <br>
                        <small class="text-muted">
                            Mã xác thực có hiệu lực trong <span class="countdown" id="countdown">10:00</span>
                        </small>
                    </div>
                    
                    <div class="mb-4 mt-4">
                        <label for="code" class="form-label fw-bold">
                            <i class="fas fa-shield-alt me-2"></i>Mã xác thực <span class="text-danger">*</span>
                        </label>
                        <input type="text" 
                               class="form-control form-control-custom" 
                               id="code" 
                               name="code" 
                               placeholder="Nhập mã 6 số"
                               maxlength="6"
                               pattern="[0-9]{6}"
                               required>
                        <div class="invalid-feedback">
                            Vui lòng nhập mã xác thực 6 số.
                        </div>
                        <small class="form-text text-muted">
                            Kiểm tra hộp thư đến và thư mục spam của bạn.
                        </small>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 mb-3">
                        <i class="fas fa-check me-2"></i>Xác thực mã
                    </button>
                    
                    <div class="text-center">
                        <button type="button" class="btn btn-link" id="resendCode">
                            <i class="fas fa-redo me-1"></i>Gửi lại mã
                        </button>
                    </div>
                </form>

                <!-- Step 3: Reset Password -->
                <% } else { %>
                <form action="<%= request.getContextPath() %>/forgot-password" method="post" id="resetForm" novalidate>
                    <input type="hidden" name="step" value="reset">
                    <input type="hidden" name="email" value="<%= email %>">
                    
                    <div class="mb-3">
                        <label for="newPassword" class="form-label fw-bold">
                            <i class="fas fa-lock me-2"></i>Mật khẩu mới <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <input type="password" 
                                   class="form-control form-control-custom" 
                                   id="newPassword" 
                                   name="newPassword" 
                                   placeholder="Nhập mật khẩu mới"
                                   required>
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('newPassword')">
                                <i class="fas fa-eye" id="toggleIconNew"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            Mật khẩu phải có ít nhất 6 ký tự.
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label fw-bold">
                            <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <input type="password" 
                                   class="form-control form-control-custom" 
                                   id="confirmPassword" 
                                   name="confirmPassword" 
                                   placeholder="Nhập lại mật khẩu mới"
                                   required>
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('confirmPassword')">
                                <i class="fas fa-eye" id="toggleIconConfirm"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            Mật khẩu xác nhận không khớp.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 mb-3">
                        <i class="fas fa-save me-2"></i>Cập nhật mật khẩu
                    </button>
                </form>
                <% } %>

                <!-- Back to Login -->
                <div class="text-center">
                    <a href="<%= request.getContextPath() %>/login" class="text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại đăng nhập
                    </a>
                </div>

                <!-- Security Tips -->
                <div class="security-tips">
                    <h6><i class="fas fa-shield-alt me-2"></i>Lời khuyên bảo mật</h6>
                    <ul>
                        <li>Sử dụng mật khẩu mạnh với ít nhất 8 ký tự</li>
                        <li>Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt</li>
                        <li>Không sử dụng mật khẩu giống nhau cho nhiều tài khoản</li>
                        <li>Thường xuyên thay đổi mật khẩu</li>
                    </ul>
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
            const toggleIcon = document.getElementById('toggleIcon' + (fieldId === 'newPassword' ? 'New' : 'Confirm'));
            
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

        // Email validation
        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        // Email form validation
        <% if ("email".equals(step)) { %>
        document.getElementById('emailForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const email = document.getElementById('email');
            let isValid = true;

            // Reset validation
            email.classList.remove('is-invalid', 'is-valid');

            // Validate email
            if (!email.value.trim() || !isValidEmail(email.value.trim())) {
                email.classList.add('is-invalid');
                isValid = false;
            } else {
                email.classList.add('is-valid');
            }

            if (isValid) {
                // Add loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
                
                // Submit form
                this.submit();
            }
        });
        <% } %>

        // Verification form validation
        <% if ("verification".equals(step)) { %>
        document.getElementById('verificationForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const code = document.getElementById('code');
            let isValid = true;

            // Reset validation
            code.classList.remove('is-invalid', 'is-valid');

            // Validate code
            if (!code.value.trim() || !/^[0-9]{6}$/.test(code.value.trim())) {
                code.classList.add('is-invalid');
                isValid = false;
            } else {
                code.classList.add('is-valid');
            }

            if (isValid) {
                // Add loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xác thực...';
                
                // Submit form
                this.submit();
            }
        });

        // Countdown timer
        let timeLeft = 600; // 10 minutes
        function updateCountdown() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            document.getElementById('countdown').textContent = 
                `${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                document.getElementById('countdown').textContent = 'Hết hạn';
                document.getElementById('countdown').style.color = '#dc3545';
            } else {
                timeLeft--;
            }
        }
        
        setInterval(updateCountdown, 1000);
        updateCountdown();

        // Resend code
        document.getElementById('resendCode').addEventListener('click', function() {
            if (confirm('Gửi lại mã xác thực?')) {
                // Reset timer
                timeLeft = 600;
                document.getElementById('countdown').style.color = '#ffa726';
                
                // In a real application, this would make an AJAX request
                alert('Mã xác thực mới đã được gửi!');
            }
        });
        <% } %>

        // Reset password form validation
        <% if ("reset".equals(step)) { %>
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            let isValid = true;

            // Reset validation
            [newPassword, confirmPassword].forEach(field => {
                field.classList.remove('is-invalid', 'is-valid');
            });

            // Validate new password
            if (!newPassword.value.trim() || newPassword.value.trim().length < 6) {
                newPassword.classList.add('is-invalid');
                isValid = false;
            } else {
                newPassword.classList.add('is-valid');
            }

            // Validate confirm password
            if (!confirmPassword.value.trim() || newPassword.value !== confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                isValid = false;
            } else {
                confirmPassword.classList.add('is-valid');
            }

            if (isValid) {
                // Add loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang cập nhật...';
                
                // Submit form
                this.submit();
            }
        });
        <% } %>

        // Auto-focus first input
        document.addEventListener('DOMContentLoaded', function() {
            const firstInput = document.querySelector('input[type="email"], input[type="text"], input[type="password"]');
            if (firstInput) {
                firstInput.focus();
            }
        });

        // Real-time validation
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('input', function() {
                if (this.classList.contains('is-invalid')) {
                    // Re-validate on input
                    if (this.type === 'email' && isValidEmail(this.value)) {
                        this.classList.remove('is-invalid');
                        this.classList.add('is-valid');
                    } else if (this.type === 'text' && /^[0-9]{6}$/.test(this.value)) {
                        this.classList.remove('is-invalid');
                        this.classList.add('is-valid');
                    } else if (this.type === 'password' && this.value.length >= 6) {
                        this.classList.remove('is-invalid');
                        this.classList.add('is-valid');
                    }
                }
            });
        });
    </script>
</body>
</html>