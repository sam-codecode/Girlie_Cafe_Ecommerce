package controller;

import dao.*;
import model.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ProductDAO productDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        productDAO = new ProductDAO();
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        String cartKey = "cart_" + user.getUserId();

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute(cartKey);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        String orderType = request.getParameter("orderType");
        String note = request.getParameter("note");

        if (paymentMethod == null || orderType == null) {
            response.sendRedirect(request.getContextPath() + "/user/checkout.jsp");
            return;
        }

        // Resolve address server-side
        String shippingAddress = "";
        if ("DELIVERY".equalsIgnoreCase(orderType)) {
            shippingAddress = user.getAddress();
            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/user/checkout.jsp");
                return;
            }
        }

        // 1️⃣ Calculate total
        double total = 0.0;

        for (Map.Entry<Integer, Integer> e : cart.entrySet()) {
            Product p = productDAO.getProductById(e.getKey());
            if (p == null) continue;

            int qty = Math.min(e.getValue(), p.getStock());
            if (qty <= 0) continue;

            total += p.getPrice() * qty;
        }

        if (total <= 0) {
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
            return;
        }

        // 2️⃣ Create order
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setTotalAmount(total);
        order.setOrderStatus("PENDING");
        order.setPaymentStatus(
                "ONLINE_BANKING".equalsIgnoreCase(paymentMethod) ? "PAID" : "UNPAID"
        );
        order.setShippingAddress(shippingAddress);
        order.setNote(note == null ? "" : note);

        int orderId = orderDAO.createOrder(order);
        if (orderId <= 0) {
            response.sendRedirect(request.getContextPath() + "/user/checkout.jsp");
            return;
        }

        // 3️⃣ Order items + stock update
        for (Map.Entry<Integer, Integer> e : cart.entrySet()) {
            Product p = productDAO.getProductById(e.getKey());
            if (p == null) continue;

            int qty = Math.min(e.getValue(), p.getStock());
            if (qty <= 0) continue;

            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setProductId(p.getProductId());
            item.setQuantity(qty);
            item.setPrice(p.getPrice());

            orderItemDAO.addOrderItem(item);
            productDAO.updateStock(p.getProductId(), qty);
        }

        // 4️⃣ CREATE PAYMENT RECORD (THIS WAS MISSING)
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentDate(new java.util.Date());
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(total);

        paymentDAO.addPayment(payment);

        // 5️⃣ Clear cart
        session.removeAttribute(cartKey);

        // 6️⃣ Success
        response.sendRedirect(request.getContextPath() + "/user/checkout.jsp?success=1");
    }
}
