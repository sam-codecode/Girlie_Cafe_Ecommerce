package controller;

import dao.DashboardDAO;
import model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DashboardDAO dashboardDAO;

    @Override
    public void init() {
        dashboardDAO = new DashboardDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        // Stats
        request.setAttribute("totalProducts", dashboardDAO.countProducts());
        request.setAttribute("totalOrders", dashboardDAO.countOrders());
        request.setAttribute("totalUsers", dashboardDAO.countUsers());
        request.setAttribute("revenue", dashboardDAO.getTotalRevenue());

        // Recent Orders (latest 5)
        List<Map<String, Object>> recentOrders = dashboardDAO.getRecentOrders(5);
        request.setAttribute("recentOrders", recentOrders);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
