<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test URLs - Hệ Thống Quản Lý</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .url-list {
            list-style: none;
            padding: 0;
        }
        .url-item {
            margin-bottom: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #007bff;
        }
        .url-item a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
            margin-right: 10px;
        }
        .url-item a:hover {
            text-decoration: underline;
        }
        .description {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }
        .status {
            float: right;
            padding: 2px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: bold;
        }
        .status.working {
            background: #d4edda;
            color: #155724;
        }
        .status.protected {
            background: #fff3cd;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔗 Test URLs - Kiểm tra các đường dẫn</h1>
        
        <ul class="url-list">
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/login" target="_blank">/login</a>
                <span class="status working">✅ Public</span>
                <div class="description">Trang đăng nhập - Không cần authentication</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/register" target="_blank">/register</a>
                <span class="status working">✅ Public</span>
                <div class="description">Trang đăng ký - Không cần authentication</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/forgot-password" target="_blank">/forgot-password</a>
                <span class="status working">✅ Public</span>
                <div class="description">Trang quên mật khẩu - Không cần authentication</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/home" target="_blank">/home</a>
                <span class="status protected">🔒 Protected</span>
                <div class="description">Trang chủ chính - Cần đăng nhập</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/category" target="_blank">/category</a>
                <span class="status protected">🔒 Protected</span>
                <div class="description">Quản lý danh mục - Cần đăng nhập</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/category?action=add" target="_blank">/category?action=add</a>
                <span class="status protected">🔒 Protected</span>
                <div class="description">Thêm danh mục mới - Cần đăng nhập</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/profile.jsp" target="_blank">/profile.jsp</a>
                <span class="status protected">🔒 Protected</span>
                <div class="description">Hồ sơ cá nhân - Cần đăng nhập</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/welcome.jsp" target="_blank">/welcome.jsp</a>
                <span class="status protected">🔒 Protected</span>
                <div class="description">Trang welcome (legacy) - Cần đăng nhập</div>
            </li>
            
            <li class="url-item">
                <a href="<%= request.getContextPath() %>/logout" target="_blank">/logout</a>
                <span class="status protected">🔒 Protected</span>
                <div class="description">Đăng xuất - Cần đã đăng nhập</div>
            </li>
        </ul>
        
        <div style="margin-top: 30px; padding: 20px; background: #e7f3ff; border-radius: 5px;">
            <h3>📝 Hướng dẫn test:</h3>
            <ol>
                <li><strong>Bước 1:</strong> Test các URL Public trước (login, register, forgot-password)</li>
                <li><strong>Bước 2:</strong> Đăng nhập qua <code>/login</code></li>
                <li><strong>Bước 3:</strong> Test các URL Protected (home, category, profile)</li>
                <li><strong>Bước 4:</strong> Test đăng xuất qua <code>/logout</code></li>
            </ol>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="<%= request.getContextPath() %>/login" style="background: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
                🚀 Bắt đầu từ Login
            </a>
        </div>
    </div>
</body>
</html>
