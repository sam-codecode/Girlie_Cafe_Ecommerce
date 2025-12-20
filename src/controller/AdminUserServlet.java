package controller;

import dao.UserDAO;
import model.Admin;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ===== AUTH CHECK =====
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // ===== DEFAULT: LIST USERS =====
        if (action == null || action.equals("list")) {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.setAttribute("activePage", "users");
            request.getRequestDispatcher("/admin/manage_users.jsp").forward(request, response);
            return;
        }

        // ===== DELETE USER =====
        if (action.equals("delete")) {
            int userId = Integer.parseInt(request.getParameter("id"));
            userDAO.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}
