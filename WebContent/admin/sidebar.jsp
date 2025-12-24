<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }

    String active = (String) request.getAttribute("activePage");
    if (active == null) active = "dashboard";
%>

<div class="sidebar">
    <div class="logo">
        <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="Girlie Cafe Logo">
    </div>

    <a class="<%= "dashboard".equals(active) ? "active" : "" %>"
       href="<%= request.getContextPath() %>/admin/dashboard">Dashboard</a>

    <a class="<%= "products".equals(active) ? "active" : "" %>"
       href="<%= request.getContextPath() %>/admin/products">Products</a>

    <a class="<%= "orders".equals(active) ? "active" : "" %>"
       href="<%= request.getContextPath() %>/admin/orders">Orders</a>

    <a class="<%= "users".equals(active) ? "active" : "" %>"
       href="<%= request.getContextPath() %>/admin/users">Users</a>

    <a class="<%= "reports".equals(active) ? "active" : "" %>"
       href="<%= request.getContextPath() %>/admin/reports">Reports</a>
<a href="<%= request.getContextPath() %>/admin/logout" class="logout">
    Logout
</a>
</div>
