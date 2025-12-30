package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.User;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = user.getUserId();
        String cartKey = "cart_" + userId;

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
            (Map<Integer, Integer>) session.getAttribute(cartKey);

        if (cart == null) {
            cart = new HashMap<>();
        }

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        switch (action) {
            case "add":
                cart.put(productId, cart.getOrDefault(productId, 0) + 1);
                break;

            case "update":
                int qty = Integer.parseInt(request.getParameter("quantity"));
                if (qty > 0) cart.put(productId, qty);
                else cart.remove(productId);
                break;

            case "remove":
                cart.remove(productId);
                break;
        }

        session.setAttribute(cartKey, cart);
        response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
    }
}
