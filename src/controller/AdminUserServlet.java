package controller; // Handles admin user management controller

// DAO and model imports
import dao.UserDAO;
import model.Admin;
import model.User;

// Servlet imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

// Handle admin user management requests
@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO;

    // Initialize DAO
    @Override
    public void init() {
        userDAO = new UserDAO(); // Create DAO object for users
    }

    // Process user management requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;

        // Check admin authentication
        if (admin == null) {
            // Redirect to admin login if not authenticated
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        // Get requested action
        String action = request.getParameter("action");

        // Display user list (default action)
        if (action == null || action.equals("list")) {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.setAttribute("activePage", "users");

            // Forward to user management page
            request.getRequestDispatcher("/admin/manage_users.jsp")
                   .forward(request, response);
            return;
        }

        // Process user deletion
        if (action.equals("delete")) {
            int userId = Integer.parseInt(request.getParameter("id"));
            userDAO.deleteUser(userId);

            // Redirect back to user list
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}
