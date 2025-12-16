package controller.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import model.Product;

@WebServlet("/product/details")
public class ProductDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

        String ID = request.getParameter("id");

        if (ID == null) {
            request.setAttribute("errorMessage", "This product may have been removed or is no longer available.");
            request.getRequestDispatcher("/products.jsp").forward(request, response);
            return;
        }

        int productId = Integer.parseInt(ID);

        Product product = productDAO.getProductById(productId);

        if (product != null) {

            request.setAttribute("product", product);
            request.getRequestDispatcher("/product_details.jsp").forward(request, response);
        }
        else {

            request.setAttribute("errorMessage", "This product may have been removed or is no longer available.");
            request.getRequestDispatcher("/product.jsp").forward(request, response);
        }
    }
}
