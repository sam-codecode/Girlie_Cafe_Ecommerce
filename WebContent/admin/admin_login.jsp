<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | Girlie's Café</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>

<body class="admin-login-page"
      style="background-image: url('<%= request.getContextPath() %>/assets/images/admin-bg.jpg');">


<div class="admin-login-overlay"></div>

<div class="admin-login-wrapper">

    <div class="admin-login-box">

        <div class="admin-login-logo">
            <img src="<%= request.getContextPath() %>/assets/images/logo.png">
        </div>

        <h2>Admin Portal</h2>
        <p class="login-subtitle">Girlie’s Café Administration</p>

        <form method="post" action="<%= request.getContextPath() %>/adminLogin">

            <label>USERNAME</label>
            <input type="text" name="username" placeholder="Enter admin username" required>

            <label>PASSWORD</label>
            <input type="password" name="password" placeholder="Enter password" required>

            <button type="submit">Login</button>
        </form>

        <% if (request.getAttribute("error") != null) { %>
            <div class="login-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

    </div>

</div>

</body>
</html>
