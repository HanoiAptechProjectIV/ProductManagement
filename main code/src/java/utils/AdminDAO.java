/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;
import beans.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hung
 */
public class AdminDAO {
    public static List<Admin> queryAdmin(Connection conn) throws SQLException {
        String sql = "Select * from Admin a ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Admin> list = new ArrayList<Admin>();
        while (rs.next()) {
            String username = rs.getString("username");
            String password = rs.getString("password");
            
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setPassword(password);
            list.add(admin);
        }
        return list;
    } 
    
    public static Admin findAdmin(Connection conn, String username) throws SQLException {
        String sql = "Select * from Admin a where a.username=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, username);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            
            Admin admin = new Admin();
            admin.setUsername(username);
            return admin;
        }
        return null;
    }
    
    public static Admin findAdmin(Connection conn, String username, String password) throws SQLException {
        String sql = "Select * from Admin a where a.username=? and a.password=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, username);
        pstm.setString(2, password);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setPassword(password);
            return admin;
        }
        return null;
    }
    
    public static void insertAdmin(Connection conn, Admin admin) throws SQLException {
        String sql = "Insert into Admin(username, password) values (?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, admin.getUsername());
        pstm.setString(2, admin.getPassword());
 
        pstm.executeUpdate();
    }    
    
    public static void updateAdmin(Connection conn, Admin admin) throws SQLException {
        String sql = "Update Admin set password =? where username=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, admin.getPassword());
        pstm.setString(2, admin.getUsername());
        
        pstm.executeUpdate();
    }    
    
    public static void deleteAdmin(Connection conn, String username) throws SQLException {
        String sql = "Delete From Admin where username= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, username);
 
        pstm.executeUpdate();
    } 
}
