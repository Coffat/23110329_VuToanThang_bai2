<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Hệ Thống Quản Lý</title>
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

        .register-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 30px;
            width: 100%;
            max-width: 480px;
            margin: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .brand {
            text-align: center;
            margin-bottom: 20px;
            color: #667eea;
            font-weight: 800;
            letter-spacing: 0.5px;
        }

        .register-header {
            text-align: center;
            margin-bottom: 24px;
        }

        .register-header h1 {
            color: #333;
            margin: 0 0 8px 0;
            font-size: 22px;
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
            background: #fff;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.2);
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .register-btn {
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

        .register-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .alert {
            padding: 10px;
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

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .required {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h1>Đăng Ký Tài Khoản</h1>
            <p>Vui lòng điền thông tin để tạo tài khoản mới</p>
        </div>

        <!-- Display error message -->
        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
        %>
        
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

        <form action="register" method="post" id="registerForm">
            <div class="form-row">
                <div class="form-group">
                    <label for="fullname">Họ và tên <span class="required">*</span></label>
                    <input type="text" 
                           id="fullname" 
                           name="fullname" 
                           value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>"
                           placeholder="Nhập họ và tên"
                           required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="username">Tên đăng nhập <span class="required">*</span></label>
                    <input type="text" 
                           id="username" 
                           name="username" 
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           placeholder="Nhập tên đăng nhập"
                           required>
                </div>
                <div class="form-group">
                    <label for="email">Email <span class="required">*</span></label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                           placeholder="Nhập email"
                           required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="password">Mật khẩu <span class="required">*</span></label>
                    <input type="password" 
                           id="password" 
                           name="password" 
                           placeholder="Nhập mật khẩu"
                           required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu <span class="required">*</span></label>
                    <input type="password" 
                           id="confirmPassword" 
                           name="confirmPassword" 
                           placeholder="Xác nhận mật khẩu"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="tel" 
                       id="phone" 
                       name="phone" 
                       value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                       placeholder="Nhập số điện thoại">
            </div>

            <button type="submit" class="register-btn">Đăng Ký</button>
        </form>

        <div class="login-link">
            <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
        </div>
    </div>

    <script>
        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const fullname = document.getElementById('fullname').value.trim();
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const confirmPassword = document.getElementById('confirmPassword').value.trim();
            
            // Reset previous errors
            document.querySelectorAll('.alert-error').forEach(alert => alert.remove());
            
            let hasError = false;
            let errorMessage = '';
            
            if (fullname === '') {
                errorMessage += 'Vui lòng nhập họ và tên!<br>';
                hasError = true;
            }
            
            if (username === '') {
                errorMessage += 'Vui lòng nhập tên đăng nhập!<br>';
                hasError = true;
            } else if (username.length < 3) {
                errorMessage += 'Tên đăng nhập phải có ít nhất 3 ký tự!<br>';
                hasError = true;
            }
            
            if (email === '') {
                errorMessage += 'Vui lòng nhập email!<br>';
                hasError = true;
            } else if (!isValidEmail(email)) {
                errorMessage += 'Email không hợp lệ!<br>';
                hasError = true;
            }
            
            if (password === '') {
                errorMessage += 'Vui lòng nhập mật khẩu!<br>';
                hasError = true;
            } else if (password.length < 6) {
                errorMessage += 'Mật khẩu phải có ít nhất 6 ký tự!<br>';
                hasError = true;
            }
            
            if (confirmPassword === '') {
                errorMessage += 'Vui lòng xác nhận mật khẩu!<br>';
                hasError = true;
            } else if (password !== confirmPassword) {
                errorMessage += 'Mật khẩu xác nhận không khớp!<br>';
                hasError = true;
            }
            
            if (hasError) {
                e.preventDefault();
                const errorDiv = document.createElement('div');
                errorDiv.className = 'alert alert-error';
                errorDiv.innerHTML = errorMessage;
                document.querySelector('.register-header').after(errorDiv);
            }
        });

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        // Focus first input field on page load
        window.onload = function() {
            document.getElementById('fullname').focus();
        };
    </script>
</body>
</html>
