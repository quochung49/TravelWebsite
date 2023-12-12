package DAO;

import entity.model.UserRole;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRoleDAO {

    private Connection connection;

    public UserRoleDAO() {
        this.connection = DB.DBConnect.getConn();
    }

    public UserRole getRoleById(int roleId) {
        UserRole userRole = null;
        String sql = "SELECT id, name FROM UserRoles WHERE id = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, roleId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                userRole = new UserRole(id, name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userRole;
    }
}
