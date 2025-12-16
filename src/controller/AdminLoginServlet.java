package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDAO;
import model.Admin;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String Username = request.getParameter("username");
        String Password = request.getParameter("password");

        Admin admin = adminDataAccess.login(username, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin); 
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } 
        else {
            request.setAttribute("errorMessage", "Unable to login. Ensure your username and password are correct");
            request.getRequestDispatcher("/admin/admin_login.jsp").forward(request, response);
        }
    }
}

