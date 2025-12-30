<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Menu | Girlie’s Café</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/product.css">
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
      <a class="navi-link active" href="<%= request.getContextPath() %>/products">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/orderHistory">My History</a>
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

    <!-- SEARCH -->
    <form class="product-toolbar" method="get" action="<%= request.getContextPath() %>/products">

      <div class="search-row">
        <input class="search-input"
               type="text"
               name="keyword"
               placeholder="Search your favourites"
               value="${param.keyword}">
        <button class="search-btn">Search</button>
      </div>

      <!-- CATEGORY -->
      <div class="categories-row">
        <a href="<%= request.getContextPath() %>/products?categoryId=1"
           class="category-pill ${activeCategory == 1 ? 'active' : ''}">
           Cozy Brunch
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=2"
           class="category-pill ${activeCategory == 2 ? 'active' : ''}">
           Western Delights
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=3"
           class="category-pill ${activeCategory == 3 ? 'active' : ''}">
           Pasta & Rice Bowls
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=4"
           class="category-pill ${activeCategory == 4 ? 'active' : ''}">
           Desserts
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=5"
           class="category-pill ${activeCategory == 5 ? 'active' : ''}">
           Beverages
        </a>
      </div>
    </form>

    <!-- PRODUCTS GRID -->
    <div class="product-container">

      <c:if test="${empty products}">
        <p style="text-align:center;">No products found.</p>
      </c:if>

      <c:forEach var="p" items="${products}">
        <div class="product-card">

          <img class="product-image"
               src="<%= request.getContextPath() %>/assets/images/menu/${p.categoryId}/${p.imageName}"
               alt="${p.name}"
               onerror="this.src='<%= request.getContextPath() %>/assets/images/placeholder.png'">

          <div class="product-row">
            <h3 class="product-name">${p.name}</h3>
            <span class="product-price">RM ${p.price}</span>
          </div>

          <a class="btn-view"
             href="<%= request.getContextPath() %>/product/details?id=${p.productId}">
             View Details
          </a>

        </div>
      </c:forEach>

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
