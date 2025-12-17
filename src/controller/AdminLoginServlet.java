package controller;

import dao.AdminDAO;
import model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO(); // Create DAO object for admin
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = adminDAO.login(username, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);

            
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.setAttribute(
                "errorMessage",
                "Unable to login. Ensure your username and password are correct."
            );
            request.getRequestDispatcher("/admin/admin_login.jsp")
                   .forward(request, response);
        }
    }
}
