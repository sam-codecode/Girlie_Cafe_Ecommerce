<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.User" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");
    if (users == null) users = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Management | Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>

<body class="admin-page">

<div class="admin-layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <h1>User Management</h1>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (users.isEmpty()) {
                %>
                    <tr>
                        <td colspan="5">No users found.</td>
                    </tr>
                <%
                    } else {
                        for (User user : users) {
                %>
                    <tr>
                        <td>#U<%= user.getUserId() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getPhone() %></td>
                        <td>
                            <a href="<%= request.getContextPath() %>/admin/users?action=delete&id=<%= user.getUserId() %>"
                               class="btn-delete"
                               onclick="return confirm('Delete this user?')">
                                Delete
                            </a>
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
