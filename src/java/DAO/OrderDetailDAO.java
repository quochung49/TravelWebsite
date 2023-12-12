package DAO;

import entity.model.Item;
import entity.model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    
    private Connection connection;
    
    public OrderDetailDAO() {
        this.connection = DB.DBConnect.getConn();
    }

    // Insert a list of order details into the database
    public boolean createOrderDetails(OrderDetail orderDetail) {
        try {
            String query = "INSERT INTO [OrderDetails] (OrderId, BookId, Quantity, Price) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            for (Item item : orderDetail.getItems()) {
                stmt.setInt(1, orderDetail.getOrderId());
                stmt.setInt(2, item.getBook().getId());
                stmt.setInt(3, item.getQuantity());
                stmt.setFloat(4, item.getTotal());
                stmt.addBatch();
            }
            
            int[] rowsAffected = stmt.executeBatch();
            for (int rows : rowsAffected) {
                if (rows == PreparedStatement.EXECUTE_FAILED) {
                    return false;
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

//    Retrieve a list of order details by order ID
    public OrderDetail getOrderDetailByOrderId(int orderId) {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setOrderId(orderId);
        List<Item> items = new ArrayList<>();
        try {
            String query = "SELECT * FROM [OrderDetails] WHERE OrderId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, orderId);
            ResultSet resultSet = stmt.executeQuery();
            
            while (resultSet.next()) {
                int bookId = resultSet.getInt("BookId");
                int quantity = resultSet.getInt("Quantity");
                
                Item item = new Item(); // Create an Item object with book and quantity
                item.setBook(new BookDAO().getBookById(bookId)); // Set the book using its ID
                item.setQuantity(quantity);
         
                items.add(item);
            }
            
            orderDetail.setItems(items);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetail;
    }

    // Update an order detail's quantity and price
    public boolean updateOrderDetails(OrderDetail orderDetail) {
        try {
            String query = "UPDATE OrderDetail SET Quantity = ?, Price = ? WHERE OrderId = ? AND BookId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            for (Item item : orderDetail.getItems()) {
                stmt.setInt(1, item.getQuantity());
                stmt.setFloat(2, item.getTotal());
                stmt.setInt(3, orderDetail.getOrderId());
                stmt.setInt(4, item.getBook().getId());
                stmt.addBatch();
            }
            
            int[] rowsAffected = stmt.executeBatch();
            for (int rows : rowsAffected) {
                if (rows == PreparedStatement.EXECUTE_FAILED) {
                    return false;
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete all order details for a specific order
    public boolean deleteOrderDetails(int orderId) {
        try {
            String query = "DELETE FROM OrderDetail WHERE OrderId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, orderId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
