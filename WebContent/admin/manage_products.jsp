<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Product" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products == null) products = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Product Management | Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>
<body class="admin-page">


<div class="admin-layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

<div class="page-header">
    <h1>Product Management</h1>

    <a href="<%= request.getContextPath() %>/admin/products?action=add"
       class="btn-add">
        + Add Product
    </a>
</div>


        <div class="table-container">

            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (products.isEmpty()) {
                %>
                    <tr><td colspan="6">No products found.</td></tr>
                <%
                    } else {
                        for (Product p : products) {
                %>
                    <tr>
                        <td>#<%= p.getProductId() %></td>
                        <td><%= p.getName() %></td>
                        <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                        <td><%= p.getStock() %></td>
                        <td>Category <%= p.getCategoryId() %></td>
                        <td>
<div class="action-buttons">
    <a href="<%= request.getContextPath() %>/admin/products?action=edit&id=<%= p.getProductId() %>"
       class="btn-edit">Edit</a>

    <a href="<%= request.getContextPath() %>/admin/products?action=delete&id=<%= p.getProductId() %>"
       class="btn-delete"
       onclick="return confirm('Delete this product?')">
        Delete
    </a>
</div>

                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>

            </table>

        </div>
    </div>
</div>

</body>
</html>
