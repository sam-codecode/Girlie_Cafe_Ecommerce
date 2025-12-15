package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.OrderDAO;
import dao.PaymentDAO;
import model.Order;
import model.OrderItem;
import model.Payment;
import model.Product;
import model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private PaymentDAO PaymentDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        PaymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        double totalAmount = 0;
        for (OrderItem item : cartItems) {
            totalAmount += item.getPrice() * item.getQuantity();
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

        for (OrderItem item : cartItems) {
            item.setOrderId(orderId);
            orderDAO.addOrderItem(item);
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
