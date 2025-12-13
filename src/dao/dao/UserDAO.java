package dao;

import database.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {

    public static boolean registerUser(
        String name, String email, String password,
        String phone, String address
    ) {
        String sql = "INSERT INTO users(name,email,password,phone,address) VALUES (?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, address);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

