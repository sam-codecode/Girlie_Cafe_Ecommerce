<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }

    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    Integer totalOrders   = (Integer) request.getAttribute("totalOrders");
    Integer totalUsers    = (Integer) request.getAttribute("totalUsers");
    Double revenue        = (Double) request.getAttribute("revenue");

    if (totalProducts == null) totalProducts = 0;
    if (totalOrders == null) totalOrders = 0;
    if (totalUsers == null) totalUsers = 0;
    if (revenue == null) revenue = 0.0;

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> recentOrders =
        (List<Map<String, Object>>) request.getAttribute("recentOrders");

    if (recentOrders == null) recentOrders = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Girlie's Café</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>
<body class="admin-page">


<div class="admin-layout">

    <%
        request.setAttribute("activePage", "dashboard");
    %>
    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="header">
            <h2>Admin Dashboard</h2>
            <div class="admin-info">
                <span>👤</span>
                <span><%= admin.getName() %></span>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats">
            <div class="stat-card">
                <h4>Total Products</h4>
                <p><%= totalProducts %></p>
            </div>

            <div class="stat-card">
                <h4>Total Orders</h4>
                <p><%= totalOrders %></p>
            </div>

            <div class="stat-card">
                <h4>Registered Users</h4>
                <p><%= totalUsers %></p>
            </div>

            <div class="stat-card">
                <h4>Revenue</h4>
                <p>RM <%= String.format("%.2f", revenue) %></p>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="table-container">
            <h3>Recent Orders</h3>

            <table>
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (recentOrders.isEmpty()) {
                %>
                    <tr>
                        <td colspan="6">No recent orders found.</td>
                    </tr>
                <%
                    } else {
                        for (Map<String, Object> row : recentOrders) {
                            int orderId = (int) row.get("orderId");
                            String customer = String.valueOf(row.get("customer"));
                            String date = String.valueOf(row.get("date"));
                            double total = (double) row.get("total");
                            String status = String.valueOf(row.get("status"));

                            String statusClass = "pending";
                            if ("Shipped".equalsIgnoreCase(status)) statusClass = "shipped";
                            if ("Delivered".equalsIgnoreCase(status)) statusClass = "shipped"; // reuse green
                %>
                    <tr>
                        <td>#<%= orderId %></td>
                        <td><%= customer %></td>
                        <td><%= date %></td>
                        <td>RM <%= String.format("%.2f", total) %></td>
                        <td><span class="status <%= statusClass %>"><%= status %></span></td>
                        <td>
                            <a class="btn-edit"
                               href="<%= request.getContextPath() %>/admin/orders?action=view&orderId=<%= orderId %>">
                                View
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>
