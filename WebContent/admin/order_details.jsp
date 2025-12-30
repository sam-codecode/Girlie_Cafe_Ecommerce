<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<%@ page import="model.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }

    Order order = (Order) request.getAttribute("order");
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>
<body>

<div class="admin-layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <h2>Order Details</h2>

        <div class="admin-card">

            <p><strong>Order ID:</strong> #<%= order.getOrderId() %></p>
            <p><strong>User ID:</strong> <%= order.getUserId() %></p>
            <p><strong>Date:</strong> <%= order.getOrderDate() %></p>
            <p>
                <strong>Status:</strong>
                <span class="status <%= order.getOrderStatus().toLowerCase() %>">
                    <%= order.getOrderStatus() %>
                </span>
            </p>

            <hr>

            <h3>Items Ordered</h3>

            <table>
                <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Qty</th>
                    <th>Price</th>
                    <th>Subtotal</th>
                </tr>
                </thead>

                <tbody>
                <% double total = 0;
                   for (OrderItem item : items) {
                       double subtotal = item.getQuantity() * item.getPrice();
                       total += subtotal;
                %>
                    <tr>
                        <td><%= item.getProductId() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>RM <%= String.format("%.2f", item.getPrice()) %></td>
                        <td>RM <%= String.format("%.2f", subtotal) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>

            <h3>Total: RM <%= String.format("%.2f", total) %></h3>

            <hr>

            <form method="post" action="<%= request.getContextPath() %>/admin/orders">
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                <label>Update Order Status</label>
                <select name="orderStatus">
                    <option value="Pending" <%= order.getOrderStatus().equals("Pending")?"selected":"" %>>Pending</option>
                    <option value="Shipped" <%= order.getOrderStatus().equals("Shipped")?"selected":"" %>>Shipped</option>
                    <option value="Delivered" <%= order.getOrderStatus().equals("Delivered")?"selected":"" %>>Delivered</option>
                </select>

                <div class="actions">
                    <button class="btn btn-edit" type="submit">Update Status</button>
                    <a class="btn-edit" href="<%= request.getContextPath() %>/admin/orders?action=list">Back</a>
                </div>
            </form>

        </div>

    </div>
</div>

</body>
</html>
