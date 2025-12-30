package controller; // Handles servlet controller

// Java and servlet imports
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO and model imports
import dao.ProductDAO;
import model.Product;

@WebServlet("/product/details")
public class ProductDetailsServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            request.setAttribute("errorMessage",
                    "This product may have been removed or is no longer available.");
            request.getRequestDispatcher("/user/products.jsp").forward(request, response);
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid product request.");
            request.getRequestDispatcher("/user/products.jsp").forward(request, response);
            return;
        }

        Product product = productDAO.getProductById(productId);

        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("/user/product_details.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage",
                    "This product may have been removed or is no longer available.");
            request.getRequestDispatcher("/user/products.jsp").forward(request, response);
        }
    }
}
