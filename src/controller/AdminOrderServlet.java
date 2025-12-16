package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import dao.OrderItemDAO;
import model.Order;
import model.OrderItem;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "list":
                List<Order> orderList = orderDAO.getAllOrders();
                request.setAttribute("orders", orderList);
                request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
                break;

            case "view":
            case "update":
                int orderId = Integer.parseInt(request.getParameter("orderId"));

                Order order = orderDAO.getOrderById(orderId);
                List<OrderItem> items = orderItemDAO.getItemsByOrderId(orderId);

                request.setAttribute("order", order);
                request.setAttribute("items", items);

                request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("orderStatus");

        boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list");
        } else {
            request.setAttribute("errorMessage", "Order status update failed.");
            request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
        }
    }
}
