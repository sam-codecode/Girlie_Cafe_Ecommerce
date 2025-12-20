<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products | Girlie's Cafe</title>

    <!-- GOOGLE FONTS -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <!-- MAIN CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<!-- HEADER -->
<jsp:include page="/common/header.jsp" />

<div class="container">

    <h1 class="page-title">Our Menu</h1>

    <!-- SEARCH BAR -->
    <form method="get"
          action="${pageContext.request.contextPath}/products"
          class="search-row">

        <input type="text"
               name="keyword"
               class="search-input"
               placeholder="Search your favourites"
               value="${param.keyword}" />

        <input type="hidden"
               name="categoryId"
               value="${activeCategory}" />

        <button type="submit" class="search-btn">Search</button>
    </form>

    <!-- CATEGORY BAR -->
    <div class="categories-row">
        <c:forEach var="i" begin="1" end="6">
            <a class="category-pill ${activeCategory == i ? 'active' : ''}"
               href="${pageContext.request.contextPath}/products?categoryId=${i}">
               Category ${i}
            </a>
        </c:forEach>
    </div>

    <!-- PRODUCT GRID -->
    <div class="product-grid">

        <c:if test="${empty products}">
            <p class="empty-text">No products found.</p>
        </c:if>

        <c:forEach var="p" items="${products}">

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
                    src="${pageContext.request.contextPath}/assets/images/menu/${catFolder}/${empty p.imageName ? 'placeholder.png' : p.imageName}"
                    alt="${p.name}"
                    onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.png';"
                />

                <h3>${p.name}</h3>

                <p class="description">${p.description}</p>

                <p class="price">RM ${p.price}</p>

                <a class="btn view"
                   href="${pageContext.request.contextPath}/product/details?id=${p.productId}">
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
