package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        if (action != null) {

            String productIdParam = request.getParameter("productId");
            if (productIdParam != null) {

                int productId = Integer.parseInt(productIdParam);

                switch (action) {

                    case "add":
                        cart.put(productId, cart.getOrDefault(productId, 0) + 1);
                        break;

                    case "remove":
                        cart.remove(productId);
                        break;

                    case "update":
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        if (quantity > 0) {
                            cart.put(productId, quantity);
                        } else {
                            cart.remove(productId);
                        }
                        break;
                }
            }
        }

        session.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
