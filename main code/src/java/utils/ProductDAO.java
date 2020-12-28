/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author Hung
 */
import beans.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
public class ProductDAO {
    
    public static List<Product> queryProduct(Connection conn) throws SQLException {
        String sql = "Select * from Product a ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Product> list = new ArrayList<Product>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String description = rs.getString("description");
            int price = rs.getInt("price");
            int quantity = rs.getInt("quantity");
            String image = rs.getString("image");
            LocalDate dateAdded = rs.getDate("date_added").toLocalDate();
            int categoryId = rs.getInt("category_id");
            int brandId = rs.getInt("brand_id");
            boolean disable = rs.getBoolean("disable");
            
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setImage(image);
            product.setDateAdded(dateAdded);
            product.setCategoryId(categoryId);
            product.setBrandId(brandId);
            product.setDisable(disable);
            list.add(product);
        }
        return list;
    } 
    
    public static Product findProduct(Connection conn, int id) throws SQLException {
        String sql = "Select * from Product a where a.id=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, id);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            String name = rs.getString("name");
            String description = rs.getString("description");
            int price = rs.getInt("price");
            int quantity = rs.getInt("quantity");
            String image = rs.getString("image");
            LocalDate dateAdded = rs.getDate("date_added").toLocalDate();
            int categoryId = rs.getInt("category_id");
            int brandId = rs.getInt("brand_id");
            boolean disable = rs.getBoolean("disable");
            
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setImage(image);
            product.setDateAdded(dateAdded);
            product.setCategoryId(categoryId);
            product.setBrandId(brandId);
            product.setDisable(disable);
            return product;
        }
        return null;
    }

    public static void insertProduct(Connection conn, Product product) throws SQLException {
        String sql = "Insert into Product(name, description, price, quantity, image"
                + ", date_added, category_id, brand_id) values (?,?,?,?,?,?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        java.sql.Date dateAdded = java.sql.Date.valueOf(product.getDateAdded());
        pstm.setString(1, product.getName());
        pstm.setString(2, product.getDescription());
        pstm.setInt(3, product.getPrice());
        pstm.setInt(4, product.getQuantity());
        pstm.setString(5, product.getImage());
        pstm.setDate(6, dateAdded);
        pstm.setInt(7, product.getCategoryId());
        pstm.setInt(8, product.getBrandId());
 
        pstm.executeUpdate();
    }  
       

    public static void updateProduct(Connection conn, Product product) throws SQLException {
        String sql = "Update Product set name =?, description =?, price=?, quantity =?, image=?"
                + ", date_added =?, category_id=?, brand_id =?, disable=? where id=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        java.sql.Date dateAdded = java.sql.Date.valueOf(product.getDateAdded());
 
        pstm.setInt(10, product.getId());
        pstm.setString(1, product.getName());
        pstm.setString(2, product.getDescription());
        pstm.setInt(3, product.getPrice());
        pstm.setInt(4, product.getQuantity());
        pstm.setString(5, product.getImage());
        pstm.setDate(6, dateAdded);
        pstm.setInt(7, product.getCategoryId());
        pstm.setInt(8, product.getBrandId());
        pstm.setBoolean(9, product.isDisable());
        
        pstm.executeUpdate();
    }         
    
    public static void deleteProduct(Connection conn, int id) throws SQLException {
        String sql = "Delete From Product where id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, id);
 
        pstm.executeUpdate();
    }    

    public static void deleteProductByBrandId(Connection conn, int brandId) throws SQLException {
        String sql = "Delete From Product where brand_id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, brandId);
 
        pstm.executeUpdate();
    } 
    
    public static void deleteProductByCategoryId(Connection conn, int categoryId) throws SQLException {
        String sql = "Delete From Product where category_id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, categoryId);
 
        pstm.executeUpdate();
    }    
}
