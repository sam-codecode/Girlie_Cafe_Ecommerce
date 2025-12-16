package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (userDAO.emailExists(email)) {
            request.setAttribute("errorMessage", "This email is already registered. Please log in or use a different email.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

    User newUser = new User(0, name, email, password, phone, address);

    boolean success = userDAO.registerUser(newUser);

    if (success) {

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    else {
      
        request.setAttribute("errorMessage", "Registration was unsuccessful. Please check your details and try again.");
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
  }
}

