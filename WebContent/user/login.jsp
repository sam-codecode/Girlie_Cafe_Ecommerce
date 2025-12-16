<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Girlie's Café</title>
    <link rel="stylesheet" href="../assets/css/auth.css">
</head>

<body>

<div class="auth-container">
    <h2>Welcome to Girlie’s Café Website 🍰☕💕</h2>
    <p class="subtitle">Log in to enjoy your personalized experience</p>

    <form action="UserLoginServlet" method="post" class="auth-form">
        <input type="hidden" name="action" value="login">

        <label>Email</label>
        <input type="email" name="email" required placeholder="Enter your email">

        <label>Password</label>
        <input type="password" name="password" required placeholder="Enter your password">

        <button type="submit" class="btn">Login</button>

        <p class="switch-text">
            Don’t have an account? <a href="register.jsp">Register here</a>
        </p>
    </form>
</div>

</body>
</html>
