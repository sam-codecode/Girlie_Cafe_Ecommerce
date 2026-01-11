package controller;

import dao.OrderDAO;
import model.Admin;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        List<Map<String, Object>> monthlySales = orderDAO.getMonthlySales();
        List<Map<String, Object>> topProducts = orderDAO.getTopProducts();

        request.setAttribute("monthlySales", monthlySales);
        request.setAttribute("topProducts", topProducts);

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}
