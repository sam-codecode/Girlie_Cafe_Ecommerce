package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAO;
import model.Product;

@WebServlet("/admin/products")
public class AdminProductServlet {
    public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() {
        
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        
        String action = request.getParameter("action");
        if (action == null) 
            action = "view";

        switch (action) {
            case "view":
    
                List<Product> productList = productDAO.getAllProducts();
                request.setAttribute("products", productList);
                request.getRequestDispatcher("/admin/product_details.jsp").forward(request, response);
                break;

            case "add":
            
                request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
                break;

            case "edit":

                int editID= Integer.parseInt(request.getParameter("productId"));
                Product selectedProduct = productDAO.getProductById(editID);
                request.setAttribute("product", selectedProduct);
                request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
                break;

            case "delete":
            
                int deleteID = Integer.parseInt(request.getParameter("productId"));
                productDAO.deleteProduct(deleteID);
                response.sendRedirect(request.getContextPath() + "/admin/products?action=view");
                break;

            default:
                
                response.sendRedirect(request.getContextPath() + "/admin/products?action=view");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        int productId = 0;
        if (request.getParameter("productId") != null) {
            productId = Integer.parseInt(request.getParameter("productId"));
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String imageName = request.getParameter("imageName");

        Product product = new Product(productId, categoryId, name, description, price, stock, imageName);

        if (productId == 0) {
            
            productDAO.addProduct(product);
        } 
        else {
            
            productDAO.updateProduct(product);
        }

        
        response.sendRedirect(request.getContextPath() + "/admin/products?action=view");
    }
}
}
