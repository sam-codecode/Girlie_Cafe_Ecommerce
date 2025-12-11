<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Girlie Café</title>

    <!-- CSS -->
    <link rel="stylesheet" href="../assets/css/auth.css">

</head>

<body>

<div class="register-wrapper">

    <!-- LEFT DESIGN PANEL -->
    <div class="left-panel">
        <img src="../assets/images/logo.png" alt="Girlie Cafe Logo" class="logo">
    </div>

    <!-- CENTER FORM PANEL -->
    <div class="form-panel">

        <!-- MOVED REGISTER TITLE HERE -->
        <h1 class="form-title">REGISTER</h1>

        <form class="auth-form">

            <label>NAME</label>
            <input type="text" placeholder="NAME" required>

            <label>EMAIL</label>
            <input type="email" placeholder="EMAIL" required>

            <label>PASSWORD</label>
            <input type="password" placeholder="PASSWORD" required>

            <label>PHONE NUMBER</label>
            <input type="text" placeholder="PHONE NUMBER" required>

            <label>ADDRESS</label>
            <textarea placeholder="ADDRESS" rows="3" required></textarea>

            <button type="submit" class="btn-register">Register</button>

            <p class="login-text">
                Already have an account?
                <a href="login.jsp">Login here →</a>
            </p>

        </form>
    </div>

    <!-- RIGHT DECOR PANEL -->
    <div class="right-panel">
        <a href="../admin/admin_login.jsp" class="admin-login">admin login</a>
    </div>

</div>
</body>
</html>
