# Hướng Dẫn Deploy Ứng Dụng

## 🚀 Cách Chạy Ứng Dụng

### Phương Pháp 1: Chạy với Maven Tomcat Plugin

```bash
# Build và chạy ứng dụng
./mvnw clean compile
./mvnw tomcat7:run
```

Ứng dụng sẽ chạy trên: `http://localhost:8080/`

### Phương Pháp 2: Deploy lên Tomcat Server

1. **Build WAR file:**
```bash
./mvnw clean package -DskipTests
```

2. **Deploy:**
- File WAR sẽ được tạo: `target/ROOT.war`
- Rename file `ROOT.war` thành `ROOT.war` (nếu chưa đúng)
- Copy vào thư mục `webapps` của Tomcat
- Xóa thư mục `ROOT` cũ trong `webapps` (nếu có)
- Khởi động Tomcat

### Phương Pháp 3: Chạy với IDE

1. Import project vào IDE (IntelliJ IDEA, Eclipse)
2. Configure Tomcat server
3. Set deployment context path = `/` (root)
4. Deploy và run

## 🌐 URL Ứng Dụng

Sau khi deploy thành công, các URL sẽ là:

- **Trang chủ:** `http://localhost:8080/`
- **Đăng nhập:** `http://localhost:8080/login`
- **Đăng ký:** `http://localhost:8080/register`
- **Quản lý danh mục:** `http://localhost:8080/category`
- **Hồ sơ:** `http://localhost:8080/profile.jsp`
- **Đăng xuất:** `http://localhost:8080/logout`

## 🔐 Tài Khoản Test

- **Admin:** username=`admin`, password=`admin123`
- **Manager:** username=`manager`, password=`manager123`
- **User:** username=`trungnh`, password=`123456`

## 🗄️ Cấu Hình Database

Đảm bảo SQL Server đang chạy với:
- **Server:** localhost:1433
- **Database:** BT2
- **Username:** sa
- **Password:** Admin@123

## 📝 Ghi Chú

- Context path đã được cấu hình thành `/` để loại bỏ prefix `/login-demo`
- File WAR được build với tên `ROOT.war` để deploy ở root context
- Tomcat plugin đã được cấu hình path `/`
