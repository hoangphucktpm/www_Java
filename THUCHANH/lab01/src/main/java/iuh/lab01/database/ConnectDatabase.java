package iuh.lab01.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDatabase {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=iuh_lab01_db;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "12345678";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Kết nối cơ sở dữ liệu thành công!");
        } catch (ClassNotFoundException e) {
            System.out.println("Không tìm thấy driver JDBC!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối cơ sở dữ liệu!");
            e.printStackTrace();
        }
        return connection;
    }
}
