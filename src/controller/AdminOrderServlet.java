package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OrderDAO;
import dao.OrderItemDAO;
import model.Order;
import model.OrderItem;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() {
        
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
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
           action = "list";

        switch (action) {

            case "list":
                
                List<Order> orderList = orderDAO.getAllOrders();
                request.setAttribute("orders", orderList);

                
                request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
                break;

            case "view":
                
                int viewID = Integer.parseInt(request.getParameter("orderId"));

                
                Order order = orderDAO.getOrderById(viewID);

            
                List<OrderItem> items = orderItemDAO.getItemsByOrderId(viewID);

                
                request.setAttribute("order", order);
                request.setAttribute("items", items);

                request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
                break;

            case "update":
                
                int updateID = Integer.parseInt(request.getParameter("orderId"));

            
                Order UpdateOrder = orderDataAccess.getOrderById(updateID);
                request.setAttribute("order", UpdateOrder);

                request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
                break;

            default:
                
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=list");
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

        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("orderStatus");

    
        boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);

        if (updated) {
            
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list");
        } 
        else {
        
            request.setAttribute("errorMessage", "The order status could not be updated at this time. Please try again later.");
            request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
        }
    }
}
