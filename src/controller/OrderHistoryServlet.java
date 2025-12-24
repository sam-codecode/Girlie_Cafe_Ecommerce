package controller; // Handles servlet controller

// Java utilities and servlet API
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO and model classes
import dao.OrderDAO;
import model.Order;
import model.User;

// Handle user order history
@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;
    
    // Initialize DAO
    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }
    
    // Handle GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verify session
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Verify user login
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get user's order history
        int userId = user.getUserId();
        List<Order> ordersList = orderDAO.getOrdersByUserId(userId);
        
        // Forward request to jsp
        request.setAttribute("orders", ordersList);
        request.getRequestDispatcher("/user/orders.jsp").forward(request, response);
    }
}
