<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Footer -->
<footer class="mt-5 py-4">
    <div class="container">
        <div class="card card-custom">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-home me-2 text-primary"></i>
                            <strong>Hệ Thống Quản Lý</strong>
                        </div>
                        <small class="text-muted">
                            Phiên bản 1.0.0 - Được phát triển với ❤️
                        </small>
                    </div>
                    <div class="col-md-6 text-md-end mt-3 mt-md-0">
                        <div class="d-flex justify-content-md-end justify-content-center gap-3">
                            <a href="<%= request.getContextPath() %>/" class="text-decoration-none">
                                <i class="fas fa-home me-1"></i>Trang Chủ
                            </a>
                            <a href="<%= request.getContextPath() %>/category" class="text-decoration-none">
                                <i class="fas fa-folder me-1"></i>Danh Mục
                            </a>
                            <a href="<%= request.getContextPath() %>/profile.jsp" class="text-decoration-none">
                                <i class="fas fa-user me-1"></i>Hồ Sơ
                            </a>
                        </div>
                        <small class="text-muted d-block mt-2">
                            © <%= java.time.Year.now().getValue() %> Tất cả quyền được bảo lưu
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script>
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
        alerts.forEach(function(alert) {
            setTimeout(function() {
                if (alert && alert.parentNode) {
                    alert.style.transition = 'opacity 0.5s ease';
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        if (alert && alert.parentNode) {
                            alert.remove();
                        }
                    }, 500);
                }
            }, 5000);
        });
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add loading state to buttons when forms are submitted
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const submitBtn = form.querySelector('button[type="submit"], input[type="submit"]');
            if (submitBtn) {
                submitBtn.disabled = true;
                const originalText = submitBtn.textContent || submitBtn.value;
                if (submitBtn.tagName === 'BUTTON') {
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                } else {
                    submitBtn.value = 'Đang xử lý...';
                }
                
                // Re-enable after 10 seconds as fallback
                setTimeout(() => {
                    submitBtn.disabled = false;
                    if (submitBtn.tagName === 'BUTTON') {
                        submitBtn.textContent = originalText;
                    } else {
                        submitBtn.value = originalText;
                    }
                }, 10000);
            }
        });
    });

    // Confirm dialogs for dangerous actions
    document.querySelectorAll('a[onclick*="confirm"], button[onclick*="confirm"]').forEach(element => {
        element.addEventListener('click', function(e) {
            if (!this.onclick || !this.onclick()) {
                e.preventDefault();
            }
        });
    });

    // Initialize tooltips if Bootstrap tooltips are used
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Form validation helper
    function validateForm(form) {
        let isValid = true;
        const requiredFields = form.querySelectorAll('[required]');
        
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                field.classList.add('is-invalid');
                isValid = false;
            } else {
                field.classList.remove('is-invalid');
            }
        });
        
        return isValid;
    }

    // Add real-time validation
    document.querySelectorAll('input[required], textarea[required], select[required]').forEach(field => {
        field.addEventListener('blur', function() {
            if (this.value.trim()) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        });

        field.addEventListener('input', function() {
            if (this.classList.contains('is-invalid') && this.value.trim()) {
                this.classList.remove('is-invalid');
            }
        });
    });
</script>
