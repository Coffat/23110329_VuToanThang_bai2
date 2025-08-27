<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Quản Lý</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 50px;
        }

        .login-container {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 30px;
            max-width: 400px;
            margin: 0 auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            color: #333;
            margin-bottom: 10px;
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
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-group input:focus {
            outline: none;
            border-color: #007bff;
        }

        .checkbox-group {
            margin-bottom: 20px;
        }

        .checkbox-group input {
            margin-right: 5px;
        }

        .login-btn {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-btn:hover {
            background-color: #0056b3;
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

        .test-accounts {
            margin-top: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }

        .test-accounts h3 {
            margin-bottom: 10px;
            font-size: 14px;
        }

        .test-account {
            background: white;
            padding: 8px;
            margin-bottom: 5px;
            border-radius: 3px;
            border: 1px solid #ddd;
            font-size: 12px;
            cursor: pointer;
        }

        .test-account:hover {
            background: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Đăng Nhập</h1>
            <p>Vui lòng nhập thông tin để truy cập hệ thống</p>
        </div>

        <!-- Display error message -->
        <%
            String error = (String) request.getAttribute("error");
            String message = (String) request.getAttribute("message");
            String username = (String) request.getAttribute("username");
            if (username == null) username = "";
        %>
        
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>

        <!-- Display success message -->
        <% if (message != null && !message.isEmpty()) { %>
            <div class="alert alert-success">
                <%= message %>
            </div>
        <% } %>

        <form action="login" method="post" id="loginForm">
            <div class="form-group">
                <label for="username">Tên đăng nhập hoặc Email:</label>
                <input type="text" 
                       id="username" 
                       name="username" 
                       value="<%= username %>" 
                       placeholder="Nhập tên đăng nhập hoặc email"
                       required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" 
                       id="password" 
                       name="password" 
                       placeholder="Nhập mật khẩu"
                       required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Ghi nhớ đăng nhập</label>
            </div>

            <button type="submit" class="login-btn">Đăng Nhập</button>
        </form>

        <!-- Test Accounts Section -->
        <div class="test-accounts">
            <h3>Tài khoản test:</h3>
            
            <div class="test-account" onclick="fillLogin('admin', 'admin123')">
                <strong>Admin:</strong> admin / admin123
            </div>
            
            <div class="test-account" onclick="fillLogin('manager', 'manager123')">
                <strong>Manager:</strong> manager / manager123
            </div>
            
            <div class="test-account" onclick="fillLogin('trungnh', '123456')">
                <strong>User:</strong> trungnh / 123456
            </div>
        </div>

        <div class="register-link" style="text-align: center; margin-top: 20px;">
            <p>Chưa có tài khoản? <a href="register.jsp" style="color: #007bff; text-decoration: none;">Đăng ký ngay</a></p>
        </div>
    </div>

    <script>
        // Function to fill login form with test credentials
        function fillLogin(username, password) {
            document.getElementById('username').value = username;
            document.getElementById('password').value = password;
        }

        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (username === '') {
                alert('Vui lòng nhập tên đăng nhập!');
                e.preventDefault();
                return;
            }
            
            if (password === '') {
                alert('Vui lòng nhập mật khẩu!');
                e.preventDefault();
                return;
            }
            
            if (username.length < 3) {
                alert('Tên đăng nhập phải có ít nhất 3 ký tự!');
                e.preventDefault();
                return;
            }
            
            if (password.length < 6) {
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                e.preventDefault();
                return;
            }
        });

        // Focus first input field on page load
        window.onload = function() {
            document.getElementById('username').focus();
        };
    </script>
</body>
</html>
