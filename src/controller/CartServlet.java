package controller;

import dao.ProductDAO;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    // ======================
    // SHOW CART
    // ======================
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

        String cartKey = "cart_" + userId;

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute(cartKey);

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute(cartKey, cart);
        }

        Map<Product, Integer> cartItems = new LinkedHashMap<>();
        double grandTotal = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product p = productDAO.getProductById(entry.getKey());
            if (p == null) continue;

            int qty = Math.min(entry.getValue(), p.getStock());
            cartItems.put(p, qty);
            grandTotal += p.getPrice() * qty;
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("grandTotal", grandTotal);

        request.getRequestDispatcher("/user/cart.jsp")
               .forward(request, response);
    }

    // ======================
    // CART ACTIONS
    // ======================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String cartKey = "cart_" + user.getUserId();

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute(cartKey);

        if (cart == null) cart = new HashMap<>();

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        switch (action) {
            case "add":
                int addQty = Integer.parseInt(request.getParameter("quantity"));
                cart.put(productId, cart.getOrDefault(productId, 0) + addQty);
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
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
