<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products | Girlie Cafe</title>

    <!-- GOOGLE FONTS -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

    <!-- MAIN CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<!-- HEADER -->
<jsp:include page="/common/header.jsp" />

<div class="container">

    <h1 class="page-title">Our Menu</h1>

    <!-- SEARCH BAR (SERVER-SIDE)-->
    <form method="get"
          action="${pageContext.request.contextPath}/products"
          class="search-row">

        <input type="text"
               name="keyword"
               class="search-input"
               placeholder="Search your favourites"
               value="${param.keyword}" />

        <!-- Keep current category -->
        <input type="hidden"
               name="categoryId"
               value="${activeCategory}" />

        <button type="submit" class="search-btn">
            Search
        </button>
    </form>

    <!-- CATEGORY BUTTON BAR -->
    <div class="categories-row">

        <a class="category-pill ${activeCategory == 1 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/products?categoryId=1">
           Cozy Brunch
        </a>

        <a class="category-pill ${activeCategory == 2 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/products?categoryId=2">
           Western Delights
        </a>

        <a class="category-pill ${activeCategory == 3 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/products?categoryId=3">
           Pasta & Rice Bowls
        </a>

        <a class="category-pill ${activeCategory == 4 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/products?categoryId=4">
           Desserts
        </a>

        <a class="category-pill ${activeCategory == 5 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/products?categoryId=5">
           Beverages
        </a>

        <a class="category-pill ${activeCategory == 6 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/products?categoryId=6">
           Snacks & Sides
        </a>

    </div>

    <!-- PRODUCT GRID -->
    <div class="product-grid">

        <!-- EMPTY STATE -->
        <c:if test="${empty products}">
            <p class="empty-text">No products found.</p>
        </c:if>

        <!-- PRODUCT LOOP -->
        <c:forEach var="p" items="${products}">

            <!-- CATEGORY → IMAGE FOLDER -->
            <c:choose>
                <c:when test="${p.categoryId == 1}">
                    <c:set var="catFolder" value="cozy_brunch"/>
                </c:when>
                <c:when test="${p.categoryId == 2}">
                    <c:set var="catFolder" value="western"/>
                </c:when>
                <c:when test="${p.categoryId == 3}">
                    <c:set var="catFolder" value="pasta_rice"/>
                </c:when>
                <c:when test="${p.categoryId == 4}">
                    <c:set var="catFolder" value="dessert"/>
                </c:when>
                <c:when test="${p.categoryId == 5}">
                    <c:set var="catFolder" value="drinks"/>
                </c:when>
                <c:otherwise>
                    <c:set var="catFolder" value="sides"/>
                </c:otherwise>
            </c:choose>

            <div class="product-card">

                <img
                    src="${pageContext.request.contextPath}/assets/images/menu/${catFolder}/${empty p.image ? 'placeholder.png' : p.image}"
                    alt="${p.name}"
                    onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.png';"
                />

                <h3>${p.name}</h3>

                <p class="description">${p.description}</p>

                <p class="price">RM ${p.price}</p>

                <!-- VIEW DETAILS ONLY -->
                <a class="btn view"
                   href="${pageContext.request.contextPath}/productDetails?id=${p.id}">
                    View Details
                </a>

            </div>
        </c:forEach>

    </div>

</div>

<!-- FOOTER -->
<jsp:include page="/common/footer.jsp" />

</body>
</html>
