package controller;

import dao.ProductDAO;
import model.Admin;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/admin/products")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
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
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // LIST PRODUCTS (default)
        if (action == null || action.equals("list")) {

            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
            request.setAttribute("activePage", "products");
            request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);
            return;
        }

        // ADD FORM
        if (action.equals("add")) {
            request.setAttribute("activePage", "products");
            request.getRequestDispatcher("/admin/product_form.jsp").forward(request, response);
            return;
        }

        // EDIT FORM
        if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(id);
            request.setAttribute("product", product);
            request.setAttribute("activePage", "products");
            request.getRequestDispatcher("/admin/product_form.jsp").forward(request, response);
            return;
        }

        // DELETE
        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(id);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        int productId = request.getParameter("productId") == null ? 0
                : Integer.parseInt(request.getParameter("productId"));

        // =========================
        // HANDLE IMAGE UPLOAD
        // =========================
        Part imagePart = request.getPart("imageFile");
        String imageName = request.getParameter("imageName");


        if (imagePart != null && imagePart.getSize() > 0) {
            imageName = Paths.get(imagePart.getSubmittedFileName())
                    .getFileName()
                    .toString();

            String uploadPath = getServletContext()
                    .getRealPath("/assets/images/products");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            imagePart.write(uploadPath + File.separator + imageName);
        }

        Product product = new Product();
        product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setStock(Integer.parseInt(request.getParameter("stock")));

        // ADD
        if (productId == 0) {
            product.setImageName(imageName);
            productDAO.addProduct(product);

        } else {
            // EDIT
            Product oldProduct = productDAO.getProductById(productId);

            if (imageName == null) {
                imageName = oldProduct.getImageName();
            }

            product.setProductId(productId);
            product.setImageName(imageName);
            productDAO.updateProduct(product);
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
