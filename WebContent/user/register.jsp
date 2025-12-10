<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Girlie's Café</title>
    <link rel="stylesheet" href="../assets/css/auth.css">
</head>

<body>

<div class="auth-container">
    <h2>Create Your Girlie’s Café Account 💕</h2>
    <p class="subtitle">Sign up to enjoy delicate treats and cozy moments ☕🍓</p>

    <form action="UserLoginServlet" method="post" class="auth-form">
        <input type="hidden" name="action" value="register">

        <label>Full Name</label>
        <input type="text" name="name" required placeholder="Your name">

        <label>Email</label>
        <input type="email" name="email" required placeholder="example@gmail.com">

        <label>Password</label>
        <input type="password" name="password" required placeholder="Choose a strong password">

        <label>Phone Number</label>
        <input type="text" name="phone" required placeholder="012-3456789">

        <label>Address</label>
        <textarea name="address" rows="3" required placeholder="Enter your delivery address"></textarea>

        <button type="submit" class="btn">Create Account</button>

        <p class="switch-text">
            Already have an account? <a href="login.jsp">Login here</a>
        </p>
    </form>
</div>

</body>
</html>
