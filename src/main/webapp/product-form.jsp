<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm</title>
    <jsp:include page="components/header.jsp" />
</head>
<body>
<div class="container mt-4">
    <h3 class="mb-3"><%= request.getParameter("id") != null ? "Cập nhật sản phẩm" : "Thêm sản phẩm" %></h3>
    <%
        com.login.logindemo.model.Product p = (com.login.logindemo.model.Product) request.getAttribute("product");
        String name = p != null ? p.getName() : "";
        String description = p != null ? p.getDescription() : "";
        String price = p != null ? String.valueOf(p.getPrice()) : "";
        boolean status = p != null ? p.isStatus() : true;
    %>

    <form action="<%= request.getContextPath() %>/product" method="post" enctype="multipart/form-data" class="row g-3">
        <input type="hidden" name="action" value="<%= p!=null?"update":"create" %>">
        <% if (p != null) { %>
        <input type="hidden" name="id" value="<%= p.getId() %>">
        <% } %>

        <div class="col-md-6">
            <label class="form-label fw-bold">Tên sản phẩm</label>
            <input type="text" class="form-control" name="name" value="<%= name %>" required>
        </div>
        <div class="col-md-6">
            <label class="form-label fw-bold">Giá</label>
            <input type="number" min="0" step="0.01" class="form-control" name="price" value="<%= price %>" required>
        </div>
        <div class="col-md-12">
            <label class="form-label fw-bold">Mô tả</label>
            <textarea class="form-control" rows="4" name="description"><%= description %></textarea>
        </div>
        <div class="col-md-8">
            <label class="form-label fw-bold">Ảnh</label>
            <input type="file" name="image" accept="image/*" class="form-control">
        </div>
        <div class="col-md-4">
            <label class="form-label fw-bold">Trạng thái</label>
            <select class="form-select" name="status">
                <option value="1" <%= status?"selected":"" %>>Hiển thị</option>
                <option value="0" <%= !status?"selected":"" %>>Ẩn</option>
            </select>
        </div>
        <div class="col-12">
            <button class="btn btn-primary">Lưu</button>
            <a href="<%= request.getContextPath() %>/product" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>

<jsp:include page="components/footer.jsp" />
</body>
</html>


