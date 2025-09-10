<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<%@ page import="com.login.logindemo.model.Category" %>
<%@ page import="com.login.logindemo.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Category category = (Category) request.getAttribute("category");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    
    // For form data preservation
    String name = (String) request.getAttribute("name");
    String description = (String) request.getAttribute("description");
    String image = (String) request.getAttribute("image");
    
    boolean isEdit = category != null;
    if (isEdit) {
        if (name == null) name = category.getName();
        if (description == null) description = category.getDescription();
        if (image == null) image = category.getImage();
    }
    
    if (name == null) name = "";
    if (description == null) description = "";
    if (image == null) image = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Chỉnh Sửa" : "Thêm" %> Danh Mục - Hệ Thống Quản Lý</title>
    
    <!-- Include Header -->
    <jsp:include page="components/header.jsp" />
    
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .form-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .form-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .form-body {
            padding: 2rem;
        }

        .image-preview-container {
            position: relative;
            margin-top: 1rem;
        }

        .image-preview {
            max-width: 100%;
            max-height: 300px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .image-placeholder {
            width: 100%;
            height: 200px;
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #6c757d;
        }

        .image-placeholder i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .remove-image {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .remove-image:hover {
            background: #dc3545;
            transform: scale(1.1);
        }

        .form-actions {
            background: #f8f9fa;
            padding: 1.5rem 2rem;
            border-top: 1px solid #dee2e6;
        }

        .breadcrumb-custom {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .breadcrumb-custom .breadcrumb {
            margin-bottom: 0;
            background: transparent;
        }

        .breadcrumb-custom .breadcrumb-item + .breadcrumb-item::before {
            content: "›";
            font-size: 1.2rem;
            color: #6c757d;
        }

        .character-count {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }

        .character-count.warning {
            color: #ffc107;
        }

        .character-count.danger {
            color: #dc3545;
        }

        .form-tips {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-tips h6 {
            color: #1976d2;
            margin-bottom: 1rem;
        }

        .form-tips ul {
            margin-bottom: 0;
            padding-left: 1.2rem;
        }

        .form-tips li {
            color: #424242;
            margin-bottom: 0.5rem;
        }

        @media (max-width: 768px) {
            .form-header {
                padding: 1.5rem;
            }
            
            .form-body,
            .form-actions {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav class="breadcrumb-custom">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="<%= request.getContextPath() %>/" class="text-decoration-none">
                        <i class="fas fa-home me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="breadcrumb-item">
                    <a href="<%= request.getContextPath() %>/category" class="text-decoration-none">
                        <i class="fas fa-folder me-1"></i>Danh mục
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="fas fa-<%= isEdit ? "edit" : "plus" %> me-1"></i>
                    <%= isEdit ? "Chỉnh sửa" : "Thêm mới" %>
                </li>
            </ol>
    </nav>

        <div class="form-container">
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

            <!-- Form Tips -->
            <div class="form-tips">
                <h6><i class="fas fa-lightbulb me-2"></i>Hướng dẫn tạo danh mục</h6>
                <ul>
                    <li>Tên danh mục nên ngắn gọn, rõ ràng và dễ hiểu</li>
                    <li>Mô tả chi tiết giúp người dùng hiểu rõ hơn về danh mục</li>
                    <li>Hình ảnh nên có kích thước phù hợp (khuyến nghị 400x300px)</li>
                    <li>Kiểm tra kỹ thông tin trước khi lưu</li>
                </ul>
            </div>

            <!-- Form Card -->
            <div class="form-card">
                <!-- Header -->
                <div class="form-header">
                    <i class="fas fa-<%= isEdit ? "edit" : "folder-plus" %> fa-2x mb-3"></i>
                    <h1><%= isEdit ? "Chỉnh Sửa Danh Mục" : "Thêm Danh Mục Mới" %></h1>
                    <p class="mb-0">
                        <%= isEdit ? "Cập nhật thông tin danh mục" : "Điền thông tin để tạo danh mục mới" %>
                    </p>
                </div>

                <!-- Form Body -->
                <div class="form-body">
                    <form action="<%= request.getContextPath() %>/category" method="post" id="categoryForm" novalidate>
                <% if (isEdit) { %>
                            <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= category.getId() %>">
                        <% } else { %>
                            <input type="hidden" name="action" value="create">
                <% } %>

                        <!-- Category Name -->
                        <div class="mb-4">
                            <label for="name" class="form-label fw-bold">
                                <i class="fas fa-tag me-2"></i>Tên danh mục <span class="text-danger">*</span>
                            </label>
                            <input type="text" 
                                   class="form-control form-control-custom" 
                                   id="name" 
                                   name="name" 
                                   value="<%= name %>" 
                                   placeholder="Nhập tên danh mục"
                                   maxlength="100"
                                   required>
                            <div class="character-count">
                                <span id="nameCount">0</span>/100 ký tự
                            </div>
                            <div class="invalid-feedback">
                                Vui lòng nhập tên danh mục (3-100 ký tự).
                            </div>
                        </div>

                        <!-- Category Description -->
                        <div class="mb-4">
                            <label for="description" class="form-label fw-bold">
                                <i class="fas fa-align-left me-2"></i>Mô tả
                            </label>
                            <textarea class="form-control form-control-custom" 
                                      id="description" 
                                      name="description" 
                                      rows="4"
                                      placeholder="Nhập mô tả chi tiết về danh mục..."
                                      maxlength="500"><%= description %></textarea>
                            <div class="character-count">
                                <span id="descCount">0</span>/500 ký tự
                            </div>
                            <small class="form-text text-muted">
                                Mô tả chi tiết giúp người dùng hiểu rõ hơn về danh mục này.
                            </small>
                        </div>

                        <!-- Category Image -->
                        <div class="mb-4">
                            <label for="image" class="form-label fw-bold">
                                <i class="fas fa-image me-2"></i>Hình ảnh danh mục
                            </label>
                            <input type="url" 
                                   class="form-control form-control-custom" 
                                   id="image" 
                                   name="image" 
                                   value="<%= image %>" 
                                   placeholder="https://example.com/image.jpg">
                            <small class="form-text text-muted">
                                Nhập URL của hình ảnh hoặc để trống để sử dụng hình mặc định.
                            </small>
                            <div class="invalid-feedback">
                                Vui lòng nhập URL hình ảnh hợp lệ.
                    </div>

                        <!-- Image Preview -->
                            <div class="image-preview-container">
                                <% if (!image.isEmpty()) { %>
                                    <div id="imagePreviewWrapper">
                                        <img src="<%= image %>" 
                                             alt="Preview" 
                                             class="image-preview" 
                                             id="imagePreview"
                                             onerror="showImagePlaceholder()">
                                        <button type="button" class="remove-image" onclick="removeImage()">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                <% } else { %>
                                    <div class="image-placeholder" id="imagePlaceholder">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <div>Xem trước hình ảnh sẽ hiển thị ở đây</div>
                                        <small class="text-muted">Nhập URL hình ảnh bên trên</small>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <div class="d-flex gap-3 justify-content-end flex-wrap">
                        <a href="<%= request.getContextPath() %>/category" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-2"></i>Hủy bỏ
                        </a>
                        <button type="button" class="btn btn-outline-info" onclick="resetForm()">
                            <i class="fas fa-undo me-2"></i>Đặt lại
                        </button>
                        <button type="submit" form="categoryForm" class="btn btn-gradient-primary">
                            <i class="fas fa-<%= isEdit ? "save" : "plus" %> me-2"></i>
                        <%= isEdit ? "Cập nhật" : "Tạo danh mục" %>
                    </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="components/footer.jsp" />

    <script>
        // Character counting
        function updateCharacterCount(inputId, countId, maxLength) {
            const input = document.getElementById(inputId);
            const counter = document.getElementById(countId);
            const length = input.value.length;
            
            counter.textContent = length;
            counter.parentElement.className = 'character-count';
            
            if (length > maxLength * 0.8) {
                counter.parentElement.classList.add('warning');
            }
            if (length > maxLength * 0.95) {
                counter.parentElement.classList.add('danger');
            }
        }

        // Initialize character counts
        document.addEventListener('DOMContentLoaded', function() {
            updateCharacterCount('name', 'nameCount', 100);
            updateCharacterCount('description', 'descCount', 500);
            
            // Add event listeners
            document.getElementById('name').addEventListener('input', function() {
                updateCharacterCount('name', 'nameCount', 100);
                if (this.classList.contains('is-invalid') && this.value.trim()) {
                    this.classList.remove('is-invalid');
                }
            });
            
            document.getElementById('description').addEventListener('input', function() {
                updateCharacterCount('description', 'descCount', 500);
            });
        });

        // Image preview
        document.getElementById('image').addEventListener('input', function() {
            const url = this.value.trim();
            if (url) {
                showImagePreview(url);
            } else {
                showImagePlaceholder();
            }
            
            if (this.classList.contains('is-invalid') && isValidUrl(url)) {
                this.classList.remove('is-invalid');
            }
        });

        function showImagePreview(url) {
            const placeholder = document.getElementById('imagePlaceholder');
            const wrapper = document.getElementById('imagePreviewWrapper');
            
            if (placeholder) {
                placeholder.style.display = 'none';
            }
            
            if (!wrapper) {
                const container = document.querySelector('.image-preview-container');
                container.innerHTML = `
                    <div id="imagePreviewWrapper">
                        <img src="${url}" 
                             alt="Preview" 
                             class="image-preview" 
                             id="imagePreview"
                             onerror="showImagePlaceholder()">
                        <button type="button" class="remove-image" onclick="removeImage()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
            } else {
                document.getElementById('imagePreview').src = url;
                wrapper.style.display = 'block';
            }
        }

        function showImagePlaceholder() {
            const wrapper = document.getElementById('imagePreviewWrapper');
            const placeholder = document.getElementById('imagePlaceholder');
            
            if (wrapper) {
                wrapper.style.display = 'none';
            }
            
            if (!placeholder) {
                const container = document.querySelector('.image-preview-container');
                container.innerHTML = `
                    <div class="image-placeholder" id="imagePlaceholder">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <div>Xem trước hình ảnh sẽ hiển thị ở đây</div>
                        <small class="text-muted">Nhập URL hình ảnh bên trên</small>
                    </div>
                `;
            } else {
                placeholder.style.display = 'flex';
            }
        }

        function removeImage() {
            document.getElementById('image').value = '';
            showImagePlaceholder();
        }

        function isValidUrl(string) {
            try {
                const url = new URL(string);
                return url.protocol === 'http:' || url.protocol === 'https:';
            } catch (_) {
                return false;
            }
        }

        // Form validation
        document.getElementById('categoryForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const form = this;
            const name = document.getElementById('name');
            const image = document.getElementById('image');
            
            let isValid = true;

            // Reset validation
            [name, image].forEach(field => {
                field.classList.remove('is-invalid', 'is-valid');
            });

            // Validate name
            if (!name.value.trim() || name.value.trim().length < 3) {
                name.classList.add('is-invalid');
                isValid = false;
            } else {
                name.classList.add('is-valid');
            }

            // Validate image URL (if provided)
            if (image.value.trim() && !isValidUrl(image.value.trim())) {
                image.classList.add('is-invalid');
                isValid = false;
            } else if (image.value.trim()) {
                image.classList.add('is-valid');
            }

            if (isValid) {
                // Add loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                
                // Submit form
                form.submit();
            }
        });

        // Reset form
        function resetForm() {
            if (confirm('Bạn có chắc muốn đặt lại form? Tất cả dữ liệu đã nhập sẽ bị xóa.')) {
                document.getElementById('categoryForm').reset();
                document.querySelectorAll('.form-control').forEach(field => {
                    field.classList.remove('is-invalid', 'is-valid');
                });
                updateCharacterCount('name', 'nameCount', 100);
                updateCharacterCount('description', 'descCount', 500);
                showImagePlaceholder();
            }
        }

        // Auto-save to localStorage (optional feature)
        function autoSave() {
            const formData = {
                name: document.getElementById('name').value,
                description: document.getElementById('description').value,
                image: document.getElementById('image').value
            };
            localStorage.setItem('categoryFormData', JSON.stringify(formData));
        }

        function loadAutoSave() {
            const saved = localStorage.getItem('categoryFormData');
            if (saved && <%= !isEdit %>) { // Only for new categories
                const data = JSON.parse(saved);
                if (confirm('Có dữ liệu form đã lưu trước đó. Bạn có muốn khôi phục?')) {
                    document.getElementById('name').value = data.name || '';
                    document.getElementById('description').value = data.description || '';
                    document.getElementById('image').value = data.image || '';
                    
                    updateCharacterCount('name', 'nameCount', 100);
                    updateCharacterCount('description', 'descCount', 500);
                    
                    if (data.image) {
                        showImagePreview(data.image);
                    }
                }
            }
        }

        // Auto-save every 30 seconds
        <% if (!isEdit) { %>
        setInterval(autoSave, 30000);
        window.addEventListener('load', loadAutoSave);
        <% } %>

        // Clear auto-save on successful submit
        window.addEventListener('beforeunload', function() {
            if (document.querySelector('.alert-success')) {
                localStorage.removeItem('categoryFormData');
            }
        });
    </script>
</body>
</html>