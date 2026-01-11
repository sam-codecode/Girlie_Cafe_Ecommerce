<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register | Girlie's Café</title>

  <%-- register page stylesheet --%>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/auth.css">
</head>

<body>
  <%-- register page wrapper --%>
  <div class="register-wrapper">

    <div class= "left-panel"></div>

    <div class ="form-panel">
      <div class="register-header">
        <img 
          src="<%= request.getContextPath() %>/assets/images/logo.png" 
          alt="Girlie's Café Logo" 
          class="register-logo"
        >
        <h1 class="form-title">REGISTER</h1>
      </div>

      <form class ="auth-form" method="post" action="<%= request.getContextPath() %>/register">

        <label for ="name">NAME</label>
        <input id="name" name ="name" type="text" required placeholder="NAME">

        <label for="email">EMAIL</label>
        <input id="email" name="email" type="email" required placeholder="EMAIL">

        <label for="password">PASSWORD</label>
        <input id ="password" name ="password" type ="password" required placeholder="PASSWORD">

        <label for ="phone">PHONE NUMBER</label>
        <input id ="phone" name="phone" type="text" required placeholder="PHONE NUMBER">

        <label for ="address">ADDRESS</label>
        <textarea id ="address" name="address" rows ="3" placeholder ="ADDRESS"></textarea>

        <button type ="submit" class="btn-register">Register</button>
      </form>

      <%-- Link to login page for existing users --%>
      <p class="login-text">
        Already have an account?
        <a href="<%= request.getContextPath() %>/user/login.jsp">Login here →</a>
      </p>
    </div>

    <%-- Link to login page for admin --%>
    <div class="right-panel">
      <a href="<%= request.getContextPath() %>/admin/admin_login.jsp" class="admin-login">
        admin login
      </a>
    </div>

  </div>
</body>
</html>