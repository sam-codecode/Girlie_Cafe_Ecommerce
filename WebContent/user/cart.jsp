<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

<%
    // ---------- AUTH CHECK ----------
    HttpSession sess = request.getSession(false);
    if (sess == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    User user = (User) sess.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    int userId = user.getUserId();

    // ---------- USER-SPECIFIC CART ----------
    @SuppressWarnings("unchecked")
    Map<Integer, Integer> cart =
            (Map<Integer, Integer>) sess.getAttribute("cart_" + userId);

    if (cart == null) {
        cart = new HashMap<>();
        sess.setAttribute("cart_" + userId, cart);
    }

    ProductDAO productDAO = new ProductDAO();
    double grandTotal = 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart | Girlie’s Café</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/cart.css">
</head>

<body>

<header class="top-hero">
    <nav class="top-navi">
        <a class="brand" href="<%= request.getContextPath() %>/user/index.jsp">
            <img src="<%= request.getContextPath() %>/assets/images/logo.png" class="brand-logo">
            <span class="brand-name">Girlie’s Café</span>
        </a>

        <div class="navi-links">
            <a class="navi-link" href="<%= request.getContextPath() %>/user/index.jsp">Home</a>
            <a class="navi-link" href="<%= request.getContextPath() %>/products">Menu</a>
            <a class="navi-link active" href="#">Cart</a>
            <a class="navi-link" href="<%= request.getContextPath() %>/orderHistory">
    My History
</a>

        </div>

        <a class="nav-cta" href="<%= request.getContextPath() %>/user/checkout.jsp">Checkout</a>
    </nav>

    <div class="main-text">
        <h1 class="main-title">My Cart</h1>
        <p class="main-subtitle">Review your items before checkout</p>
    </div>
</header>

<main class="cart-section">
    <div class="cart-wrap">

        <div class="cart-card">
            <h2 class="cart-title">Your Items</h2>

            <% if (cart.isEmpty()) { %>

                <p>Your cart is empty.</p>
                <a class="btn-primary" href="<%= request.getContextPath() %>/products">
                    Browse Menu
                </a>

            <% } else { %>

            <table class="cart-table">
                <thead>
                <tr>
                    <th>Product</th>
                    <th>Price (RM)</th>
                    <th>Qty</th>
                    <th>Subtotal (RM)</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                    for (Map.Entry<Integer, Integer> item : cart.entrySet()) {
                        int productId = item.getKey();
                        int qty = item.getValue();

                        Product p = productDAO.getProductById(productId);
                        if (p == null) continue;

                        if (qty > p.getStock()) qty = p.getStock();

                        double subtotal = p.getPrice() * qty;
                        grandTotal += subtotal;
                %>
                <tr>
                    <td><%= p.getName() %></td>
                    <td><%= String.format("%.2f", p.getPrice()) %></td>

                    <td>
                        <form action="<%= request.getContextPath() %>/cart" method="post">
                            <input type="hidden" name="productId" value="<%= productId %>">
                            <input type="hidden" name="action" value="update">

                            <input type="number"
                                   name="quantity"
                                   value="<%= qty %>"
                                   min="1"
                                   max="<%= p.getStock() %>"
                                   onchange="this.form.submit()">
                        </form>
                    </td>

                    <td><%= String.format("%.2f", subtotal) %></td>

                    <td>
                        <form action="<%= request.getContextPath() %>/cart" method="post">
                            <input type="hidden" name="productId" value="<%= productId %>">
                            <input type="hidden" name="action" value="remove">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>

                <tfoot>
                <tr>
                    <td colspan="3" class="total-label">Total</td>
                    <td class="total-value"><%= String.format("%.2f", grandTotal) %></td>
                    <td></td>
                </tr>
                </tfoot>
            </table>

            <div class="cart-actions">
                <a class="btn-secondary" href="<%= request.getContextPath() %>/products">Add More</a>
                <a class="btn-primary" href="<%= request.getContextPath() %>/user/checkout.jsp">
                    Proceed to Checkout
                </a>
            </div>

            <% } %>

        </div>
    </div>
</main>

<footer class="footer">
    <div class="footer-bottom">
        © 2025 Girlie’s Café. All Rights Reserved.
    </div>
</footer>

</body>
</html>
