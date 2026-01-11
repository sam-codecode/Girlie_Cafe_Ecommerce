package dao;

import database.DBConnection;
import model.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

    // Check if admin username already exixts

    public boolean usernameExists(String username) {

        String sql = "SELECT admin_id FROM admins WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            return rs.next(); 

        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return false;
    }

    // Admin login authentication

    public Admin login(String username, String password) {

        String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();

                // Map database record to Admin object
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setName(rs.getString("name"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));

                return admin;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // login failed
    }

    //  Retrieve admin details based on admin ID

    public Admin getAdminById(int adminId) {

        String sql = "SELECT * FROM admins WHERE admin_id = ?";
        Admin admin = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, adminId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                admin = new Admin();

                admin.setAdminId(rs.getInt("admin_id"));
                admin.setName(rs.getString("name"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
