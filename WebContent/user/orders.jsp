<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>

<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");

    // IMPORTANT FIX
    if (orders == null) {
        response.sendRedirect(request.getContextPath() + "/orderHistory");
        return;
    }
%>



<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My Orders | Girlie’s Café</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/history.css">
</head>

<body>

<!-- =========================
     NAVIGATION
========================= -->
<header class="top-hero">
  <nav class="top-navi">
    <a class="brand" href="<%= request.getContextPath() %>/user/index.jsp">
      <img src="<%= request.getContextPath() %>/assets/images/logo.png" class="brand-logo">
      <span class="brand-name">Girlie’s Café</span>
    </a>

    <div class="navi-links">
      <a class="navi-link" href="<%= request.getContextPath() %>/user/index.jsp">Home</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/products">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link active" href="<%= request.getContextPath() %>/orderHistory">My History</a>
    </div>

    <a class="nav-cta" href="<%= request.getContextPath() %>/products">Order More</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">My Order History</h1>
    <p class="main-subtitle">Your café journey ☕</p>
  </div>
</header>

<!-- =========================
     ORDERS CONTENT
========================= -->
<main class="history-section">
  <div class="history-wrap">

    <div class="history-card">

      <% if (orders == null || orders.isEmpty()) { %>

        <!-- EMPTY STATE -->
        <div class="empty-state">
          <p>No orders yet 😢</p>
          <a class="btn-primary" href="<%= request.getContextPath() %>/products">
            Browse Menu
          </a>
        </div>

      <% } else { %>

        <div class="orders-wrap">

          <% for (Order o : orders) { %>

            <div class="order-card">

              <div class="order-row">
                <div class="order-id">Order #<%= o.getOrderId() %></div>
                <div class="order-date">
                  <%= o.getOrderDate() != null
                        ? new java.text.SimpleDateFormat("dd MMM yyyy HH:mm").format(o.getOrderDate())
                        : "-" %>
                </div>
                <div class="order-total">
                  RM <%= String.format("%.2f", o.getTotalAmount()) %>
                </div>
              </div>

              <div class="order-meta">
                <div>
                  Status:
                  <span class="status <%= o.getOrderStatus().equalsIgnoreCase("COMPLETED") ? "completed" : "pending" %>">
                    <%= o.getOrderStatus() %>
                  </span>
                </div>

                <div>
                  Payment:
                  <span class="payment <%= o.getPaymentStatus().equalsIgnoreCase("PAID") ? "paid" : "unpaid" %>">
                    <%= o.getPaymentStatus() %>
                  </span>
                </div>
              </div>

            </div>

          <% } %>

        </div>

      <% } %>

    </div>

  </div>
</main>

<!-- =========================
     FOOTER
========================= -->
<footer class="footer">
  <div class="wrap footer-grid">

    <div class="footer-col">
      <div class="footer-brand">Girlie’s Café</div>
      <p class="footer-text">
        <strong>Operating Hours</strong><br>
        Mon – Sat: 8:00 AM – 7:00 PM<br>
        Sunday & Public Holidays: Closed
      </p>
    </div>

    <div class="footer-col">
      <div class="footer-title">Customer Care</div>
      <a class="footer-link" href="#">FAQ</a>
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank">WhatsApp Us</a>
    </div>

    <div class="footer-col">
      <div class="footer-title">Connect</div>
      <a class="footer-link" href="#">Instagram</a>
      <a class="footer-link" href="#">Facebook</a>
    </div>

  </div>

  <div class="footer-bottom">
    © 2025 Girlie’s Café. All Rights Reserved.
  </div>
</footer>

</body>
</html>
