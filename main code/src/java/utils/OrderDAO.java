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
import java.time.LocalDate;
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
            LocalDate createdDay = rs.getDate("created_day").toLocalDate();
            int amount = rs.getInt("amount");
            
            Order order = new Order();
            order.setId(id);
            order.setCreatedDay(createdDay);
            order.setAmount(amount);
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
            LocalDate createdDay = rs.getDate("created_day").toLocalDate();
            int amount = rs.getInt("amount");
            
            Order order = new Order();
            order.setId(id);
            order.setCreatedDay(createdDay);
            order.setAmount(amount);
            return order;
        }
        return null;
    }

    public static void insertOrder(Connection conn, Order order) throws SQLException {
        String sql = "Insert into [Order](create_day, amount) values (?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        java.sql.Date createDay = java.sql.Date.valueOf(order.getCreatedDay());
 
        pstm.setDate(1, createDay);
        pstm.setInt(2, order.getAmount());
 
        pstm.executeUpdate();
    }    
    
    public static void updateOrder(Connection conn, Order order) throws SQLException {
        String sql = "Update [Order] set create_day =?, amount =? where id=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        java.sql.Date createDay = java.sql.Date.valueOf(order.getCreatedDay());
 
        pstm.setDate(1, createDay);
        pstm.setInt(2, order.getAmount());
        pstm.setInt(3, order.getId());
        
        pstm.executeUpdate();
    }    
    
    public static void deleteOrder(Connection conn, int id) throws SQLException {
        String sql = "Delete From [Order] where id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, id);
 
        pstm.executeUpdate();
    }    
}
