package controller; // Handles servlet controller

// DAO and model imports
import dao.DashboardDAO;
import model.Admin;

// Servlet imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

// Handle admin dashboard requests
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DashboardDAO dashboardDAO;

    // Initialize DAO
    @Override
    public void init() {
        dashboardDAO = new DashboardDAO(); // Create DAO object for dashboard
    }

    // Process dashboard page request
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);

        // Check admin authentication
        if (session == null || session.getAttribute("admin") == null) {
            // Redirect to admin login if session is invalid
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        // Retrieve dashboard statistics
        request.setAttribute("totalProducts", dashboardDAO.countProducts());
        request.setAttribute("totalOrders", dashboardDAO.countOrders());
        request.setAttribute("totalUsers", dashboardDAO.countUsers());
        request.setAttribute("revenue", dashboardDAO.getTotalRevenue());

        // Retrieve recent orders (latest 5)
        List<Map<String, Object>> recentOrders = dashboardDAO.getRecentOrders(5);
        request.setAttribute("recentOrders", recentOrders);

        // Forward to dashboard page
        request.getRequestDispatcher("/admin/dashboard.jsp")
               .forward(request, response);
    }
}
