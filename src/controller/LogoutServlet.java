package controller; // Handles Admin Logout Servlet Controller

// Servlet and utility imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

// Handle admin logout requests
@WebServlet("/admin/logout")
public class LogoutServlet extends HttpServlet {

    // Handle GET requests for admin logout
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Invalidate session if it exists to log out admin
        if (session != null) {
            session.invalidate();
        }
        // Redirect to admin login page after logout
        response.sendRedirect(request.getContextPath() + "/admin/logout");
    }
}
