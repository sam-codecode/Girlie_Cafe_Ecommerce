package controller;// Handles Admin Report Servlet Controller

// DAO and model imports
import dao.OrderDAO;
import model.Admin;

// Servlet and utility imports
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

// Handle admin sales and report viewing requests
@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {

    private OrderDAO orderDAO;

    // Initialize DAO
    @Override
    public void init() {
        orderDAO = new OrderDAO();// Create DAO object for order reports
    }
    
    // Process report page requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);

        // Check whether admin is logged in
        if (session == null || session.getAttribute("admin") == null) {
            // Redirect to admin login page if authentication fails
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }
        
        // Retrieve monthly sales report data from database
        List<Map<String, Object>> monthlySales = orderDAO.getMonthlySales();

         // Retrieve top-selling products report data from database
        List<Map<String, Object>> topProducts = orderDAO.getTopProducts();
        
        // Store report data in request scope
        request.setAttribute("monthlySales", monthlySales);
        request.setAttribute("topProducts", topProducts);
        
        // Forward request to admin reports JSP page
        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}
