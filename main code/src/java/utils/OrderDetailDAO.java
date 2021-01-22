/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.OrderDetail;
import beans.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 *
 * @author Hung
 */
public class OrderDetailDAO {

    public static Map<Product, Integer> bestSellerMap(Connection conn) throws SQLException {
        String sql = "Select * from OrderDetail a ";
        PreparedStatement pstm = conn.prepareStatement(sql);
        ResultSet rs = pstm.executeQuery();
        List<OrderDetail> list = new ArrayList<>();
        Map<Integer, Integer> prodPurQuan = new LinkedHashMap<>();
        Product product = null;
        while (rs.next()) {
            int id = rs.getInt("id");
            String status = rs.getString("status");
            int productId = rs.getInt("product_id");
            int orderId = rs.getInt("order_id");
            int purchasedQuantity = rs.getInt("purchased_quantity");

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(id);
            orderDetail.setStatus(status);
            orderDetail.setProductId(productId);
            orderDetail.setOrderId(orderId);
            orderDetail.setPurchasedQuantity(purchasedQuantity);
            list.add(orderDetail);
        }

        for (OrderDetail detail : list) {
            product = ProductDAO.findProduct(conn, detail.getProductId());
            if (!product.isDisable()) {
                if (prodPurQuan.containsKey(product.getId())) {
                    prodPurQuan.put(product.getId(), prodPurQuan.get(product.getId()) + detail.getPurchasedQuantity());
                } else {
                    prodPurQuan.put(product.getId(), detail.getPurchasedQuantity());
                }
            }
        }

        List<Entry<Integer, Integer>> sortList = new ArrayList<Entry<Integer, Integer>>(prodPurQuan.entrySet());
        Collections.sort(sortList, new Comparator<Entry<Integer, Integer>>() {
            @Override
            public int compare(Entry<Integer, Integer> o1, Entry<Integer, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });

        Map<Product, Integer> bestSeller = new LinkedHashMap<Product, Integer>();
        for (Entry<Integer, Integer> entry : sortList) {
            product = ProductDAO.findProduct(conn, entry.getKey());
            bestSeller.put(product, entry.getValue());
        }

        return bestSeller;
    }

    public static int countRowsByOrderId(Connection conn, int orderId) throws SQLException {
        String sql = "SELECT COUNT(*) As [rowcount] FROM OrderDetail where order_id =?";
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, orderId);
        ResultSet rs = pstm.executeQuery();

        int row = 0;
        while (rs.next()) {
            row = rs.getInt("rowcount");
        }
        return row;
    }

    public static List<OrderDetail> queryOrderDetail(Connection conn) throws SQLException {
        String sql = "Select * from OrderDetail a ";

        PreparedStatement pstm = conn.prepareStatement(sql);

        ResultSet rs = pstm.executeQuery();
        List<OrderDetail> list = new ArrayList<OrderDetail>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String status = rs.getString("status");
            int productId = rs.getInt("product_id");
            int orderId = rs.getInt("order_id");
            int purchasedQuantity = rs.getInt("purchased_quantity");

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(id);
            orderDetail.setStatus(status);
            orderDetail.setProductId(productId);
            orderDetail.setOrderId(orderId);
            orderDetail.setPurchasedQuantity(purchasedQuantity);
            list.add(orderDetail);
        }
        return list;
    }

    public static OrderDetail findOrderDetail(Connection conn, int id) throws SQLException {
        String sql = "Select * from OrderDetail a where a.id=? ";

        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, id);

        ResultSet rs = pstm.executeQuery();

        while (rs.next()) {
            String status = rs.getString("status");
            int productId = rs.getInt("product_id");
            int orderId = rs.getInt("order_id");
            int purchasedQuantity = rs.getInt("purchased_quantity");

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(id);
            orderDetail.setStatus(status);
            orderDetail.setProductId(productId);
            orderDetail.setOrderId(orderId);
            orderDetail.setPurchasedQuantity(purchasedQuantity);
            return orderDetail;
        }
        return null;
    }

    public static List<OrderDetail> findOrderDetailList(Connection conn, int orderId, String sortBy, String ordinal) throws SQLException {
        String sql = "Select * from OrderDetail a where a.order_id=? "
                + "order by " + sortBy + " " + ordinal;

        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, orderId);

        ResultSet rs = pstm.executeQuery();
        List<OrderDetail> list = new ArrayList<OrderDetail>();

        while (rs.next()) {
            int id = rs.getInt("id");
            String status = rs.getString("status");
            int productId = rs.getInt("product_id");
            int purchasedQuantity = rs.getInt("purchased_quantity");

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(id);
            orderDetail.setStatus(status);
            orderDetail.setProductId(productId);
            orderDetail.setOrderId(orderId);
            orderDetail.setPurchasedQuantity(purchasedQuantity);
            list.add(orderDetail);
        }
        return list;
    }

    public static void insertOrderDetail(Connection conn, OrderDetail orderDetail) throws SQLException {
        String sql = "Insert into OrderDetail(status, product_id , order_id , purchased_quantity ) values (?,?,?,?)";

        PreparedStatement pstm = conn.prepareStatement(sql);

        pstm.setString(1, orderDetail.getStatus());
        pstm.setInt(2, orderDetail.getProductId());
        pstm.setInt(3, orderDetail.getOrderId());
        pstm.setInt(4, orderDetail.getPurchasedQuantity());

        pstm.executeUpdate();
    }

    public static void updateOrderDetail(Connection conn, OrderDetail orderDetail) throws SQLException {
        String sql = "Update OrderDetail set status =?, product_id =?, purchased_quantity =? where id = ? ";

        PreparedStatement pstm = conn.prepareStatement(sql);

        pstm.setString(1, orderDetail.getStatus());
        pstm.setInt(2, orderDetail.getProductId());
        pstm.setInt(3, orderDetail.getPurchasedQuantity());
        pstm.setInt(4, orderDetail.getId());

        pstm.executeUpdate();
    }

    public static void deleteOrderDetail(Connection conn, int id) throws SQLException {
        String sql = "Delete From OrderDetail where id= ?";

        PreparedStatement pstm = conn.prepareStatement(sql);

        pstm.setInt(1, id);

        pstm.executeUpdate();
    }

    public static void deleteOrderDetailByOrderId(Connection conn, int orderId) throws SQLException {
        String sql = "Delete From OrderDetail where order_id= ?";

        PreparedStatement pstm = conn.prepareStatement(sql);

        pstm.setInt(1, orderId);

        pstm.executeUpdate();
    }
}
