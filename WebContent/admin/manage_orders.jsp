<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Order" %>
<%@ page import="model.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) orders = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Order Management</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>
<body>

<div class="admin-layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">
    

        <h2>Orders Management</h2>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <% if (orders.isEmpty()) { %>
                    <tr>
                        <td colspan="6">No orders found.</td>
                    </tr>
                <% } else {
                    for (Order o : orders) { %>
                    <tr>
                        <td>#<%= o.getOrderId() %></td>
                        <td><%= o.getUserId() %></td>
                        <td><%= o.getOrderDate() %></td>
                        <td>RM <%= String.format("%.2f", o.getTotalAmount()) %></td>
                        <td>
                            <span class="status <%= o.getOrderStatus().toLowerCase() %>">
                                <%= o.getOrderStatus() %>
                            </span>
                        </td>
                        <td>
                            <a class="btn-edit"
                               href="<%= request.getContextPath() %>/admin/orders?action=view&orderId=<%= o.getOrderId() %>">
                                View
                            </a>
                        </td>
                    </tr>
                <% } } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>
