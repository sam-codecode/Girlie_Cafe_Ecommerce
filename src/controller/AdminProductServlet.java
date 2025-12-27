package controller; // Handles servlet controller

// DAO and model imports
import dao.ProductDAO;
import model.Admin;
import model.Product;

// Servlet and utility imports
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

// Handle admin product management requests
@WebServlet("/admin/products")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class AdminProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    // Initialize DAO
    @Override
    public void init() {
        productDAO = new ProductDAO(); // Create DAO object for products
    }

    // Process product management page requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;

        // Check admin authentication
        if (admin == null) {
            // Redirect to admin login if not authenticated
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        // Get requested action
        String action = request.getParameter("action");

        // Display product list (default action)
        if (action == null || action.equals("list")) {

            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
            request.setAttribute("activePage", "products");

            // Forward to product management page
            request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);
            return;
        }

        // Display add product form
        if (action.equals("add")) {
            request.setAttribute("activePage", "products");

            // Forward to product form page
            request.getRequestDispatcher("/admin/product_form.jsp").forward(request, response);
            return;
        }

        // Display edit product form
        if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(id);
            request.setAttribute("product", product);
            request.setAttribute("activePage", "products");

            // Forward to product form page
            request.getRequestDispatcher("/admin/product_form.jsp").forward(request, response);
            return;
        }

        // Process product deletion
        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(id);

            // Redirect back to product list
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    // Process add and edit product form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;

        // Check admin authentication
        if (admin == null) {
            // Redirect to admin login if not authenticated
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        // Get product ID (0 indicates new product)
        int productId = request.getParameter("productId") == null ? 0
                : Integer.parseInt(request.getParameter("productId"));

        // Handle image upload
        Part imagePart = request.getPart("imageFile");
        String imageName = null;

        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        if (imagePart != null && imagePart.getSize() > 0) {

            // Extract uploaded file name
            imageName = Paths.get(imagePart.getSubmittedFileName())
                    .getFileName()
                    .toString();

            // Build image upload directory path
            String uploadPath = getServletContext()
                    .getRealPath("/assets/images/menu/" + categoryId);

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Create directory if it does not exist
            }

            // Save uploaded image file
            imagePart.write(uploadPath + File.separator + imageName);
        }

        // Create product object and set values
        Product product = new Product();
        product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setStock(Integer.parseInt(request.getParameter("stock")));

        // Add new product
        if (productId == 0) {
            product.setImageName(imageName);
            productDAO.addProduct(product);

        } else {
            // Update existing product
            Product oldProduct = productDAO.getProductById(productId);

            if (imageName == null) {
                imageName = oldProduct.getImageName();
            }

            product.setProductId(productId);
            product.setImageName(imageName);
            productDAO.updateProduct(product);
        }

        // Redirect back to product list
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
