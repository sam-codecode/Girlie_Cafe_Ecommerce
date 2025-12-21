package dao;

import database.DBConnection;
import model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =========================
    // CREATE : Place New Order
    // =========================
	public int createOrder(Order order) {

	    String sql = "INSERT INTO orders (user_id, total_amount, order_status, payment_status, shipping_address, note) " +
	                 "VALUES (?, ?, ?, ?, ?, ?)";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

	        ps.setInt(1, order.getUserId());
	        ps.setDouble(2, order.getTotalAmount());
	        ps.setString(3, order.getOrderStatus());
	        ps.setString(4, order.getPaymentStatus());
	        ps.setString(5, order.getShippingAddress());
	        ps.setString(6, order.getNote());

	        ps.executeUpdate();

	        try (ResultSet rs = ps.getGeneratedKeys()) {
	            if (rs.next()) {
	                return rs.getInt(1); // ✅ order_id
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return -1; // ❌ failed
	}


    // =========================
    // READ : Get Order by ID
    // =========================
    public Order getOrderById(int orderId) {

        String sql = "SELECT * FROM orders WHERE order_id = ?";
        Order order = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setNote(rs.getString("note"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    // =========================
    // READ : Get Orders by User
    // =========================
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setNote(rs.getString("note"));

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // =========================
    // UPDATE : Order Status
    // =========================
    public boolean updateOrderStatus(int orderId, String orderStatus) {

        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderStatus);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // =========================
    // UPDATE : Payment Status
    // =========================
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {

        String sql = "UPDATE orders SET payment_status = ? WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
 // =========================
 // READ : Get All Orders (Admin)
 // =========================
 public List<Order> getAllOrders() {

     List<Order> orders = new ArrayList<>();
     String sql = "SELECT * FROM orders ORDER BY order_date DESC";

     try (Connection con = DBConnection.getConnection();
          PreparedStatement ps = con.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {

         while (rs.next()) {
             Order order = new Order();

             order.setOrderId(rs.getInt("order_id"));
             order.setUserId(rs.getInt("user_id"));
             order.setOrderDate(rs.getTimestamp("order_date"));
             order.setTotalAmount(rs.getDouble("total_amount"));
             order.setOrderStatus(rs.getString("order_status"));
             order.setPaymentStatus(rs.getString("payment_status"));
             order.setShippingAddress(rs.getString("shipping_address"));
             order.setNote(rs.getString("note"));

             orders.add(order);
         }

     } catch (Exception e) {
         e.printStackTrace();
     }

     return orders;
 }

    
}