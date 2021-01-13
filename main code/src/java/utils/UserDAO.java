/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.User;
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
public class UserDAO {
    public static int countRows(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) As [rowcount] FROM [User]";
        PreparedStatement pstm = conn.prepareStatement(sql);
        ResultSet rs = pstm.executeQuery();
        
        int row = 0;
        while(rs.next()){
            row = rs.getInt("rowcount");
        }
        return row;
    }
    
    public static List<User> queryUser(Connection conn, int offset, int total, String sortBy, String ordinal) throws SQLException {
        String sql = "Select * from [User] order by "+sortBy+" "+ordinal+" offset "+offset+" rows fetch next "+total+" rows only";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<User> list = new ArrayList<User>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String password = rs.getString("password");
            String name = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String phone = rs.getString("phone");
            String email = rs.getString("email");
            String address = rs.getString("address");
            
            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setGender(gender);
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            list.add(user);
        }
        return list;
    } 
    
    public static User findUser(Connection conn, int id) throws SQLException {
        String sql = "Select * from [User] a where a.id=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, id);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            String username = rs.getString("username");
            String password = rs.getString("password");
            String name = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String phone = rs.getString("phone");
            String email = rs.getString("email");
            String address = rs.getString("address");
            
            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setGender(gender);
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            return user;
        }
        return null;
    }
    
    public static User findUser(Connection conn, String username) throws SQLException {
        String sql = "Select * from [User] a where a.username=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, username);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            int id = rs.getInt("id");
            String password = rs.getString("password");
            String name = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String phone = rs.getString("phone");
            String email = rs.getString("email");
            String address = rs.getString("address");
            
            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setGender(gender);
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            return user;
        }
        return null;
    } 

    public static User findUserByName(Connection conn, String name) throws SQLException {
        String sql = "Select * from [User] a where a.name=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, name);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            int id = rs.getInt("id");
            String password = rs.getString("password");
            String username = rs.getString("username");
            boolean gender = rs.getBoolean("gender");
            String phone = rs.getString("phone");
            String email = rs.getString("email");
            String address = rs.getString("address");
            
            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setGender(gender);
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            return user;
        }
        return null;
    } 
    
    public static User findUser(Connection conn, String username, String password) throws SQLException {
        String sql = "Select * from [User] a where a.username=? and a.password=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, username);
        pstm.setString(2, password);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String phone = rs.getString("phone");
            String email = rs.getString("email");
            String address = rs.getString("address");
            
            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setGender(gender);
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            return user;
        }
        return null;
    }    

    public static void insertUser(Connection conn, User user) throws SQLException {
        String sql = "Insert into [User](username, password, name, gender, phone, email,"
                + "address) values (?,?,?,?,?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, user.getUsername());
        pstm.setString(2, user.getPassword());
        pstm.setString(3, user.getName());
        pstm.setBoolean(4, user.isGender());
        pstm.setString(5, user.getPhone());
        pstm.setString(6, user.getEmail());
        pstm.setString(7, user.getAddress());
 
        pstm.executeUpdate();
    }    
    
    public static void updateUser(Connection conn, User user) throws SQLException {
        String sql = "Update [User] set username=?, password=?, name =?, gender=?, phone=?, email=?, address =? where id=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, user.getUsername());
        pstm.setString(2, user.getPassword());
        pstm.setString(3, user.getName());
        pstm.setBoolean(4, user.isGender());
        pstm.setString(5, user.getPhone());
        pstm.setString(6, user.getEmail());
        pstm.setString(7, user.getAddress());
        pstm.setInt(8, user.getId());
        
        pstm.executeUpdate();
    }    
    
    public static void deleteUser(Connection conn, int id) throws SQLException {
        String sql = "Delete From [User] where id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, id);
 
        pstm.executeUpdate();
    }    
}
