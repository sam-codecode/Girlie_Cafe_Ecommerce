package controller; // Handles servlet controller

// Java utilities and servlet API 
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO classes
import dao.OrderDAO;
import dao.OrderItemDAO;

// Model classes
import model.Order;
import model.OrderItem;

// Handle admin order management
@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    
    // Initialize DAOs
    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }
    
    // Handle GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verify admin session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }
        
        // Determine action (default: list)
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

        case "list":
            List<Order> orderList = orderDAO.getAllOrders();
            request.setAttribute("orders", orderList);
            request.getRequestDispatcher("/admin/manage_orders.jsp")
                   .forward(request, response);
            break;

        case "view":
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            Order order = orderDAO.getOrderById(orderId);
            List<OrderItem> items = orderItemDAO.getItemsByOrderId(orderId);

            request.setAttribute("order", order);
            request.setAttribute("items", items);

            // ✅ IMPORTANT: forward to order_details.jsp
            request.getRequestDispatcher("/admin/order_details.jsp")
                   .forward(request, response);
            break;

        default:
            response.sendRedirect(request.getContextPath() +
                                  "/admin/orders?action=list");
    }

    }
    
    // Handle POST requests (update order status)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verify admin session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }
        
        // Get form data 
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("orderStatus");
        
        // Update order status
        boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);

        if (updated) {
            // Redirect to order list on success
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list");
        } else {
            // Show error if update fails
            request.setAttribute("errorMessage", "Order status update failed.");
            request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);

        }
    }
}
