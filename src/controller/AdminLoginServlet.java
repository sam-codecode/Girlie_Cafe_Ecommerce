package controller;// Handles servlet controller

// DAO and model imports
import dao.AdminDAO;
import model.Admin;

// Servlet imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

// Handle admin login requests 
@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;
    
    // Initialize DAO
    @Override
    public void init() {
        adminDAO = new AdminDAO(); // Create DAO object for admin
    }
    
    // Process login form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get login inputs
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate admin login
        Admin admin = adminDAO.login(username, password);

        if (admin != null) {

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            // Set error message
            request.setAttribute(
                "errorMessage",
                "Unable to login. Ensure your username and password are correct."
            );

            // Return to login page
            request.getRequestDispatcher("/admin/admin_login.jsp")
                   .forward(request, response);
        }
    }
}
