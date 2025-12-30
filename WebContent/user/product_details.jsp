<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title><%= product.getName() %> | Girlie’s Café</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;600&family=Lora:wght@400;600&family=Quicksand:wght@400;600&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;700&display=swap" rel="stylesheet">

  <!-- CSS -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/product.css" />
</head>

<body>

<!-- =========================
     NAVIGATION
========================= -->
<header class="top-hero">
  <nav class="top-navi">
    <a class="brand" href="<%= request.getContextPath() %>/user/index.jsp">
      <img src="<%= request.getContextPath() %>/assets/images/logo.png"
           class="brand-logo" alt="Girlie’s Café">
      <span class="brand-name">Girlie’s Café</span>
    </a>

    <div class="navi-links">
      <a class="navi-link" href="<%= request.getContextPath() %>/user/index.jsp">Home</a>
      <a class="navi-link active" href="<%= request.getContextPath() %>/products">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/orderHistory">
    My History
</a>

    </div>

    <a class="nav-cta pop-effect"
       href="<%= request.getContextPath() %>/user/cart.jsp">Checkout</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">Product Details</h1>
    <p class="main-subtitle">Tantalise Your Tastebuds</p>
  </div>
</header>

<!-- =========================
     PRODUCT DETAILS
========================= -->
<main class="menu-section">
  <div class="menu-wrap">

    <!-- Back to menu -->
    <a href="<%= request.getContextPath() %>/products"
       class="back-top-link">← Back to Menu</a>

    <!-- Product Card -->
    <div class="product-details">

      <!-- Product Image -->
      <img src="<%= request.getContextPath() %>/assets/images/menu/<%= product.getCategoryId() %>/<%= product.getImageName() %>"
           alt="<%= product.getName() %>"
           onerror="this.src='<%= request.getContextPath() %>/assets/images/placeholder.png'">

      <!-- Product Info -->
      <div class="product-details-info">

        <div class="product-row">
          <h3 class="product-name"><%= product.getName() %></h3>
          <span class="product-price">
            RM <%= String.format("%.2f", product.getPrice()) %>
          </span>
        </div>

        <p class="product-desc">
          <%= product.getDescription() %>
        </p>

        <!-- Add to Cart -->
        <form action="<%= request.getContextPath() %>/cart" method="post">

          <input type="hidden" name="action" value="add">
          <input type="hidden" name="productId"
                 value="<%= product.getProductId() %>">

          <!-- Quantity -->
          <div class="qty-area">
            <button type="button" id="minusBtn">−</button>

            <input type="number"
                   id="qtyInput"
                   name="quantity"
                   value="1"
                   min="1"
                   max="<%= product.getStock() %>">

            <button type="button" id="plusBtn">+</button>
          </div>

          <div class="action-row">
            <button type="submit"
                    class="btn-addcart"
                    <%= product.getStock() <= 0 ? "disabled" : "" %>>
              <%= product.getStock() <= 0 ? "OUT OF STOCK" : "ADD TO CART" %>
            </button>
          </div>

        </form>

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
        Sun & Public Holidays: Closed
      </p>
    </div>

    <div class="footer-col">
      <div class="footer-title">Customer Care</div>
      <a class="footer-link" href="#">FAQ</a>
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank">
        WhatsApp Us
      </a>
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

<!-- =========================
     JAVASCRIPT (Quantity only)
========================= -->
<script>
  const minusBtn = document.getElementById("minusBtn");
  const plusBtn  = document.getElementById("plusBtn");
  const qtyInput = document.getElementById("qtyInput");

  const MIN = 1;
  const MAX = parseInt(qtyInput.max || 1);

  function updateButtons() {
    const val = parseInt(qtyInput.value);
    minusBtn.disabled = val <= MIN;
    plusBtn.disabled  = val >= MAX;
  }

  minusBtn.addEventListener("click", () => {
    qtyInput.value = Math.max(MIN, qtyInput.value - 1);
    updateButtons();
  });

  plusBtn.addEventListener("click", () => {
    qtyInput.value = Math.min(MAX, parseInt(qtyInput.value) + 1);
    updateButtons();
  });

  qtyInput.addEventListener("input", updateButtons);
  updateButtons();
</script>

</body>
</html>
