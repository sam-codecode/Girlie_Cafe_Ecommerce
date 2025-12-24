package controller; // Handles servlet controller

// Java and servlet imports
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO and model imports
import dao.ProductDAO;
import model.Product;

// Handle product details view
@WebServlet("/product/details")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    
    // Initialize DAO
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    // Handle GET request
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get product ID parameter
        String idParam = request.getParameter("id");
        
        // Check if parameter is missing
        if (idParam == null) {
            request.setAttribute("errorMessage",
                    "This product may have been removed or is no longer available.");
            request.getRequestDispatcher("/products.jsp").forward(request, response);
            return;
        }
        
        // Convert product ID to integer and handle invalid input 
        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage",
                    "Invalid product request.");
            request.getRequestDispatcher("/products.jsp").forward(request, response);
            return;
        }

        // Fetch product from DAO
        Product product = productDAO.getProductById(productId);
        
        // Forward to product details page if found; otherwise show error
        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("/product_details.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage",
                    "This product may have been removed or is no longer available.");
            request.getRequestDispatcher("/products.jsp").forward(request, response);
        }
    }
}
