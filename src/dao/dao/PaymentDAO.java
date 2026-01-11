package dao;

import database.DBConnection;
import model.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class PaymentDAO {

    // =========================
    // CREATE : Record Payment
    // =========================
	public boolean addPayment(Payment payment) {

	    String sql = "INSERT INTO payments (order_id, payment_date, payment_method, amount) " +
	                 "VALUES (?, ?, ?, ?)";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, payment.getOrderId());
	        ps.setTimestamp(2, new java.sql.Timestamp(payment.getPaymentDate().getTime()));
	        ps.setString(3, payment.getPaymentMethod());
	        ps.setDouble(4, payment.getAmount());

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}


    // =========================
    // READ : Get Payment By Order
    // =========================
    public Payment getPaymentByOrderId(int orderId) {

        String sql = "SELECT * FROM payments WHERE order_id = ?";
        Payment payment = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setPaymentStatus(rs.getString("payment_status"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return payment;
    }
}
