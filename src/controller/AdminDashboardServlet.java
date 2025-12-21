package controller; // Handles servlet controller

// Import required classes for servlet handling and HTTP operations
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Map this servlet to handle requests sent to /admin/dashboard
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    // Handle HTTP Get requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve the existing session without creating a new one
        HttpSession session = request.getSession(false);
        
        // Verify admin session
        if (session == null || session.getAttribute("admin") == null) {
            // Redirect unauthenticated users to the admin login page
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        // Forward to admin dashboard
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}


