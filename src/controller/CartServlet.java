package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        If (cart == null) {
            cart = new HashMap<>();
        }

        String UserAction = request.getParameter("UserAction");

        if (UserAction != null){
            int productId = Integer.parseInt(request.getParameter("productId"));

            switch (UserAction) {

                case "add":
                    int addQuantity = cart.getOrDefault(productId, 0) + 1;
                    cart.put(productId, addQuantity);
                    break;

                case "remove":
                    cart.remove(productId);
                    break;

                case "update":
                    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                    if (newQuantity > 0) {
                        cart.put(productId, newQuantity);
                    }
                    else {
                        cart.remove(productId);
                    }
                    break;
            }
        }

        session.setAttribute("cart", cart);

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    
    }
}
