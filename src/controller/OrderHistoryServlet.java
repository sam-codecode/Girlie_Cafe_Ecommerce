package controller.user;

import java.io.IOException;
import java.util.list;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.OrderDAO;
import model.Order;
import model.User;

@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {

            user = (User) session.getAttribute("user");
        }
        else {
            user = null;
        }

        if (user == null) {

            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = user.getUserId();
        List<Order> ordersList = orderDataAccess.getOrdersByUser(userId);

        request.setAttribute("orders", ordersList);

        request.getRequestDispatcher("/user/orders.jsp").forward(request, response);
    }
}
