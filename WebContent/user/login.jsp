<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang ="en">
<head>
    <meta charset ="UTF-8">
    <title>Login | Girlie's Café</title>

     <%-- login page stylesheet --%>
    <link rel = "stylesheet"
          href ="<%= request.getContextPath() %>/assets/css/auth.css">
</head>

<body>

<%-- Main authentication wrapper for login --%>
<div class= "auth-wrapper">

    <img src ="<%= request.getContextPath() %>/assets/images/logo.png"
         alt ="Girlie's Café Logo"
         class ="login-logo">
    <div class ="auth-container">

    <h2>Welcome to Girlie’s Café Website 🍰☕💕</h2>
    <p class="subtitle">Log in to enjoy your personalized experience!</p>

    <form class="auth-form"
          method="post"
          action="<%= request.getContextPath() %>/login">

        <label for ="email">EMAIL</label>
        <input id ="email" type ="email" name="email"
               required placeholder="Enter your email">

        <label for="password">PASSWORD</label>
        <input id="password" type = "password" name="password"
               required placeholder = "Enter your password">

        <button type = "submit" class = "btn">Login</button>
    </form>

    <%-- Link to registration page for new users --%>
    <p class ="switch-text">
        Don’t have an account?
        <a href ="<%= request.getContextPath() %>/user/register.jsp">
            Register here →
        </a>
    </p>
   </div>
  </div>
</body>
</html>
