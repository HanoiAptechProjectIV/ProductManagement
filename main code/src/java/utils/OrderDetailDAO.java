/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.OrderDetail;
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
public class OrderDetailDAO {
    public static List<OrderDetail> queryOrderDetail(Connection conn) throws SQLException {
        String sql = "Select * from OrderDetail a ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<OrderDetail> list = new ArrayList<OrderDetail>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int name = rs.getInt("user_id");
            int description = rs.getInt("product_id");
            int logo = rs.getInt("order_id");
            int manufacturer= rs.getInt("purchased_quantity");
            
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(id);
            orderDetail.setUserId(name);
            orderDetail.setProductId(description);
            orderDetail.setOrderId(logo);
            orderDetail.setPurchasedQuantity(manufacturer);
            list.add(orderDetail);
        }
        return list;
    } 
    
    public static OrderDetail findOrderDetail(Connection conn, int id) throws SQLException {
        String sql = "Select * from OrderDetail a where a.id=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, id);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            int name = rs.getInt("user_id");
            int description = rs.getInt("product_id");
            int logo = rs.getInt("order_id");
            int manufacturer= rs.getInt("purchased_quantity");
            
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(id);
            orderDetail.setUserId(name);
            orderDetail.setProductId(description);
            orderDetail.setOrderId(logo);
            orderDetail.setPurchasedQuantity(manufacturer);          
            return orderDetail;
        }
        return null;
    }

    public static void insertOrderDetail(Connection conn, OrderDetail orderDetail) throws SQLException {
        String sql = "Insert into OrderDetail(user_id, product_id , order_id , purchased_quantity ) values (?,?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, orderDetail.getUserId());
        pstm.setInt(2, orderDetail.getProductId());
        pstm.setInt(3, orderDetail.getOrderId());
        pstm.setInt(4, orderDetail.getPurchasedQuantity());
 
        pstm.executeUpdate();
    }    
    
    public static void updateOrderDetail(Connection conn, OrderDetail orderDetail) throws SQLException {
        String sql = "Update OrderDetail set user_id =?, product_id =?, order_id =?, purchased_quantity  =? where id=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, orderDetail.getUserId());
        pstm.setInt(2, orderDetail.getProductId());
        pstm.setInt(3, orderDetail.getOrderId());
        pstm.setInt(4, orderDetail.getPurchasedQuantity());      
        pstm.setInt(5, orderDetail.getId());      
        
        pstm.executeUpdate();
    }    
    
    public static void deleteOrderDetail(Connection conn, int id) throws SQLException {
        String sql = "Delete From OrderDetail where id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, id);
 
        pstm.executeUpdate();
    }                
}
