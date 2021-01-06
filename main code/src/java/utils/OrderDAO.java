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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hung
 */
public class OrderDAO {

    public static int countRows(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) As [rowcount] FROM [Order]";
        PreparedStatement pstm = conn.prepareStatement(sql);
        ResultSet rs = pstm.executeQuery();

        int row = 0;
        while (rs.next()) {
            row = rs.getInt("rowcount");
        }
        return row;
    }

    public static List<Order> queryOrder(Connection conn, int offset, int total) throws SQLException {
        String sql = "Select * from [Order] order by [user_id] ASC, id ASC offset " + offset + " rows fetch next " + total + " rows only";

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
        String sql = "Select * from [Order] a where a.id=? ";

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

    public static List<Order> findOrderByUserId(Connection conn, int userId) throws SQLException {
        String sql = "Select * from [Order] a where a.[user_id]=? order by id ASC";

        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, userId);

        ResultSet rs = pstm.executeQuery();
        List<Order> list = new ArrayList<Order>();
        while (rs.next()) {
            LocalDateTime createdTime = rs.getTimestamp("created_time").toLocalDateTime();
            LocalDateTime paymentTime = rs.getTimestamp("payment_time").toLocalDateTime();
            int amount = rs.getInt("amount");
            int id = rs.getInt("id");

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

    public static void insertOrder(Connection conn, Order order) throws SQLException {
        String sql = "Insert into [Order](created_time, payment_time, amount, user_id) values (?,?,?,?)";
        String sql2 = "Insert into [Order](created_time, amount, user_id) values (?,?,?)";

        LocalDateTime cTime = order.getCreatedTime();
        LocalDateTime pTime = order.getPaymentTime();
        java.util.Date cDate;
        java.util.Date pDate;
        String dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern(dateFormat);
        SimpleDateFormat sdf1 = new SimpleDateFormat(dateFormat);
        try {
            cDate = sdf1.parse(cTime.format(dtf1));
            pDate = sdf1.parse(pTime.format(dtf1));
        } catch (ParseException e) {
            cDate = null;
            pDate = null;
        }
        java.sql.Timestamp createdTime = new java.sql.Timestamp(cDate.getTime());
        java.sql.Timestamp paymentTime = new java.sql.Timestamp(pDate.getTime());

        LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
        PreparedStatement pstm = null;
        if (!pTime.equals(ldt)) { 
        pstm = conn.prepareStatement(sql);
        pstm.setTimestamp(1, createdTime);
        pstm.setTimestamp(2, paymentTime);
        pstm.setInt(3, order.getAmount());
        pstm.setInt(4, order.getUserId());
        } else {
        pstm = conn.prepareStatement(sql2);
        pstm.setTimestamp(1, createdTime);
        pstm.setInt(2, order.getAmount());
        pstm.setInt(3, order.getUserId());
        }

        pstm.executeUpdate();
    }

    public static void updateOrder(Connection conn, Order order) throws SQLException {
        String sql = "Update [Order] set created_time =?, amount =?, user_id =?, payment_time =? where id=? ";
        String sql2 = "Update [Order] set created_time =?, amount =?, user_id =? where id=? ";

        LocalDateTime cTime = order.getCreatedTime();
        LocalDateTime pTime = order.getPaymentTime();
        java.util.Date cDate;
        java.util.Date pDate;
        String dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern(dateFormat);
        SimpleDateFormat sdf1 = new SimpleDateFormat(dateFormat);
        try {
            cDate = sdf1.parse(cTime.format(dtf1));
            pDate = sdf1.parse(pTime.format(dtf1));
        } catch (ParseException e) {
            cDate = null;
            pDate = null;
        }
        java.sql.Timestamp createdTime = new java.sql.Timestamp(cDate.getTime());
        java.sql.Timestamp paymentTime = new java.sql.Timestamp(pDate.getTime());
        System.out.println(createdTime.toString());
        System.out.println(paymentTime.toString());
        System.out.println(cTime.toString());
        System.out.println(pTime.toString());
        System.out.println(cDate.toString());
        System.out.println(pDate.toString());

        LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
        PreparedStatement pstm = null;
        if (!pTime.equals(ldt)) {
            pstm = conn.prepareStatement(sql);
            pstm.setTimestamp(1, createdTime);
            pstm.setInt(2, order.getAmount());
            pstm.setInt(3, order.getUserId());
            pstm.setTimestamp(4, paymentTime);
            pstm.setInt(5, order.getId());
        } else {
            pstm = conn.prepareStatement(sql2);
            pstm.setTimestamp(1, createdTime);
            pstm.setInt(2, order.getAmount());
            pstm.setInt(3, order.getUserId());
            pstm.setInt(4, order.getId());
        }

        pstm.executeUpdate();
    }

    public static void deleteOrder(Connection conn, int id) throws SQLException {
        String sql = "Delete From [Order] where id= ?";

        PreparedStatement pstm = conn.prepareStatement(sql);

        pstm.setInt(1, id);

        pstm.executeUpdate();
    }
}
