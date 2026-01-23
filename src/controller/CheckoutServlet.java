package controller; // Handles Checkout Servlet Controller

// DAO and model imports
import dao.*;
import model.*;

import javax.servlet.ServletException;
// Servlet and utility imports
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

// Handle checkout operations which are create order, update stock and record payment
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    // DAO  objects for database operations
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ProductDAO productDAO;
    private PaymentDAO paymentDAO;

    // Initialize all DAO objects
    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        productDAO = new ProductDAO();
        paymentDAO = new PaymentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart_" + userId);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        Map<Product, Integer> checkoutItems = new LinkedHashMap<>();
        double grandTotal = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product p = productDAO.getProductById(entry.getKey());
            if (p == null) continue;

            int qty = Math.min(entry.getValue(), p.getStock());
            checkoutItems.put(p, qty);
            grandTotal += p.getPrice() * qty;
        }

        String address = user.getAddress() == null ? "" : user.getAddress().trim();
        String addressHtml = address
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\n", "<br>");

        request.setAttribute("checkoutItems", checkoutItems);
        request.setAttribute("grandTotal", grandTotal);
        request.setAttribute("userAddressHtml", addressHtml);

        request.getRequestDispatcher("/user/checkout.jsp").forward(request, response);
    }



    
    // Handle POST requests for checkout process
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Fetch existing session
        HttpSession session = request.getSession(false);

        // Redirect to login if session does not exist
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get logged-in user from session
        User user = (User) session.getAttribute("user");

        // Redirect to login if user not authenticated
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get unique cart key for this user
        String cartKey = "cart_" + user.getUserId();
        
        // Fetch cart from session
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute(cartKey);

        // Redirect to cart page if cart is empty
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Get checkout form parameters
        String paymentMethod = request.getParameter("paymentMethod");
        String orderType = request.getParameter("orderType");
        String note = request.getParameter("note");
        
        // Validate required parameters
        if (paymentMethod == null || orderType == null) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        // Resolve address if order type is DELIVERY
        String shippingAddress = "";
        if ("DELIVERY".equalsIgnoreCase(orderType)) {
            shippingAddress = user.getAddress();
            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/checkout");
                return;
            }
        }

        // Calculate total amount of the cart
        double total = 0.0;

        for (Map.Entry<Integer, Integer> e : cart.entrySet()) {
            Product p = productDAO.getProductById(e.getKey());
            if (p == null) continue;

            int qty = Math.min(e.getValue(), p.getStock());
            if (qty <= 0) continue;

            total += p.getPrice() * qty;
        }

        // Redirect to cart page if total <= 0
        if (total <= 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Create order object
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setTotalAmount(total);
        order.setOrderStatus("PENDING");
        order.setPaymentStatus(
                "ONLINE_BANKING".equalsIgnoreCase(paymentMethod) ? "PAID" : "UNPAID"
        );
        order.setShippingAddress(shippingAddress);
        order.setNote(note == null ? "" : note);

        // Save order in database
        int orderId = orderDAO.createOrder(order);
        if (orderId <= 0) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        // Create OrderItems and update product stock
        for (Map.Entry<Integer, Integer> e : cart.entrySet()) {
            Product p = productDAO.getProductById(e.getKey());
            if (p == null) continue;

            int qty = Math.min(e.getValue(), p.getStock());
            if (qty <= 0) continue;

            // Create order item
            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setProductId(p.getProductId());
            item.setQuantity(qty);
            item.setPrice(p.getPrice());

            // Save order item and update stock
            orderItemDAO.addOrderItem(item);
            productDAO.updateStock(p.getProductId(), qty);
        }

        // Create payment record
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentDate(new java.util.Date());
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(total);

        paymentDAO.addPayment(payment);

        // Clear cart from session
        session.removeAttribute(cartKey);

        // Redirect to checkout page with success message
        response.sendRedirect(request.getContextPath() + "/orderHistory");
    }
}
