<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>

<%
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) cart = new HashMap<>();

    ProductDAO productDAO = new ProductDAO();
    double grandTotal = 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cart | Girlie’s Café</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

  <!-- Cart CSS (put cart.css inside WebContent/assets/css/cart.css) -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/cart.css" />
</head>

<body>

<!-- =========================
     NAVIGATION (same as HTML)
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
      <a class="navi-link active" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/orders.jsp">My History</a>
    </div>

    <a class="nav-cta pop-effect" href="<%= request.getContextPath() %>/user/checkout.jsp">Checkout</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">My Cart</h1>
    <p class="main-subtitle">Review your selection before checkout</p>
  </div>
</header>

<!-- =========================
     CART CONTENT (HTML layout)
========================= -->
<main class="cart-section">
  <div class="cart-wrap">

    <div class="cart-card">
      <h2 class="cart-title">Your Café Picks</h2>

      <% if (cart.isEmpty()) { %>

        <div class="empty-cart">
          <p>Your cart is empty.</p>
          <a class="btn-secondary pop-effect" href="<%= request.getContextPath() %>/user/products.jsp">Back to Menu</a>
        </div>

      <% } else { %>

      <div class="table-wrap">
        <table class="cart-table">
          <thead>
            <tr>
              <th>Product</th>
              <th>Price (RM)</th>
              <th>Quantity</th>
              <th>Subtotal (RM)</th>
              <th>Action</th>
            </tr>
          </thead>

          <tbody id="cartBody">
          <%
              // Render rows from SESSION cart + DB
              for (Map.Entry<Integer, Integer> item : cart.entrySet()) {
                  int productId = item.getKey();
                  int qty = item.getValue();

                  Product p = productDAO.getProductById(productId);

                  String name = (p != null) ? p.getName() : "Product #" + productId;
                  double price = (p != null) ? p.getPrice() : 0.0;
                  int stock = (p != null) ? p.getStock() : 1;

                  if (qty > stock) qty = stock;

                  double subtotal = price * qty;
                  grandTotal += subtotal;
          %>

            <tr>
              <td class="pname"><%= name %></td>
              <td><%= String.format("%.2f", price) %></td>

              <td>
                <!-- Styled qty like HTML but uses your JSP form logic -->
                <form action="<%= request.getContextPath() %>/cart" method="post" class="qtyForm">
                  <input type="hidden" name="action" value="update">
                  <input type="hidden" name="productId" value="<%= productId %>">
                  <input type="hidden" class="stock" value="<%= stock %>">

                  <div class="qty-cell">
                    <button type="button" class="qty-btn minusBtn">−</button>
                    <input class="qty-input qtyInput"
                           type="number"
                           name="quantity"
                           value="<%= qty %>"
                           min="1"
                           max="<%= stock %>">
                    <button type="button" class="qty-btn plusBtn">+</button>
                  </div>

                  <div class="stock-note">Max: <%= stock %></div>
                </form>

                <a class="add-more-link" href="<%= request.getContextPath() %>/user/products.jsp">+ Add more items</a>
              </td>

              <td class="subtotal"><%= String.format("%.2f", subtotal) %></td>

              <td>
                <form action="<%= request.getContextPath() %>/cart" method="post">
                  <input type="hidden" name="action" value="remove">
                  <input type="hidden" name="productId" value="<%= productId %>">
                  <button type="submit" class="remove-btn">Remove</button>
                </form>
              </td>
            </tr>

          <% } %>
          </tbody>

          <tfoot>
            <tr>
              <td colspan="3" class="total-label">Total :</td>
              <td class="total-value" id="grandTotal"><%= String.format("%.2f", grandTotal) %></td>
              <td></td>
            </tr>
          </tfoot>
        </table>
      </div>

      <div class="cart-actions">
        <a class="btn-secondary pop-effect" href="<%= request.getContextPath() %>/user/products.jsp">+ Add More Items</a>
        <a class="btn-primary pop-effect" href="<%= request.getContextPath() %>/user/checkout.jsp">Review Payment</a>
      </div>

      <% } %>
    </div>

  </div>
</main>

<!-- =========================
     FOOTER (same as HTML)
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
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank" rel="noopener">Contact Us (WhatsApp)</a>
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

<!-- =========================
     Qty Script (keep your logic but match HTML buttons)
========================= -->
<script>
  document.querySelectorAll(".qtyForm").forEach(form => {
    const minusBtn = form.querySelector(".minusBtn");
    const plusBtn  = form.querySelector(".plusBtn");
    const qtyInput = form.querySelector(".qtyInput");
    const stock    = parseInt(form.querySelector(".stock").value);

    function clampQty(v){
      v = parseInt(v || 1, 10);
      if (v < 1) v = 1;
      if (v > stock) v = stock;
      return v;
    }

    function updateButtons(){
      const v = clampQty(qtyInput.value);
      qtyInput.value = v;
      minusBtn.disabled = (v <= 1);
      plusBtn.disabled  = (v >= stock);
    }

    minusBtn.addEventListener("click", () => {
      qtyInput.value = clampQty(qtyInput.value - 1);
      updateButtons();
      form.submit();
    });

    plusBtn.addEventListener("click", () => {
      qtyInput.value = clampQty(qtyInput.value + 1);
      updateButtons();
      form.submit();
    });

    qtyInput.addEventListener("change", () => {
      qtyInput.value = clampQty(qtyInput.value);
      updateButtons();
      form.submit();
    });

    updateButtons();
  });
</script>

</body>
</html>
