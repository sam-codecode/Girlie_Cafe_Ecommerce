package controller; // Handles User Registration Servlet Controller

// DAO and model imports
import dao.UserDAO;
import model.User;

// Java and servlet imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// Handle user registration requests
@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO; // DAO for accessing user data and performing registration

    // Initialize DAO
    @Override
    public void init() {
        userDAO = new UserDAO(); // Create UserDAO object for database operations
    }

    // Handle POST requests when user submits registration form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve registration form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Check if email already exists in the database
        if (userDAO.emailExists(email)) {
            // Set error message and forward back to registration page
            request.setAttribute("errorMessage",
                    "This email is already registered. Please log in or use a different email.");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            return;
        }

        // Create new User object and set properties
        User newUser = new User();
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone);
        newUser.setAddress(address);

        // Attempt to register the user in the database
        boolean success = userDAO.registerUser(newUser);

        if (success) {
            // Successful registration: redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Failed registration: set error message and forward back to registration page
            request.setAttribute("errorMessage",
                    "Registration was unsuccessful. Please try again.");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
        }
    }
}

