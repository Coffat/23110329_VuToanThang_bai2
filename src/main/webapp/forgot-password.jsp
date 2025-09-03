<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if user is already logged in
    if (session.getAttribute("user") != null) {
        response.sendRedirect("home");
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
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .forgot-password-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 30px;
            width: 100%;
            max-width: 480px;
            margin: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .forgot-password-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .forgot-password-header h1 {
            color: #333;
            margin-bottom: 10px;
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .step {
            padding: 8px 16px;
            margin: 0 5px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
        }

        .step.active {
            background-color: #007bff;
            color: white;
        }

        .step.inactive {
            background-color: #e9ecef;
            color: #6c757d;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            font-size: 14px;
            box-sizing: border-box;
            background: #fff;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.2);
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            transition: transform 0.15s ease, box-shadow 0.2s ease;
        }

        .submit-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .alert {
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .back-to-login {
            text-align: center;
            margin-top: 20px;
        }

        .back-to-login a {
            color: #667eea;
            text-decoration: none;
        }

        .back-to-login a:hover {
            text-decoration: underline;
        }

        .email-display {
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            border: 1px solid #dee2e6;
        }

        .email-display strong {
            color: #007bff;
        }

        .password-requirements {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 13px;
        }

        .password-requirements ul {
            margin: 5px 0;
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <div class="forgot-password-container">
        <div class="forgot-password-header">
            <h1>Quên Mật Khẩu</h1>
            <p>Đặt lại mật khẩu cho tài khoản của bạn</p>
        </div>

        <!-- Step Indicator -->
        <div class="step-indicator">
            <div class="step <%= "email".equals(step) ? "active" : "inactive" %>">1. Xác thực Email</div>
            <div class="step <%= "reset".equals(step) ? "active" : "inactive" %>">2. Đặt lại mật khẩu</div>
        </div>

        <!-- Display error message -->
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>

        <!-- Display success message -->
        <% if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success">
                <%= success %>
            </div>
        <% } %>

        <% if ("email".equals(step)) { %>
            <!-- Step 1: Email Verification -->
            <form action="forgot-password" method="post" id="emailForm">
                <input type="hidden" name="action" value="check-email">
                
                <div class="form-group">
                    <label for="email">Email đã đăng ký:</label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           value="<%= email %>" 
                           placeholder="Nhập email đã đăng ký tài khoản"
                           required>
                </div>

                <button type="submit" class="submit-btn">Tiếp tục</button>
            </form>
        <% } else if ("reset".equals(step)) { %>
            <!-- Step 2: Password Reset -->
            <div class="email-display">
                <strong>Email:</strong> <%= email %>
            </div>
            
            <div class="password-requirements">
                <strong>Yêu cầu mật khẩu:</strong>
                <ul>
                    <li>Ít nhất 6 ký tự</li>
                    <li>Mật khẩu xác nhận phải khớp với mật khẩu mới</li>
                </ul>
            </div>

            <form action="forgot-password" method="post" id="resetForm">
                <input type="hidden" name="action" value="reset-password">
                <input type="hidden" name="email" value="<%= email %>">
                
                <div class="form-group">
                    <label for="newPassword">Mật khẩu mới:</label>
                    <input type="password" 
                           id="newPassword" 
                           name="newPassword" 
                           placeholder="Nhập mật khẩu mới"
                           required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                    <input type="password" 
                           id="confirmPassword" 
                           name="confirmPassword" 
                           placeholder="Nhập lại mật khẩu mới"
                           required>
                </div>

                <button type="submit" class="submit-btn">Đặt lại mật khẩu</button>
                
                <div style="text-align: center; margin-top: 15px;">
                    <a href="forgot-password" style="color: #6c757d; font-size: 14px;">← Quay lại nhập email</a>
                </div>
            </form>
        <% } %>

        <div class="back-to-login">
            <p>Nhớ lại mật khẩu? <a href="login.jsp">Đăng nhập ngay</a></p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const currentStep = '<%= step %>';
            
            if (currentStep === 'email') {
                // Email form validation
                const emailForm = document.getElementById('emailForm');
                if (emailForm) {
                    emailForm.addEventListener('submit', function(e) {
                        const email = document.getElementById('email').value.trim();
                        
                        if (email === '') {
                            alert('Vui lòng nhập email!');
                            e.preventDefault();
                            return;
                        }
                        
                        // Basic email validation
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailRegex.test(email)) {
                            alert('Email không hợp lệ!');
                            e.preventDefault();
                            return;
                        }
                    });
                    
                    // Focus first input field
                    document.getElementById('email').focus();
                }
            }
            
            if (currentStep === 'reset') {
                // Password reset form validation
                const resetForm = document.getElementById('resetForm');
                if (resetForm) {
                    resetForm.addEventListener('submit', function(e) {
                        const newPassword = document.getElementById('newPassword').value;
                        const confirmPassword = document.getElementById('confirmPassword').value;
                        
                        if (newPassword === '') {
                            alert('Vui lòng nhập mật khẩu mới!');
                            e.preventDefault();
                            return;
                        }
                        
                        if (newPassword.length < 6) {
                            alert('Mật khẩu phải có ít nhất 6 ký tự!');
                            e.preventDefault();
                            return;
                        }
                        
                        if (confirmPassword === '') {
                            alert('Vui lòng xác nhận mật khẩu!');
                            e.preventDefault();
                            return;
                        }
                        
                        if (newPassword !== confirmPassword) {
                            alert('Mật khẩu xác nhận không khớp!');
                            e.preventDefault();
                            return;
                        }
                    });
                    
                    // Focus first input field
                    document.getElementById('newPassword').focus();
                }
            }
        });
    </script>
</body>
</html>
