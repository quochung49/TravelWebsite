package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.model.Order;
import java.sql.Statement;

public class OrderDAO {

    private Connection connection; // Initialize this with your database connection.

    public OrderDAO() {
        this.connection = DB.DBConnect.getConn();
    }

    // Insert a new order into the database
    // Insert a new order into the database
    public boolean createOrder(Order order) {
        try {
            String query = "INSERT INTO [orders] (userId, description, status, orderDate, total) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, order.getUserId());
            stmt.setString(2, order.getDescription());
            stmt.setString(3, order.getStatus());
            stmt.setDate(4, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setDouble(5, order.getTotal());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve the auto-generated ID
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    // Set the generated ID in the order object (if needed)
                    order.setOrderId(generatedId);
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            String query = "SELECT * FROM [orders]";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                int orderId = resultSet.getInt("orderId");
                int userId = resultSet.getInt("userId");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                float total = resultSet.getFloat("total");
                java.sql.Date orderDate = resultSet.getDate("orderDate");
                orders.add(new Order(userId, orderId, description, status, total, new java.util.Date(orderDate.getTime())));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Retrieve a list of orders for a specific user
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        try {
            String query = "SELECT * FROM [orders] WHERE userId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                int orderId = resultSet.getInt("orderId");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                float total = resultSet.getFloat("total");
                java.sql.Date orderDate = resultSet.getDate("orderDate");
                orders.add(new Order(userId, orderId, description, status, total, new java.util.Date(orderDate.getTime())));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getTodayOrdersByUserId(int userId) {
        List<Order> todayOrders = new ArrayList<>();
        try {
            String query = "SELECT * FROM [orders] WHERE userId = ? AND CONVERT(DATE, orderDate) = CONVERT(DATE, GETDATE())";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                int orderId = resultSet.getInt("orderId");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                float total = resultSet.getFloat("total");
                java.sql.Date orderDate = resultSet.getDate("orderDate");
                todayOrders.add(new Order(userId, orderId, description, status, total, new java.util.Date(orderDate.getTime())));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return todayOrders;
    }

    public List<Order> getTodayOrders() {
        List<Order> todayOrders = new ArrayList<>();
        try {
            String query = "SELECT * FROM [orders] WHERE CONVERT(DATE, orderDate) = CONVERT(DATE, GETDATE())";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                int userId = resultSet.getInt("userId");
                int orderId = resultSet.getInt("orderId");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                float total = resultSet.getFloat("total");
                java.sql.Date orderDate = resultSet.getDate("orderDate");
                todayOrders.add(new Order(userId, orderId, description, status, total, new java.util.Date(orderDate.getTime())));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return todayOrders;
    }

    // Update the status of an existing order
    public boolean updateOrderStatus(int orderId, String newStatus) {
        try {
            String query = "UPDATE [orders] SET status = ? WHERE orderId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete an order
    public boolean deleteOrder(int orderId) {
        try {
            String query = "DELETE FROM [orders] WHERE orderId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, orderId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add this method to your OrderDAO class
    public int getTotalOrders() {
        int totalOrders = 0;
        try {
            String query = "SELECT COUNT(*) AS totalOrders FROM [orders]";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                totalOrders = resultSet.getInt("totalOrders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalOrders;
    }

}
