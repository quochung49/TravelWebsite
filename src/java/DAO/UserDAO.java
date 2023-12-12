package DAO;

import entity.user.User;
import DB.DBConnect; // Assuming you have a database connection class
import entity.model.UserRole;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class UserDAO {

    private Connection connection;
    private static final String ENCRYPTION_KEY = "oAw0SYadOXTFfE7sI38a8Qq8z90YOWr9";

    public UserDAO() {
        connection = DBConnect.getConn(); // Get a database connection
    }

    public boolean userRegister(User user) {
        // Check if the email already exists in the database
        if (isEmailRegistered(user.getEmail())) {
            return false; // Email already exists, registration failed
        }

        // If email is not registered, proceed with the registration
        String sql = "INSERT INTO [Users] (Email, Password, FirstName, LastName, StreetAddress, Zipcode, City, Country, Phone, roleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getEmail());
            String encryptedPassword = encryptPassword(user.getPassword());
            statement.setString(2, encryptedPassword);
            statement.setString(3, user.getFirstName());
            statement.setString(4, user.getLastName());
            statement.setString(5, user.getStreetAddress());
            statement.setString(6, user.getZipcode());
            statement.setString(7, user.getCity());
            statement.setString(8, user.getCountry());
            statement.setString(9, user.getPhone());
            statement.setInt(10, user.getRole().getId());
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isEmailRegistered(String email) {
        String sql = "SELECT COUNT(*) FROM [Users] WHERE Email = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0; // If count > 0, email is already registered
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Error occurred, assume email is not registered
    }

    public User login(String email, String password) {
        String sql = "SELECT * FROM [Users] WHERE Email = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String storedPassword = resultSet.getString("Password");
                    if (verifyPassword(password, storedPassword)) {
                        int userId = resultSet.getInt("UserId");
                        String firstName = resultSet.getString("FirstName");
                        String lastName = resultSet.getString("LastName");
                        String streetAddress = resultSet.getString("StreetAddress");
                        String zipcode = resultSet.getString("Zipcode");
                        String city = resultSet.getString("City");
                        String country = resultSet.getString("Country");
                        String phone = resultSet.getString("Phone");
                        UserRole role = new UserRoleDAO().getRoleById(resultSet.getInt("roleId"));
                        return new User(userId, email, password, firstName, lastName, streetAddress, zipcode, city, country, phone, role);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

  

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM [Users] WHERE Email = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int userId = resultSet.getInt("UserId");
                    String password = decryptPassword(resultSet.getString("Password"));
                    String firstName = resultSet.getString("FirstName");
                    String lastName = resultSet.getString("LastName");
                    String streetAddress = resultSet.getString("StreetAddress");
                    String zipcode = resultSet.getString("Zipcode");
                    String city = resultSet.getString("City");
                    String country = resultSet.getString("Country");
                    String phone = resultSet.getString("Phone");
                    UserRole role = new UserRoleDAO().getRoleById(resultSet.getInt("roleId"));

                    return new User(userId, email, password, firstName, lastName, streetAddress, zipcode, city, country, phone, role);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if user with the given email is not found
    }

    // Retrieve a user by username
    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE UserId = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int id = resultSet.getInt("UserID");
                    String password = decryptPassword(resultSet.getString("Password"));
                    String email = resultSet.getString("Email");
                    String firstName = resultSet.getString("FirstName");
                    String lastName = resultSet.getString("LastName");
                    String streetAddress = resultSet.getString("StreetAddress");
                    String zipcode = resultSet.getString("Zipcode");
                    String city = resultSet.getString("City");
                    String country = resultSet.getString("Country");
                    String phone = resultSet.getString("Phone");
                    UserRole role = new UserRoleDAO().getRoleById(resultSet.getInt("roleId"));

                    return new User(id, email, password, firstName, lastName, streetAddress, zipcode, city, country, phone, role);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return null; // Return null if user not found
    }

    // Update an existing user record
    public void updateUser(User user) {
        String sql = "UPDATE [Users] SET Password=?, Email=?, FirstName=?, LastName=?, StreetAddress=?, Zipcode=?, City=?, Country=?, Phone=? WHERE UserID=?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, encryptPassword(user.getPassword()));
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getFirstName());
            statement.setString(4, user.getLastName());
            statement.setString(5, user.getStreetAddress());
            statement.setString(6, user.getZipcode());
            statement.setString(7, user.getCity());
            statement.setString(8, user.getCountry());
            statement.setString(9, user.getPhone());
            statement.setInt(10, user.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    public void updateUserRole(User user) {
        String sql = "UPDATE [Users] SET roleId=? WHERE UserID=?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, user.getRole().getId());
            statement.setInt(2, user.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE Username = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int id = resultSet.getInt("UserID");
                    String password = decryptPassword(resultSet.getString("Password"));
                    String email = resultSet.getString("Email");
                    String firstName = resultSet.getString("FirstName");
                    String lastName = resultSet.getString("LastName");
                    String streetAddress = resultSet.getString("StreetAddress");
                    String zipcode = resultSet.getString("Zipcode");
                    String city = resultSet.getString("City");
                    String country = resultSet.getString("Country");
                    String phone = resultSet.getString("Phone");
                    UserRole role = new UserRoleDAO().getRoleById(resultSet.getInt("roleId"));

                    return new User(id, email, password, firstName, lastName, streetAddress, zipcode, city, country, phone, role);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return null; // Return null if user not found
    }

    // Delete a user record by ID
    // Retrieve a list of all users from the database
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [Users]";
        try ( PreparedStatement statement = connection.prepareStatement(sql);  ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("UserID");
                String email = resultSet.getString("Email");
                String password = decryptPassword(resultSet.getString("Password"));
                String firstName = resultSet.getString("FirstName");
                String lastName = resultSet.getString("LastName");
                String streetAddress = resultSet.getString("StreetAddress");
                String zipcode = resultSet.getString("Zipcode");
                String city = resultSet.getString("City");
                String country = resultSet.getString("Country");
                String phone = resultSet.getString("Phone");

                UserRole role = new UserRoleDAO().getRoleById(resultSet.getInt("roleId"));
                User user = new User(id, email, password, firstName, lastName, streetAddress, zipcode, city, country, phone);
                user.setRole(role);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return users;
    }

    public void deleteUser(int userID) {
        String sql = "DELETE FROM [Users] WHERE UserID=?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    public int getTotalUsers() {
        int totalUsers = 0;
        try {
            String query = "SELECT COUNT(*) AS totalUsers FROM [Users]";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                totalUsers = resultSet.getInt("totalUsers");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalUsers;
    }

    public String encryptPassword(String password) {
        try {
            SecretKey key = new SecretKeySpec(ENCRYPTION_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] encryptedBytes = cipher.doFinal(password.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private boolean verifyPassword(String inputPassword, String storedPassword) {
        try {
            SecretKey key = new SecretKeySpec(ENCRYPTION_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] encryptedBytes = Base64.getDecoder().decode(storedPassword);
            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            String decryptedPassword = new String(decryptedBytes);
            return inputPassword.equals(decryptedPassword);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private String decryptPassword(String storedPassword) {
        try {
            SecretKey key = new SecretKeySpec(ENCRYPTION_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] encryptedBytes = Base64.getDecoder().decode(storedPassword);
            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            String decryptedPassword = new String(decryptedBytes);
            return decryptedPassword;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
