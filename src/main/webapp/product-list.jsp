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
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Quản lý sản phẩm</h3>
        <a href="<%= request.getContextPath() %>/product?action=add" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> Thêm sản phẩm
        </a>
    </div>

    <table class="table table-hover table-bordered bg-white shadow-sm">
        <thead class="table-light">
        <tr>
            <th>ID</th><th>Tên</th><th>Giá</th><th>Trạng thái</th><th>Ảnh</th><th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            java.util.List<com.login.logindemo.model.Product> products = (java.util.List<com.login.logindemo.model.Product>) request.getAttribute("products");
            if (products != null) {
                for (com.login.logindemo.model.Product p : products) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td><%= String.format("%,.0f", p.getPrice()) %></td>
            <td><span class="badge <%= p.isStatus()?"bg-success":"bg-secondary" %>"><%= p.isStatus()?"Hiển thị":"Ẩn" %></span></td>
            <td>
                <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="<%= request.getContextPath() + "/" + p.getImage() %>" alt="img" style="height:40px;object-fit:cover;">
                <% } %>
            </td>
            <td class="text-nowrap">
                <a href="<%= request.getContextPath() %>/product?action=edit&id=<%= p.getId() %>" class="btn btn-sm btn-outline-primary">Sửa</a>
                <form action="<%= request.getContextPath() %>/product" method="post" class="d-inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa sản phẩm này?')">Xóa</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<jsp:include page="components/footer.jsp" />
</body>
</html>


