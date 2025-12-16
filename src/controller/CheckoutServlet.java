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
import model.Order;
import model.OrderItem;
import model.Payment;
import model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        double totalAmount = 0;
        for (int quantity : cart.values()) {
            totalAmount += quantity * 1.0; // price should come from DB in DAO
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String note = request.getParameter("note");

        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setTotalAmount(totalAmount);
        order.setOrderStatus("Pending");
        order.setPaymentStatus("Pending");
        order.setShippingAddress(shippingAddress);
        order.setNote(note);

        int orderId = orderDAO.createOrder(order);

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setProductId(entry.getKey());
            item.setQuantity(entry.getValue());
            item.setPrice(0); // actual price should be fetched in DAO

            orderItemDAO.addOrderItem(item);
        }

        String paymentMethod = request.getParameter("paymentMethod");

        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(totalAmount);

        paymentDAO.addPayment(payment);

        session.removeAttribute("cart");

        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }
}
