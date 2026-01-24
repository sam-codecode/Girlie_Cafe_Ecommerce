package controller; // Handles User Order History Servlet Controller

// Java utilities and servlet API
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO and model classes
import dao.OrderDAO;
import database.DBConnection;
import model.Order;
import model.User;

// Handle requests to view user order history
@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {

    private OrderDAO orderDAO; // DAO for retrieving order data

    // Initialize DAO
    @Override
    public void init() {
        orderDAO = new OrderDAO(); // Create OrderDAO object for database operations
    }

    // Handle GET requests to display order history
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Redirect to login if session does not exist
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get logged-in user from session
        User user = (User) session.getAttribute("user");

        // Redirect to login if user is not authenticated
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Retrieve the user's ID
        int userId = user.getUserId();


        // Fetch all orders associated with this user
        List<Order> ordersList = orderDAO.getOrdersByUserId(userId);

        // Set orders as request attribute to display in JSP
        request.setAttribute("orders", ordersList);

        // Forward request to orders page
        request.getRequestDispatcher("/user/orders.jsp").forward(request, response);
    }
    public List<Order> getOrdersByUserId(int userId) {

    List<Order> orders = new ArrayList<>();

    String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Order o = new Order();
            o.setOrderId(rs.getInt("order_id"));
            o.setOrderDate(rs.getTimestamp("order_date"));
            o.setTotalAmount(rs.getDouble("total_amount"));
            o.setOrderStatus(rs.getString("order_status"));
            o.setPaymentStatus(rs.getString("payment_status"));
            orders.add(o);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return orders;
}

}
