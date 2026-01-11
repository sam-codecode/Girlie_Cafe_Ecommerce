package controller; // Handles User Login Servlet Controller

// Java and servlet imports
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO and model imports
import dao.UserDAO;
import model.User;

// Handle user login requests
@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO; // DAO for accessing user data and authentication

    // Initialize DAO
    @Override
    public void init() {
        userDAO = new UserDAO(); // Create UserDAO object for login operations
    }

    // Handle POST requests when user submits login form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve email and password from request parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user using DAO
        User user = userDAO.login(email, password);

        if (user != null) {
            // Successful login: create session and store user object
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect to user home page
            response.sendRedirect(request.getContextPath() + "/user/index.jsp");
        } else {
            // Failed login: set error message and forward back to login page
            request.setAttribute("errorMessage",
                    "Unable to login. Ensure your email and password are correct.");
            request.getRequestDispatcher("/user/login.jsp").forward(request, response);
        }
    }

    // Handle GET requests to display login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/user/login.jsp").forward(request, response);
    }
}
