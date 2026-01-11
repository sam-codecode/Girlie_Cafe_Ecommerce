<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

<%
    HttpSession sess = request.getSession(false);
    if (sess == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    User user = (User) sess.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // ✅ IMPORTANT: check success FIRST (so we don't redirect away before showing modal)
    boolean showSuccess = "1".equals(request.getParameter("success"));

    int userId = user.getUserId();

    @SuppressWarnings("unchecked")
    Map<Integer, Integer> cart =
        (Map<Integer, Integer>) sess.getAttribute("cart_" + userId);

    // ✅ Only redirect to cart when NOT showing success modal
    if ((cart == null || cart.isEmpty()) && !showSuccess) {
        response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
        return;
    }

    ProductDAO productDAO = new ProductDAO();
    double grandTotal = 0.0;

    // Address from user profile
    String userAddress = (user.getAddress() == null) ? "" : user.getAddress().trim();

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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
      <a class="navi-link" href="<%= request.getContextPath() %>/products">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/orderHistory">My History</a>
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
              // ✅ Only render items if cart exists (success page will have empty cart)
              if (cart != null && !cart.isEmpty()) {
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
          <%
                  }
              }
          %>
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
              <input type="radio" name="paymentMethod" value="CASH" required>
              Cash
            </label>

            <label class="radio-pill pop-effect">
              <input type="radio" name="paymentMethod" value="ONLINE_BANKING" required>
              Online Banking
            </label>
          </div>
          <p class="small-note">You must choose a payment method.</p>
        </section>

        <section class="checkout-box">
          <h3 class="checkout-box-title">Order Type</h3>

          <div class="option-row">
            <label class="radio-pill pop-effect">
              <input type="radio" name="orderType" value="DINE_IN" required>
              Dine-In
            </label>

            <label class="radio-pill pop-effect">
              <input type="radio" name="orderType" value="DELIVERY" required>
              Delivery
            </label>
          </div>

          <div class="delivery-address" id="deliveryBox">
            <strong>Delivery Address</strong>
            <%= (userAddressHtml.isEmpty() ? "No address found in your profile." : userAddressHtml) %>
          </div>

          <!-- hidden values sent to servlet -->
          <input type="hidden" name="note" value="" />

          <p class="small-note" id="prepTimeText">Estimated Preparation Time: --</p>

          <div id="qrBox" style="display:none; margin-top:15px; text-align:center;">
            <p><strong>Scan to Pay</strong></p>
            <img id="qrImg"
                 src="<%= request.getContextPath() %>/assets/images/qr/online_banking_qr.png"
                 alt="Online Banking QR">
          </div>
        </section>

        <div class="checkout-bottom">
          <div class="total-badge">Total: RM <%= String.format("%.2f", grandTotal) %></div>
          <button type="submit" id="placeOrderBtn" class="place-btn pop-effect">
            Place Order
          </button>
        </div>

      </form>
    </div>

  </div>

  <!-- ORDER SUCCESS MODAL -->
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

      <a class="footer-link footer-contact" href="tel:+60111111111">
        <i class="fas fa-phone-alt"></i> +60-11-1111111
      </a>
    </div>

  </div>

  <div class="footer-bottom">
    © 2025 Girlie’s Café. All Rights Reserved.
  </div>
</footer>

<input type="hidden" id="orderSuccessFlag" value="<%= showSuccess ? 1 : 0 %>">

<script>
const prepTimeText = document.getElementById("prepTimeText");
const deliveryBox  = document.getElementById("deliveryBox");
const qrBox        = document.getElementById("qrBox");

function getVal(name){
  const r = document.querySelector('input[name="' + name + '"]:checked');
  return r ? r.value : "";
}

function updateUI(){
  const orderType = getVal("orderType");
  const payment   = getVal("paymentMethod");

  if(orderType === "DELIVERY"){
    if (deliveryBox) deliveryBox.style.display = "block";
    if (prepTimeText) prepTimeText.textContent = "Estimated Preparation Time: 30 – 40 minutes";
  } else if(orderType === "DINE_IN"){
    if (deliveryBox) deliveryBox.style.display = "none";
    if (prepTimeText) prepTimeText.textContent = "Estimated Preparation Time: 15 – 20 minutes";
  } else {
    if (deliveryBox) deliveryBox.style.display = "none";
    if (prepTimeText) prepTimeText.textContent = "Estimated Preparation Time: —";
  }

  if (qrBox) qrBox.style.display = (payment === "ONLINE_BANKING") ? "block" : "none";
}

document.querySelectorAll('input[name="orderType"], input[name="paymentMethod"]')
  .forEach(el => el.addEventListener("change", updateUI));

updateUI();

document.addEventListener("DOMContentLoaded", () => {
  const successFlag = document.getElementById("orderSuccessFlag");
  const modal = document.getElementById("orderModal");

  if (successFlag && successFlag.value === "1") {
    modal.classList.add("show");
  }
});

function closeModal(){
  document.getElementById("orderModal").classList.remove("show");
  window.location.href = "<%= request.getContextPath() %>/orderHistory";
}

window.addEventListener("pageshow", updateUI);
</script>

</body>
</html>
