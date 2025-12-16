package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import model.Product;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

        List<Product> productList;

        String categoryID = request.getParameter("categoryId");

        if (categoryID != null && !categoryID.isEmpty()) {

            int categoryId = Integer.parseInt(categoryID);
            productList = productDAO.getProductsByCategory(categoryId);
        }
        else {

            productList = productDAO.getAllProducts();
        }

        request.setAttribute("products", productList);

        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}
