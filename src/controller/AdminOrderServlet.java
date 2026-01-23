package controller; // Handles Admin Order Management Servlet Controller

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

// Handle admin order management (view, list, and update orders)
@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;         // DAO for accessing order data
    private OrderItemDAO orderItemDAO; // DAO for accessing order item data

    // Initialize DAOs
    @Override
    public void init() {
        orderDAO = new OrderDAO();         // Create OrderDAO object for database operations
        orderItemDAO = new OrderItemDAO(); // Create OrderItemDAO object for database operations
    }

    // Handle GET requests (list orders or view order details)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verify admin session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            // Redirect to admin login if session is invalid
            response.sendRedirect(request.getContextPath() + "/adminLogin");
            return;
        }

        // Determine requested action (default is "list")
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            // Display all orders
            case "list":
                List<Order> orderList = orderDAO.getAllOrders();
                request.setAttribute("orders", orderList);

                // Forward to order management JSP
                request.getRequestDispatcher("/admin/orders.jsp")
                       .forward(request, response);
                break;

            // Display order details for a specific order
            case "view":
                int orderId = Integer.parseInt(request.getParameter("orderId"));

                Order order = orderDAO.getOrderById(orderId);             // Fetch order data
                List<OrderItem> items = orderItemDAO.getItemsByOrderId(orderId); // Fetch order items

                request.setAttribute("order", order); // Set order as request attribute
                request.setAttribute("items", items); // Set order items as request attribute

                // Forward to order details JSP
                request.getRequestDispatcher("/admin/order_details.jsp")
                       .forward(request, response);
                break;

            // Default: redirect to order list
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
            // Redirect to admin login if session is invalid
            response.sendRedirect(request.getContextPath() + "/adminLogin");
            return;
        }

        // Retrieve order ID and new status from form submission
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("orderStatus");

        // Update order status in database
        boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);

        if (updated) {
            // Redirect to order list page on success
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list");
        } else {
            // Set error message and forward back to manage orders page if update fails
            request.setAttribute("errorMessage", "Order status update failed.");
            request.getRequestDispatcher("/admin/orders").forward(request, response);
        }
    }
}
