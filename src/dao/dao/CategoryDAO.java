package dao;

import database.DBConnection;
import model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // ===========================
    // Create (Add New Category)
    // ===========================
    public boolean addCategory(Category category) {

        String sql = "INSERT INTO categories (category_name, description, image_name) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImageName());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // =========================
    // Read (Get All Category)
    // =========================
    public List<Category> getAllCategories() {

        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setImageName(rs.getString("image_name"));

                categories.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    // ===========================
    // Read (Get Category By ID)
    // ===========================
    public Category getCategoryById(int categoryId) {

        String sql = "SELECT * FROM categories WHERE category_id = ?";
        Category category = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, categoryId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    category = new Category();

                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setDescription(rs.getString("description"));
                    category.setImageName(rs.getString("image_name"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }
}