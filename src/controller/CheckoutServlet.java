package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.PaymentDAO;
import dao.ProductDAO;
import model.Order;
import model.OrderItem;
import model.Payment;
import model.Product;
import model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private PaymentDAO paymentDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        paymentDAO = new PaymentDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Check session
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Check logged-in user
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 3. Get cart (session-based)
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        // 4. Calculate total amount using DB prices
        double totalAmount = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();

            Product product = productDAO.getProductById(productId);
            if (product == null) {
                continue; // safety check
            }

            totalAmount += product.getPrice() * quantity;
        }

        // 5. Get checkout form data
        String shippingAddress = request.getParameter("shippingAddress");
        String note = request.getParameter("note");
        String paymentMethod = request.getParameter("paymentMethod");

        // 6. Create Order
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setTotalAmount(totalAmount);
        order.setOrderStatus("PENDING");
        order.setPaymentStatus("PAID");
        order.setShippingAddress(shippingAddress);
        order.setNote(note);

        int orderId = orderDAO.createOrder(order);

        // 7. Insert Order Items
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

            int productId = entry.getKey();
            int quantity = entry.getValue();

            Product product = productDAO.getProductById(productId);
            if (product == null) {
                continue;
            }

            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setProductId(productId);
            item.setQuantity(quantity);
            item.setPrice(product.getPrice()); // price at purchase time

            orderItemDAO.addOrderItem(item);
        }

        // 8. Insert Payment (simulation)
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(totalAmount);

        paymentDAO.addPayment(payment);

        // 9. Clear cart
        session.removeAttribute("cart");

        // 10. Forward to success page
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }
}
