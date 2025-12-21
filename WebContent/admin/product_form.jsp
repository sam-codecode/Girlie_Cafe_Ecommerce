<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
    boolean isEdit = (product != null);
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Edit Product" : "Add Product" %> | Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/product_form.css">
</head>

<body class="admin-page">

<div class="admin-layout">

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp" />

    <!-- MAIN CONTENT -->
    <main class="admin-main">

        <h1 class="page-title">
            <%= isEdit ? "Edit Product" : "Add Product" %>
        </h1>

        <section class="admin-card">

            <form class="admin-form"
                  method="post"
                  enctype="multipart/form-data"
                  action="<%= request.getContextPath() %>/admin/products">

                <% if (isEdit) { %>
                    <input type="hidden" name="productId"
                           value="<%= product.getProductId() %>">
                <% } %>

                <!-- PRODUCT NAME -->
                <div class="field">
                    <label>Product Name</label>
                    <input type="text" name="name"
                           value="<%= isEdit ? product.getName() : "" %>"
                           required>
                </div>

                <!-- DESCRIPTION -->
                <div class="field">
                    <label>Description</label>
                    <textarea name="description" rows="3"><%= isEdit ? product.getDescription() : "" %></textarea>
                </div>

                <!-- PRICE & STOCK -->
                <div class="grid-2">
                    <div class="field">
                        <label>Price (RM)</label>
                        <input type="number" step="0.01" name="price"
                               value="<%= isEdit ? product.getPrice() : "" %>"
                               required>
                    </div>

                    <div class="field">
                        <label>Stock</label>
                        <input type="number" name="stock"
                               value="<%= isEdit ? product.getStock() : "" %>"
                               required>
                    </div>
                </div>

                <!-- CATEGORY & IMAGE NAME -->
                <div class="grid-2">
                    <div class="field">
                        <label>Category ID</label>
                        <input type="number" name="categoryId"
                               value="<%= isEdit ? product.getCategoryId() : "" %>"
                               required>
                    </div>

                    <div class="field">
                        <label>Image File Name (optional)</label>
                        <input type="text" name="imageName"
                               placeholder="example: latte.png"
                               value="<%= isEdit ? product.getImageName() : "" %>">
                    </div>
                </div>

                <!-- IMAGE UPLOAD -->
                <div class="field">
                    <label>Upload Image (optional)</label>
                    <input type="file" name="imageFile" accept="image/*">
                </div>

                <!-- EXISTING IMAGE PREVIEW -->
                <% if (isEdit && product.getImageName() != null && !product.getImageName().isEmpty()) { %>
                    <div class="field">
                        <label>Current Image</label>
                        <img src="<%= request.getContextPath() %>/assets/images/menu/<%= product.getCategoryId() %>/<%= product.getImageName() %>"
     					alt="Product Image"
     					style="max-width: 160px; border-radius: 10px;">

                             
                    </div>
                <% } %>

                <!-- ACTIONS -->
                <div class="actions">
                    <button type="submit" class="btn-primary">
                        <%= isEdit ? "Update Product" : "Add Product" %>
                    </button>

                    <a href="<%= request.getContextPath() %>/admin/products"
                       class="btn-secondary">
                        Cancel
                    </a>
                </div>

            </form>

        </section>

    </main>

</div>

</body>
</html>
