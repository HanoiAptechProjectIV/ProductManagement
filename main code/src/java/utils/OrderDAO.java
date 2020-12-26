/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hung
 */
public class OrderDAO {
    public static List<Order> queryOrder(Connection conn) throws SQLException {
        String sql = "Select * from [Order] a ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Order> list = new ArrayList<Order>();
        while (rs.next()) {
            int id = rs.getInt("id");
            LocalDateTime createdTime = rs.getTimestamp("created_time").toLocalDateTime();
            LocalDateTime paymentTime = rs.getTimestamp("payment_time").toLocalDateTime();
            int amount = rs.getInt("amount");
            int userId = rs.getInt("user_id");
            
            Order order = new Order();
            order.setId(id);
            order.setCreatedTime(createdTime);
            order.setPaymentTime(paymentTime);
            order.setAmount(amount);
            order.setUserId(userId);
            list.add(order);
        }
        return list;
    } 
    
    public static Order findOrder(Connection conn, int id) throws SQLException {
        String sql = "Select * from [Order] a where a.id=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, id);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            LocalDateTime createdTime = rs.getTimestamp("created_time").toLocalDateTime();
            LocalDateTime paymentTime = rs.getTimestamp("payment_time").toLocalDateTime();
            int amount = rs.getInt("amount");
            int userId = rs.getInt("user_id");
            
            Order order = new Order();
            order.setId(id);
            order.setCreatedTime(createdTime);
            order.setPaymentTime(paymentTime);
            order.setAmount(amount);
            order.setUserId(userId);
            return order;
        }
        return null;
    }

    public static void insertOrder(Connection conn, Order order) throws SQLException {
        String sql = "Insert into [Order](created_time, payment_time, amount, user_id) values (?,?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        java.sql.Date createdTime = java.sql.Date.valueOf(order.getCreatedTime().toLocalDate());
        java.sql.Date paymentTime = java.sql.Date.valueOf(order.getPaymentTime().toLocalDate());
 
        pstm.setDate(1, createdTime);
        pstm.setDate(2, paymentTime);
        pstm.setInt(3, order.getAmount());
        pstm.setInt(4, order.getUserId());
 
        pstm.executeUpdate();
    }    
    
    public static void updateOrder(Connection conn, Order order) throws SQLException {
        String sql = "Update [Order] set created_time =?, amount =?, user_id =?, payment_time =? where id=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        java.sql.Date createdTime = java.sql.Date.valueOf(order.getCreatedTime().toLocalDate());
        java.sql.Date paymentTime = java.sql.Date.valueOf(order.getPaymentTime().toLocalDate());
        
        pstm.setDate(1, createdTime);
        pstm.setInt(2, order.getAmount());
        pstm.setInt(3, order.getUserId());
        pstm.setDate(4, paymentTime);
        pstm.setInt(5, order.getId());
        
        pstm.executeUpdate();
    }    
    
    public static void deleteOrder(Connection conn, int id) throws SQLException {
        String sql = "Delete From [Order] where id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, id);
 
        pstm.executeUpdate();
    }    
}
