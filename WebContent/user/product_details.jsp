<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Product" %>

<%
  Product product = (Product) request.getAttribute("product");
  if (product == null) {
      response.sendRedirect(request.getContextPath() + "/products.jsp");
      return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Product Details | Girlie’s Café</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

  <!-- Main CSS -->
  <link rel="stylesheet" href="../css/product.css" />
</head>

<body>

<!-- =========================
     NAVIGATION (same design)
========================= -->
<header class="top-hero">
  <nav class="top-navi">
    <a class="brand" href="home.jsp">
      <img src="../images/logo.png" alt="Girlie’s Café" class="brand-logo">
      <span class="brand-name">Girlie’s Café</span>
    </a>

    <div class="navi-links">
      <a class="navi-link" href="home.jsp">Home</a>
      <a class="navi-link active" href="products.jsp">Menu</a>
      <a class="navi-link" href="cart.jsp">Cart</a>
      <a class="navi-link" href="history.jsp">My History</a>
    </div>

    <a class="nav-cta pop-effect" href="cart.jsp">Checkout</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">Explore Our Menu</h1>
    <p class="main-subtitle">Tantalise Your Tastebuds</p>
  </div>
</header>


<!-- =========================
     PRODUCT DETAILS
========================= -->
<main class="menu-section">
  <div class="menu-wrap">

    <!-- Back link OUTSIDE the card (top) -->
    <a href="products.jsp" class="back-top-link">← Back to Menu</a>

    <!-- Pop Toast -->
    <div class="success-toast" id="successToast" aria-live="polite">
      Item has successfully been added into My Cart.
      <a href="cart.jsp">Go to Cart</a>
    </div>

    <!-- Product Card -->
    <div class="product-details">

      <!-- Image -->
      <img id="productImage"
           src="../images/placeholder.png"
           alt="Product Image"
           onerror="this.src='../images/placeholder.png'">

      <!-- Right side info -->
      <div class="product-details-info">

        <div class="product-row">
          <h3 class="product-name" id="productName">Loading...</h3>
          <span class="product-price" id="productPrice">RM 0.00</span>
        </div>

        <p class="product-desc" id="productDesc">Loading description...</p>

        <form id="addCartForm">
          <input type="hidden" id="productId" value="">

          <!-- Quantity centered + lower -->
          <div class="qty-area">
            <button type="button" id="minusBtn">-</button>
            <input type="number" id="qtyInput" name="quantity" value="1" min="1" >
            <button type="button" id="plusBtn">+</button>
          </div>

          <!-- Buttons row -->
          <div class="action-row">
            <button type="submit" class="btn-addcart">ADD TO CART</button>
          </div>
        </form>

      </div>
    </div>

  </div>
</main>

<!-- =========================
     FOOTER (same design)
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
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank">Contact Us (WhatsApp)</a>
    </div>

    <div class="footer-col">
      <div class="footer-title">Connect</div>
      <a class="footer-link" href="https://instagram.com/girliescafe" target="_blank">Instagram</a>
      <a class="footer-link" href="https://facebook.com/girliescafe" target="_blank">Facebook</a>
      <a class="footer-link" href="tel:+60111111111">+60-11-1111111</a>
    </div>

  </div>

  <div class="footer-bottom">
    © 2025 Girlie’s Café. All Rights Reserved.
  </div>
</footer>


<script>
  // ===== Quantity stepper =====
  const minusBtn = document.getElementById("minusBtn");
  const plusBtn  = document.getElementById("plusBtn");
  const qtyInput = document.getElementById("qtyInput");

  const MIN_QTY = 1;
  const MAX_QTY = 15;

  function clampQty(v){
    v = parseInt(v || MIN_QTY, 10);
    if (isNaN(v) || v < MIN_QTY) v = MIN_QTY;
    if (v > MAX_QTY) v = MAX_QTY;
    return v;
  }

  function updateButtons(){
    const v = clampQty(qtyInput.value);
    qtyInput.value = v;
    minusBtn.disabled = v <= MIN_QTY;
    plusBtn.disabled  = v >= MAX_QTY;
  }

  minusBtn.addEventListener("click", () => {
    const v = clampQty(qtyInput.value);
    qtyInput.value = Math.max(MIN_QTY, v - 1);
    updateButtons();
  });

  plusBtn.addEventListener("click", () => {
    const v = clampQty(qtyInput.value);

    if (v >= MAX_QTY){
      updateButtons();
      return;
    }

    qtyInput.value = v + 1;
    updateButtons();
  });

  qtyInput.addEventListener("input", () => {
    qtyInput.value = clampQty(qtyInput.value);
    updateButtons();
  });

  updateButtons();

  const params = new URLSearchParams(window.location.search);
  const id = params.get("id") || 1;
  document.getElementById("productId").value = id;

  // ===== TEMP data (replace later) =====
  const productsData = [
    { id:"1", category:"1", name:"Classic Brunch Set", price:12.90, image:"classic-brunch.jpg", desc:"A cozy set with eggs, toast and a side salad." },
    { id:"2", category:"1", name:"Avocado Toast", price:14.50, image:"avocado-toast.jpg", desc:"Creamy avocado, crunchy toast, light and filling." },
    { id:"3", category:"2", name:"Chicken Parmigiana", price:23.00, image:"chicken-parmigiana.jpg", desc:"Crispy chicken, rich tomato sauce, melted cheese." },
    { id:"4", category:"3", name:"Tonkatsu Rice", price:19.00, image:"tonkatsu-rice.jpg", desc:"Golden tonkatsu with warm rice and sauce." },
    { id:"5", category:"4", name:"Chocolate Lava Cake", price:9.90, image:"chocolate-lava-cake.jpg", desc:"Soft cake with gooey molten chocolate center." },
    { id:"6", category:"5", name:"Iced Lotus Latte", price:12.00, image:"iced-lotus-latte.jpg", desc:"Sweet lotus vibe with creamy iced latte." }
  ];

  const product = productsData.find(p => p.id === id) || productsData[0];

  document.title = `${product.name} | Girlie’s Café`;
  document.getElementById("productName").textContent = product.name;
  document.getElementById("productPrice").textContent = `RM ${product.price.toFixed(2)}`;
  document.getElementById("productDesc").textContent = product.desc;

  document.getElementById("productImage").src = product.image;

  // ===== Success Toast Pop =====
  const toast = document.getElementById("successToast");

  function showToast(){
    toast.classList.remove("hide");
    toast.classList.add("show");
    setTimeout(() => {
      toast.classList.remove("show");
      toast.classList.add("hide");
    }, 2500);
  }

  document.getElementById("addCartForm").addEventListener("submit", (e) => {
    e.preventDefault();
    showToast();
  });
</script>


</body>
</html>
