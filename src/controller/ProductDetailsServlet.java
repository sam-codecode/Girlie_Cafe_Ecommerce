package controller; // Handles Product Details Servlet Controller

// DAO and model imports
import dao.ProductDAO;
import model.Product;

// Servlet and utility imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

// Handle requests to view product details
@WebServlet("/product/details")
public class ProductDetailsServlet extends HttpServlet {

    private ProductDAO productDAO; // DAO for retrieving product data

    // Initialize DAO
    @Override
    public void init() {
        productDAO = new ProductDAO(); // Create ProductDAO object for database operations
    }

    // Handle GET requests to display product details
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get product ID from request parameter
        String idParam = request.getParameter("id");

        // Redirect to products page if ID parameter is missing
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        // Parse product ID and fetch product details from DAO
        int productId = Integer.parseInt(idParam);
        Product product = productDAO.getProductById(productId);

        // Redirect to products page if product does not exist
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        // Set product as request attribute to display in JSP
        request.setAttribute("product", product);

        // Forward request to product details page
        request.getRequestDispatcher("/user/product_details.jsp")
               .forward(request, response);
    }
}
