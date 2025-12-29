<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Menu | Girlie’s Café</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

  <!-- Main CSS -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/product.css" />
</head>

<body>

<!-- =========================
     NAVIGATION
========================= -->
<header class="top-hero">
  <nav class="top-navi">
    <a class="brand" href="<%= request.getContextPath() %>/user/index.jsp">
      <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="Girlie’s Café" class="brand-logo">
      <span class="brand-name">Girlie’s Café</span>
    </a>

    <div class="navi-links">
      <a class="navi-link" href="<%= request.getContextPath() %>/user/index.jsp">Home</a>
      <a class="navi-link active" href="<%= request.getContextPath() %>/user/products.jsp">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/orders.jsp">My History</a>
    </div>

    <a class="nav-cta pop-effect" href="<%= request.getContextPath() %>/user/cart.jsp">Checkout</a>
  </nav>

  <div class="main-text">
    <h1 class="main-title">Explore Our Menu</h1>
    <p class="main-subtitle">Tantalise Your Tastebuds</p>
  </div>
</header>

<!-- =========================
     MENU SECTION
========================= -->
<main class="menu-section">
  <div class="menu-wrap">

    <!-- Toolbar -->
    <div class="product-toolbar">

      <div class="search-row">
        <input id="searchInput" class="search-input" type="text" placeholder="Search your favourites">
        <button class="search-btn" id="searchBtn">Search</button>
      </div>

      <!-- Categories -->
      <div class="categories-row">
        <a href="#" class="category-pill" data-cat="1">Cozy Brunch</a>
        <a href="#" class="category-pill" data-cat="2">Western Delights</a>
        <a href="#" class="category-pill" data-cat="3">Pasta & Rice Bowls</a>
        <a href="#" class="category-pill" data-cat="4">Desserts</a>
        <a href="#" class="category-pill" data-cat="5">Beverages</a>
      </div>
    </div>

    <!-- Products -->
    <div class="product-container" id="productContainer"></div>

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
        Contact Us (WhatsApp)
      </a>
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

<!-- =========================
     JAVASCRIPT  temporary data later can be replaced with db 
========================= -->
<script>
  let selectedCategory = "1";

  const productsData = [
    { id:1, category:"1", name:"Classic Brunch Set", price:12.90, image:"classic-brunch.jpg" },
    { id:2, category:"1", name:"Avocado Toast", price:14.50, image:"avocado-toast.jpg" },
    { id:3, category:"2", name:"Chicken Parmigiana", price:23.00, image:"chicken-parmigiana.jpg" },
    { id:4, category:"3", name:"Tonkatsu Rice", price:19.00, image:"tonkatsu-rice.jpg" },
    { id:5, category:"4", name:"Chocolate Lava Cake", price:9.90, image:"chocolate-lava-cake.jpg" },
    { id:6, category:"5", name:"Iced Lotus Latte", price:12.00, image:"iced-lotus-latte.jpg" }
  ];

  function renderProducts(){
  const container = document.getElementById("productContainer");
  container.innerHTML = "";

  const base = "<%= request.getContextPath() %>";

  productsData.forEach(p => {
    const card = document.createElement("div");
    card.className = "product-card";
    card.dataset.name = p.name.toLowerCase();
    card.dataset.category = p.category;

    const imgPath = `${base}/assets/images/menu/${p.category}/${p.image}`;
    const fallback = `${base}/assets/images/placeholder.png`;
    const detailsUrl = `${base}/user/product_details.jsp?id=${p.id}`;

    card.innerHTML = `
      <img src="${imgPath}" class="product-image" alt="${p.name}"
           onerror="this.src='${fallback}'">

      <div class="product-row">
        <h3 class="product-name">${p.name}</h3>
        <span class="product-price">RM ${p.price.toFixed(2)}</span>
      </div>

      <a href="${detailsUrl}" class="btn-view">View Details</a>
    `;

    container.appendChild(card);
  });

  filterProducts();
}

  function filterProducts(){
    const keyword = document.getElementById("searchInput").value.toLowerCase();
    document.querySelectorAll(".product-card").forEach(card => {
      const matchesName = card.dataset.name.includes(keyword);
      const matchesCat = card.dataset.category === selectedCategory;
      card.style.display = (matchesName && matchesCat) ? "flex" : "none";
    });
  }

  function setCategory(cat){
    selectedCategory = cat;
    document.querySelectorAll(".category-pill").forEach(p => p.classList.remove("active"));
    document.querySelector(`.category-pill[data-cat="${cat}"]`).classList.add("active");
    filterProducts();
  }

  document.addEventListener("DOMContentLoaded", () => {
    renderProducts();
    setCategory("1");

    document.querySelectorAll(".category-pill").forEach(btn => {
      btn.addEventListener("click", e => {
        e.preventDefault();
        setCategory(btn.dataset.cat);
      });
    });

    document.getElementById("searchBtn").addEventListener("click", filterProducts);
    document.getElementById("searchInput").addEventListener("keyup", filterProducts);
  });
</script>

</body>
</html>