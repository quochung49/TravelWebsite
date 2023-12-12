package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private static Connection conn;

    private DBConnect() {
    }

    public static synchronized Connection getConn() {
        if (conn == null) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection("jdbc:sqlserver://ADMIN-PC\\\\QUOCHUNG:1433;databaseName=BookStore", "sa", "123456");
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle or log the exception properly
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
                // Handle or log the exception properly
            }
        }
        return conn;
    }

    public static synchronized void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle or log the exception properly
            } finally {
                conn = null;
            }
        }
    }
}
