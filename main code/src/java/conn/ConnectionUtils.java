/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtils {
 
    // Kết nối vào SQL Server.
    // (Sử dụng thư viện SQLJDBC)
    public static Connection getConnection() //
            throws ClassNotFoundException, SQLException {
 
        // Chú ý: Thay đổi các thông số kết nối cho phù hợp.
        String hostName = "localhost";
        String sqlInstanceName = "";
        String database = "ProductManagement";
        String username = "sa";
        String password = "sana";
 
        return getConnection(hostName, sqlInstanceName, database, username, password);
    }
 
    // Kết nối tới SQLServer, sử dụng thư viện SQLJDBC.
    private static Connection getConnection(String hostName, //
            String sqlInstanceName, String database, String username, String password)//
            throws ClassNotFoundException, SQLException {
 
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
 
        // Cấu trúc URL Connection dành cho SQLServer
        // Ví dụ:
        // jdbc:sqlserver://ServerIp:1433/SQLEXPRESS;databaseName=simplehr
        String connectionURL = "jdbc:sqlserver://" + hostName + ":1042" //
                + ";instance=" + sqlInstanceName + ";databaseName=" + database;
 
        Connection conn = DriverManager.getConnection(connectionURL, username, password);
        return conn;
    }
    
    public static void closeQuietly(Connection conn) {
        try {
            conn.close();
        } catch (Exception e) {
        }
    }
 
    public static void rollbackQuietly(Connection conn) {
        try {
            conn.rollback();
        } catch (Exception e) {
        }
    }    
     
}
