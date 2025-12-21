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

        List<Product> productList;

        // Read request parameters
        String categoryIdParam = request.getParameter("categoryId");
        String keyword = request.getParameter("keyword");
        
        // Filter products by category if parameter provided
        if (keyword != null && !keyword.trim().isEmpty()) {
            
            // Use selected category if provided, otherwise default to category 1
            int categoryId;
            if (categoryIdParam == null || categoryIdParam.isEmpty()){
                categoryId = 1;
            } 
            else {
                categoryId = Integer.parseInt(categoryIdParam);
            }
                   
            productList = productDAO.searchProducts(keyword, categoryId);
            request.setAttribute("activeCategory", categoryId);

        }
        // Filter products by category
        else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {

            int categoryId = Integer.parseInt(categoryIdParam);
            productList = productDAO.getProductsByCategory(categoryId);
            request.setAttribute("activeCategory", categoryId);

        }
        // Display products from category ID = 1
        else {

            productList = productDAO.getProductsByCategory(1);
            request.setAttribute("activeCategory", 1);
        }

       
        // Forward product list to JSP
        request.setAttribute("products", productList);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}
