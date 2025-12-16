<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products - Girlie's Café</title>

    <!-- MAIN CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css">
</head>

<body>

<h2 class="page-title">🍰 Our Delicious Products ☕</h2>

<%
    /* TEMPORARY DATA (UI ONLY – replace later with Servlet) */
    List<Product> productList = new ArrayList<>();

    productList.add(new Product(1, 1, "Strawberry Cupcake",
            "Soft vanilla cupcake topped with strawberry frosting.",
            6.50, 12, "cupcake.png"));

    productList.add(new Product(2, 1, "Chocolate Muffin",
            "Rich chocolate muffin with chocolate chips.",
            7.90, 5, "cupcake.png"));

    productList.add(new Product(3, 2, "Iced Latte",
            "Chilled latte with creamy milk and espresso.",
            9.50, 0, "cupcake.png"));
%>

<div class="product-container">

<% for (Product product : productList) { %>

    <div class="product-card">

        <img src="<%= request.getContextPath() %>/assets/images/<%= product.getImageName() %>"
             alt="<%= product.getName() %>"
             class="product-image">

        <h3 class="product-name"><%= product.getName() %></h3>

        <p class="product-desc"><%= product.getDescription() %></p>

        <p class="product-price">RM <%= String.format("%.2f", product.getPrice()) %></p>

        <p class="product-stock">
            <%= (product.getStock() > 0)
                    ? "Stock: " + product.getStock()
                    : "Out of stock" %>
        </p>

        <a href="#" class="btn-view">View Details</a>

    </div>

<% } %>

</div>

</body>
</html>
