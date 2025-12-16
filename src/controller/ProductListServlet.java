package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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
        String categoryIdParam = request.getParameter("categoryId");

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                productList = productDAO.getProductsByCategory(categoryId);
            } catch (NumberFormatException e) {
                productList = productDAO.getAllProducts();
            }
        } else {
            productList = productDAO.getAllProducts();
        }

        request.setAttribute("products", productList);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}
