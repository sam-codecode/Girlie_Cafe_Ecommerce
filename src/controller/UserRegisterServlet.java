package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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

        // Check if duplicate email is exist on the database
        if (userDAO.emailExists(email)) {
            request.setAttribute("errorMessage",
                    "This email is already registered. Please log in or use a different email.");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            return;
        }

        
        User newUser = new User();
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone);
        newUser.setAddress(address);

        boolean success = userDAO.registerUser(newUser);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        } else {
            request.setAttribute("errorMessage",
                    "Registration was unsuccessful. Please try again.");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
        }
    }
}
