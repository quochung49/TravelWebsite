package DAO;

import entity.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    private Connection connection; // Initialize this with your database connection.

    public CategoryDAO() {
        this.connection = DB.DBConnect.getConn();
    }

    // Retrieve a list of all categories from the database
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM [Categories]";
        try ( PreparedStatement statement = connection.prepareStatement(sql);  ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("CategoryId");
                String name = resultSet.getString("CategoryName");

                Category category = new Category(id, name);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return categories;
    }

    // Retrieve a category by its ID
    public Category getCategoryById(int id) {
        Category category = null;
        String sql = "SELECT * FROM [Categories] WHERE CategoryId = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id); // Set the CategoryId parameter
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String name = resultSet.getString("CategoryName");
                    category = new Category(id, name);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception appropriately
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return category;
    }

    // Insert a new category
    public void addCategory(Category category) {
        String sql = "INSERT INTO [Categories] (CategoryId, CategoryName) VALUES (?, ?)";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, category.getId());
            statement.setString(2, category.getName());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Update an existing category
    public void updateCategory(Category category) {
        String sql = "UPDATE [Categories] SET CategoryName = ? WHERE CategoryId = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, category.getName());
            statement.setInt(2, category.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Delete a category by ID
    public void deleteCategory(int categoryId) {
        String sql = "DELETE FROM [Categories] WHERE CategoryId = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }
}
