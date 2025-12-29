<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Order" %>

<%
    // Session checks (same pattern as your servlets)
    HttpSession sess = request.getSession(false);
    if (sess == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Object userObj = sess.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Orders list from OrderHistoryServlet
    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) orders = new ArrayList<>();

    // Helper: safe string
    String safe(String s){
        return (s == null) ? "" : s;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My History | Girlie’s Café</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/history_about.css" />
</head>

<body>

<!-- =========================
     NAVIGATION + HERO
========================= -->
<header class="top-hero">
  <nav class="top-navi">
    <a class="brand" href="<%= request.getContextPath() %>/user/index.jsp">
      <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="Girlie’s Café" class="brand-logo">
      <span class="brand-name">Girlie’s Café</span>
    </a>

    <div class="navi-links">
      <a class="navi-link" href="<%= request.getContextPath() %>/user/index.jsp">Home</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/products.jsp">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link active" href="<%= request.getContextPath() %>/orders.jsp">My History</a>
    </div>

    <a class="nav-cta pop-effect" href="<%= request.getContextPath() %>/user/products.jsp">Order More</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">My Order History</h1>
    <p class="main-subtitle">A timeline of your café moments ☕</p>
  </div>
</header>

<!-- =========================
     CONTENT
========================= -->
<main class="history-section">
  <div class="history-wrap">

    <div class="history-card">
      <div class="orders-wrap">

        <% if (orders.isEmpty()) { %>

          <!-- EMPTY STATE -->
          <div class="empty-state">
            <p>No orders yet 😭</p>
            <a class="btn-primary pop-effect" href="<%= request.getContextPath() %>/user/products.jsp">Browse Menu</a>
          </div>

        <% } else { %>

          <% for (Order o : orders) {

              // ======= CHANGE THESE GETTERS if your model uses different names =======
              // Common possibilities:
              // int orderId = o.getOrderId();
              // Date orderDate = o.getOrderDate();
              // double total = o.getTotalAmount();
              // String status = o.getStatus();
              // String payment = o.getPaymentStatus();

              int orderId = 0;
              String dateText = "";
              double total = 0.0;
              String status = "";
              String payment = "";

              try { orderId = o.getOrderId(); } catch(Exception e){ /* change getter if needed */ }
              try {
                  // If your model returns java.util.Date:
                  // dateText = new java.text.SimpleDateFormat("dd MMM yyyy · HH:mm").format(o.getOrderDate());
                  Object dt = null;
                  try { dt = o.getOrderDate(); } catch(Exception ex){ dt = null; }

                  if (dt instanceof java.util.Date) {
                      dateText = new java.text.SimpleDateFormat("dd MMM yyyy · HH:mm").format((java.util.Date) dt);
                  } else {
                      // If your model returns String:
                      try { dateText = String.valueOf(dt); } catch(Exception ex){ dateText = ""; }
                  }
              } catch(Exception e){ dateText = ""; }

              try { total = o.getTotalAmount(); } catch(Exception e){ /* change getter if needed */ }
              try { status = o.getStatus(); } catch(Exception e){ status = ""; }
              try { payment = o.getPaymentStatus(); } catch(Exception e){ payment = ""; }

              String statusUpper = safe(status).trim().toUpperCase();
              String payUpper = safe(payment).trim().toUpperCase();

              // map to your CSS badge classes
              String statusClass = "pending";
              if ("COMPLETED".equals(statusUpper) || "COMPLETE".equals(statusUpper)) statusClass = "completed";
              else if ("CANCELLED".equals(statusUpper) || "CANCELED".equals(statusUpper)) statusClass = "cancelled";

              String payClass = "paid";
              if ("UNPAID".equals(payUpper) || "PENDING".equals(payUpper)) payClass = "unpaid";
          %>

            <div class="order-card pop-effect">
              <div class="order-row">
                <div class="order-id">Order #<%= orderId %></div>
                <div class="order-date"><%= safe(dateText) %></div>
                <div class="order-total">RM <%= String.format("%.2f", total) %></div>
              </div>

              <div class="order-meta">
                <div>
                  Status:
                  <span class="status <%= statusClass %>"><%= statusUpper.isEmpty() ? "—" : statusUpper %></span>
                </div>
                <div>
                  Payment:
                  <span class="payment <%= payClass %>"><%= payUpper.isEmpty() ? "—" : payUpper %></span>
                </div>
              </div>
            </div>

          <% } %>

        <% } %>

      </div>
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
        Sun &amp; Public Holidays: Closed
      </p>
    </div>

    <div class="footer-col">
      <div class="footer-title">Customer Care</div>
      <a class="footer-link" href="#">FAQ</a>
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank" rel="noopener">
        Contact Us (WhatsApp)
      </a>
    </div>

    <div class="footer-col">
      <div class="footer-title">Connect</div>
      <a class="footer-link" href="https://instagram.com/girliescafe" target="_blank" rel="noopener">Instagram</a>
      <a class="footer-link" href="https://facebook.com/girliescafe" target="_blank" rel="noopener">Facebook</a>
      <a class="footer-link" href="tel:+60111111111">+60-11-1111111</a>
    </div>

  </div>

  <div class="footer-bottom">
    © 2025 Girlie’s Café. All Rights Reserved.
  </div>
</footer>

</body>
</html>
