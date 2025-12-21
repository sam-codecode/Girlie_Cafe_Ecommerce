package dao;

import database.DBConnection;
import model.OrderItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {

    // =========================
    // CREATE : Add Item to Order
    // =========================
    public boolean addOrderItem(OrderItem item) {

        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setBigDecimal(4, item.getPrice());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}