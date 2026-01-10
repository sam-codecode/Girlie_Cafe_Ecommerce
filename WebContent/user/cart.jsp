<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

    <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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
                            
                            
                            
                            
                            <button class="qty-btn" onclick="changeQty(${index}, -1)">−</button>

                            <input class ="qty-input" type="number"
                                   name="quantity"
                                   value="<%= qty %>"
                                   min="1"
                                   max="<%= p.getStock() %>"
                                   onchange="this.form.submit()">
                            <button class="qty-btn" onclick="changeQty(${index}, 1)">+</button>
                            
                            
                            
                            
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
                <a class="btn-secondary pop-effect" href="<%= request.getContextPath() %>/products">+ Add More Items</a>
                <a class="btn-primary pop-effect" href="<%= request.getContextPath() %>/user/checkout.jsp">
                    Proceed to Checkout
                </a>
            </div>

            <% } %>

        </div>
    </div>
</main>

<!-- =========================
     FOOTER
========================== -->
<footer class="footer">
  <div class="wrap footer-grid">

    <div class="footer-col">
      <div class="footer-brand">Girlie’s Café</div>
      <p class="footer-text">
        <strong>Operating Hours</strong><br>
        Monday – Saturday: 8:00 AM – 7:00 PM<br>
        Sunday &amp; Public Holidays: Closed
      </p>
    </div>

    <div class="footer-col">
      <div class="footer-title">Customer Care</div>
      <a class="footer-link" href="#">FAQ</a>
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank" rel="noopener">WhatsApp Us</a>
    </div>

    <div class="footer-col">
      <div class="footer-title">Connect</div>

      <a class="footer-link footer-social"
         href="https://instagram.com/girliescafe"
         target="_blank" rel="noopener">
        <i class="fab fa-instagram"></i> Instagram
      </a>

      <a class="footer-link footer-social"
         href="https://facebook.com/girliescafe"
         target="_blank" rel="noopener">
        <i class="fab fa-facebook-f"></i> Facebook
      </a>

      <a class="footer-link footer-contact" href="tel:+60-11-1111111">
        <i class="fas fa-phone-alt"></i> +60-11-1111111
      </a>
    </div>

  </div>

  <div class="footer-bottom">
    © 2025 Girlie’s Café. All Rights Reserved.
  </div>
</footer>

</body>
</html>
