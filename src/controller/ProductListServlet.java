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

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> productList;

        String categoryIdParam = request.getParameter("categoryId");
        String keyword = request.getParameter("keyword");

        // Keyword search 
        if (keyword != null && !keyword.trim().isEmpty()) {

            productList = productDAO.searchProductsAll(keyword);
            request.setAttribute("activeCategory", 0);

        }
        // ategory filter
        else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {

            int categoryId = Integer.parseInt(categoryIdParam);
            productList = productDAO.getProductsByCategory(categoryId);
            request.setAttribute("activeCategory", categoryId);

        }
        //Default random products
        else {
            productList = productDAO.getRandomProducts(10);
            request.setAttribute("activeCategory", 0);
        }

        request.setAttribute("products", productList);
        request.getRequestDispatcher("/user/products.jsp").forward(request, response);
    }

}
