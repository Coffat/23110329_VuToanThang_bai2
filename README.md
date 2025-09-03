# Login Demo Application

## Thông tin sinh viên
- **Họ và tên**: Vũ Toàn Thắng
- **MSSV**: 23110329

## Mô tả dự án
Ứng dụng web đăng nhập/đăng ký sử dụng Java Servlet, JSP và SQL Server.

## Công nghệ sử dụng
- **Backend**: Java Servlet, JSP
- **Database**: SQL Server
- **Server**: Apache Tomcat 11.0.10
- **Build Tool**: Maven
- **Frontend**: HTML, CSS, JavaScript

## Tính năng
- ✅ Đăng nhập với validation
- ✅ Đăng ký tài khoản mới
- ✅ Session management
- ✅ Role-based access control
- ✅ Database connection pooling
- ✅ Responsive design

## Cài đặt và chạy

### Yêu cầu hệ thống
- Java 17+
- Apache Tomcat 11.0.10
- SQL Server
- Maven 3.9+

### Bước 1: Clone repository
```bash
git clone https://github.com/Coffat/23110329_VuToanThang_bai2.git
cd 23110329_VuToanThang_bai2
```

### Bước 2: Cấu hình database
1. Tạo database `BT2` trong SQL Server
2. Import file `BT2.sql` để tạo bảng và dữ liệu mẫu
3. Cập nhật thông tin kết nối trong `DBConnection.java` nếu cần

### Bước 3: Build và deploy
```bash
# Build project
mvn clean package

# Copy WAR file vào Tomcat
cp target/ROOT.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh
```

### Bước 4: Truy cập ứng dụng
- Lưu ý: WAR deploy mặc định tên `login_demo_war` → base URL: `http://localhost:8080/login_demo_war/`
- **Trang đăng nhập (welcome)**: `http://localhost:8080/login_demo_war/login`
- **Trang chủ**: `http://localhost:8080/login_demo_war/home`
- **Danh mục**: `http://localhost:8080/login_demo_war/category`
- **Hồ sơ**: `http://localhost:8080/login_demo_war/profile.jsp`
- **Quên mật khẩu**: `http://localhost:8080/login_demo_war/forgot-password`
- **Đăng ký**: `http://localhost:8080/login_demo_war/register`

## Tài khoản test
- **Admin**: admin / admin123
- **Manager**: manager / manager123
- **User**: trungnh / 123456

## Cấu trúc project
```
src/
├── main/
│   ├── java/
│   │   └── com/login/logindemo/
│   │       ├── config/
│   │       │   ├── DBConnection.java
│   │       │   └── ApplicationContextListener.java
│   │       ├── controller/
│   │       │   ├── LoginServlet.java
│   │       │   ├── RegisterServlet.java
│   │       │   ├── LogoutServlet.java
│   │       │   ├── ForgotPasswordServlet.java
│   │       │   ├── CategoryServlet.java
│   │       │   └── HomeServlet.java
│   │       ├── dao/
│   │       │   ├── UserDAO.java
│   │       │   └── CategoryDAO.java
│   │       ├── model/
│   │       │   ├── User.java
│   │       │   └── Category.java
│   │       └── service/
│   │           ├── UserService.java
│   │           └── CategoryService.java
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml
│       │   └── lib/
│       ├── index.jsp          # Trang chủ mới (Dashboard)
│       ├── login.jsp          # Trang đăng nhập
│       ├── register.jsp       # Trang đăng ký
│       ├── profile.jsp        # Trang hồ sơ
│       ├── category.jsp       # Trang danh sách danh mục (category-list.jsp)
│       ├── category-form.jsp  # Form thêm/sửa danh mục
│       ├── forgot-password.jsp
│       └── test-urls.jsp      # Trang kiểm tra các URL
```

## Tác giả
**Vũ Toàn Thắng** - MSSV: 23110329

## License
MIT License
