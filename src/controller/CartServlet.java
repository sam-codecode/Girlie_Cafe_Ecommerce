package controller;// Handles Cart Servlet Controller

// Java and Servlet imports
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// Model import
import model.User;

// Handle shopping cart operations which are add, update and remove products
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // Handle POST requests for cart operations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Fetch existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Redirect to login page if session does not exist
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get logged-in user from session
        User user = (User) session.getAttribute("user");

        // Redirect to login page if user is not logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        // Create a unique session key for the user's cart
        int userId = user.getUserId();
        String cartKey = "cart_" + userId;

        // Fetch existing cart from session; create new if none exists
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart =
            (Map<Integer, Integer>) session.getAttribute(cartKey);

        if (cart == null) {
            cart = new HashMap<>();
        }

        // Get action type which are add or update or remove and product ID from request
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Perform action on the cart
        switch (action) {
        case "add":
            // Add specified quantity to existing quantity in cart
            int qtyToAdd = Integer.parseInt(request.getParameter("quantity"));
            int existingQty = cart.getOrDefault(productId, 0);
            cart.put(productId, existingQty + qtyToAdd);
            break;

            case "update":
                // Update quantity; remove product if quantity <= 0
                int qty = Integer.parseInt(request.getParameter("quantity"));
                if (qty > 0) cart.put(productId, qty);
                else cart.remove(productId);
                break;

            case "remove":
                // Remove product from cart
                cart.remove(productId);
                break;
        }
        // Save updated cart back into session
        session.setAttribute(cartKey, cart);
        // Redirect to cart page
        response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
    }
}
