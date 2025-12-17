package dao;

import database.DBConnection;
import model.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

    // Validation (Check Username Exists)

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

    // Authenthication (Admin Login)

    public Admin login(String username, String password) {

        String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();

                admin.setAdminId(rs.getInt("admin_id"));
                admin.setName(rs.getString("name"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));

                return admin;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
