package controller; // Handles servlet controller

// Java and servlet imports
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// DAO and model imports
import dao.ProductDAO;
import model.Product;

// Handle product list display
@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

    private ProductDAO productDAO; // DAO for retrieving product data

    // Initialize DAO
    @Override
    public void init() {
        productDAO = new ProductDAO(); // Create ProductDAO object for database operations
    }

    // Handle GET requests to display product list
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> productList;

        // Get request parameters for filtering or searching
        String categoryIdParam = request.getParameter("categoryId");
        String keyword = request.getParameter("keyword");

        // Keyword search: fetch products matching the search term
        if (keyword != null && !keyword.trim().isEmpty()) {

            productList = productDAO.searchProductsAll(keyword);
            request.setAttribute("activeCategory", 0); // No category selected for search

        }
        // Category filter: fetch products by category ID
        else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {

            int categoryId = Integer.parseInt(categoryIdParam);
            productList = productDAO.getProductsByCategory(categoryId);
            request.setAttribute("activeCategory", categoryId); // Mark selected category

        }
        // Default: show random products if no search or category selected
        else {
            productList = productDAO.getRandomProducts(10);
            request.setAttribute("activeCategory", 0); // No active category
        }

        // Set products list as request attribute to display in JSP
        request.setAttribute("products", productList);

        // Forward request to product listing page
        request.getRequestDispatcher("/user/products.jsp").forward(request, response);
    }

}
