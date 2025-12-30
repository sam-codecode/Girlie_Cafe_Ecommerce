<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

<%
    HttpSession sess = request.getSession(false);
    if (sess == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    User user = (User) sess.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    Map<Integer, Integer> cart = (Map<Integer, Integer>) sess.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
        return;
    }

    ProductDAO productDAO = new ProductDAO();
    double grandTotal = 0.0;

    // Address from user profile
    String userAddress = "";
    userAddress = (user.getAddress() == null) ? "" : user.getAddress().trim();

    // HTML-safe version for display
    String userAddressHtml = userAddress
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\r\n", "<br>")
            .replace("\n", "<br>");

    // JS-safe version (escape quotes/newlines)
    String userAddressJs = userAddress
        .replace("\\", "\\\\")
        .replace("\r", "")
        .replace("\n", "\\n")
        .replace("\"", "\\\"")
        .replace("`", "\\`")
        .replace("'", "\\'");

    // Show modal only when redirected back with success=1 (servlet should do this)
    boolean showSuccess = "1".equals(request.getParameter("success"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Checkout | Girlie’s Café</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/cart.css" />
</head>

<body>

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
      <a class="navi-link" href="<%= request.getContextPath() %>/user/orders.jsp">My History</a>
    </div>

    <a class="nav-cta pop-effect" href="<%= request.getContextPath() %>/user/cart.jsp">Back</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">Checkout</h1>
    <p class="main-subtitle">One last step before we serve the goodness</p>
  </div>
</header>

<main class="cart-section">
  <div class="cart-wrap">

    <div class="cart-card">
      <h2 class="cart-title">Order Summary</h2>

      <div class="table-wrap">
        <table class="cart-table">
          <thead>
            <tr>
              <th>Product</th>
              <th>Quantity</th>
              <th>Price (RM)</th>
              <th>Subtotal (RM)</th>
            </tr>
          </thead>

          <tbody>
          <%
              for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                  int productId = entry.getKey();
                  int qty = entry.getValue();

                  Product p = productDAO.getProductById(productId);
                  if (p == null) continue;

                  if (qty > p.getStock()) qty = p.getStock();

                  double sub = p.getPrice() * qty;
                  grandTotal += sub;
          %>
            <tr>
              <td class="checkout-item"><%= p.getName() %></td>
              <td><%= qty %></td>
              <td><%= String.format("%.2f", p.getPrice()) %></td>
              <td><%= String.format("%.2f", sub) %></td>
            </tr>
          <% } %>
          </tbody>

          <tfoot>
            <tr>
              <td colspan="3" class="total-label">Total :</td>
              <td class="total-value"><%= String.format("%.2f", grandTotal) %></td>
            </tr>
          </tfoot>
        </table>
      </div>

      <!-- Form submits normally to servlet -->
      <form id="checkoutForm" class="checkout-grid"
            action="<%= request.getContextPath() %>/checkout"
            method="post">

        <div class="hint-line" id="hintLine">
          Please choose <b>Order Type</b> and <b>Payment Method</b> to continue.
        </div>

        <section class="checkout-box">
          <h3 class="checkout-box-title">Payment Method</h3>
          <div class="option-row">
            <label class="radio-pill pop-effect">
              <input type="radio" name="paymentMethod" value="CASH"> Cash
            </label>
            <label class="radio-pill pop-effect">
              <input type="radio" name="paymentMethod" value="ONLINE_BANKING"> Online Banking
            </label>
          </div>
          <p class="small-note">You must choose a payment method.</p>
        </section>

        <section class="checkout-box">
          <h3 class="checkout-box-title">Order Type</h3>

          <div class="option-row">
            <label class="radio-pill pop-effect">
              <input type="radio" name="orderType" value="DINE_IN"> Dine-In
            </label>
            <label class="radio-pill pop-effect">
              <input type="radio" name="orderType" value="DELIVERY"> Delivery
            </label>
          </div>

          <div class="delivery-address" id="deliveryBox">
            <strong>Delivery Address</strong>
            <%= (userAddressHtml.isEmpty() ? "No address found in your profile." : userAddressHtml) %>
          </div>

          <!-- hidden values sent to servlet -->
          <input type="hidden" name="shippingAddress" id="shippingAddress" value="" />
          <input type="hidden" name="note" value="" />

          <p class="small-note" id="prepTimeText">Estimated Preparation Time: —</p>
        </section>

        <div class="checkout-bottom">
          <div class="total-badge">Total: RM <%= String.format("%.2f", grandTotal) %></div>
          <button type="submit" class="place-btn pop-effect" id="placeOrderBtn" disabled>Place Order</button>
        </div>

      </form>
    </div>

  </div>

  <!-- ORDER SUCCESS MODAL (kept) -->
  <div class="modal-overlay" id="orderModal">
    <div class="modal-box">
      <button class="modal-close" type="button" onclick="closeModal()">×</button>

      <div class="modal-icon">🍓🧁🍫✨</div>
      <h3 class="modal-title">Order Placed Successfully!</h3>
      <p class="modal-text">
        Your order is on the way to our kitchen 💗<br>
        Thanks for choosing Girlie’s Café — we’ll serve the goodness soon ✨
      </p>

      <button class="modal-btn" type="button" onclick="closeModal()">Okay</button>
    </div>
  </div>

</main>

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
  <div class="footer-bottom">© 2025 Girlie’s Café. All Rights Reserved.</div>
</footer>

<input type="hidden" id="orderSuccessFlag" value="<%= showSuccess ? 1 : 0 %>">

<script>
  const deliveryBox = document.getElementById("deliveryBox");
  const prepTimeText = document.getElementById("prepTimeText");
  const placeBtn = document.getElementById("placeOrderBtn");
  const hintLine = document.getElementById("hintLine");
  const form = document.getElementById("checkoutForm");

  const orderModal = document.getElementById("orderModal");
  const shippingAddress = document.getElementById("shippingAddress");

  // JS-safe address from JSP
  const userAddress = "<%= userAddressJs %>";

  function getSelected(name){
    const el = document.querySelector(`input[name="${name}"]:checked`);
    return el ? el.value : "";
  }

  function updateUI(){
    const orderType = getSelected("orderType");
    const payment = getSelected("paymentMethod");

    if (orderType === "DELIVERY"){
      deliveryBox.style.display = "block";
      prepTimeText.textContent = "Estimated Preparation Time: 30 – 40 minutes";
      shippingAddress.value = userAddress; // ✅ send address to servlet
    } else if (orderType === "DINE_IN"){
      deliveryBox.style.display = "none";
      prepTimeText.textContent = "Estimated Preparation Time: 15 – 20 minutes";
      shippingAddress.value = ""; // ✅ no address for dine-in
    } else {
      deliveryBox.style.display = "none";
      prepTimeText.textContent = "Estimated Preparation Time: —";
      shippingAddress.value = "";
    }

    const canPlace = (orderType !== "" && payment !== "");
    placeBtn.disabled = !canPlace;

    hintLine.innerHTML = canPlace
      ? "<b>All set!</b> You can place your order now."
      : "Please choose <b>Order Type</b> and <b>Payment Method</b> to continue.";
  }

  function showModal(){
    if (!orderModal) return;
    orderModal.classList.add("show");
  }

  function closeModal(){
    if (!orderModal) return;
    orderModal.classList.remove("show");
  }

  window.closeModal = closeModal;

  if (orderModal){
    orderModal.addEventListener("click", (e) => {
      if (e.target === orderModal) closeModal();
    });
  }

  document.querySelectorAll('input[name="orderType"]').forEach(r =>
    r.addEventListener("change", updateUI)
  );

  document.querySelectorAll('input[name="paymentMethod"]').forEach(r =>
    r.addEventListener("change", updateUI)
  );

  // ✅ IMPORTANT: NO preventDefault here — form submits to servlet normally

  updateUI();

  const successFlag = document.getElementById("orderSuccessFlag");

  if (successFlag && successFlag.value === "1") {
    showModal();
  }

</script>

</body>
</html>