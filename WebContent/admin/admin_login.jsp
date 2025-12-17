<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | Girlie's Café</title>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">
</head>

<body>

<div class="admin-login-wrapper">

    <div class="admin-login-box">
        <h2>Admin Login</h2>

        <form method="post" action="<%= request.getContextPath() %>/adminLogin">

            <label>USERNAME</label>
            <input type="text" name="username" required>

            <label>PASSWORD</label>
            <input type="password" name="password" required>

            <button type="submit">Login</button>
        </form>

        <a class="back-link" href="<%= request.getContextPath() %>/user/login.jsp">
            ← Back to user login
        </a>
    </div>

</div>

</body>
</html>
