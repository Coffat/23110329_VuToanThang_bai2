<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Redirect to home servlet which will handle authentication
    response.sendRedirect(request.getContextPath() + "/");
%>