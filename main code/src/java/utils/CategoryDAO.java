/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.Category;
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
public class CategoryDAO {
    public static int countRows(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) As [rowcount] FROM Category";
        PreparedStatement pstm = conn.prepareStatement(sql);
        ResultSet rs = pstm.executeQuery();
        
        int row = 0;
        while(rs.next()){
            row = rs.getInt("rowcount");
        }
        return row;
    }
    
    public static List<Category> queryCategory(Connection conn) throws SQLException {
        String sql = "Select * from Category order by name";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Category> list = new ArrayList<Category>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String description = rs.getString("description");
            boolean disable = rs.getBoolean("disable");
            
            Category category = new Category();
            category.setId(id);
            category.setName(name);
            category.setDescription(description);
            category.setDisable(disable);
            list.add(category);
        }
        return list;
    } 
    
    public static List<Category> queryCategory(Connection conn, int offset, int total, String sortBy, String ordinal) throws SQLException {
        String sql = "Select * from Category order by "+sortBy+" "+ordinal+" offset "+offset+" rows fetch next "+total+" rows only";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Category> list = new ArrayList<Category>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String description = rs.getString("description");
            boolean disable = rs.getBoolean("disable");
            
            Category category = new Category();
            category.setId(id);
            category.setName(name);
            category.setDescription(description);
            category.setDisable(disable);
            list.add(category);
        }
        return list;
    } 
    
    public static Category findCategory(Connection conn, int id) throws SQLException {
        String sql = "Select * from Category a where a.id=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, id);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            String name = rs.getString("name");
            String description = rs.getString("description");
            boolean disable = rs.getBoolean("disable");
            
            Category category = new Category();
            category.setId(id);
            category.setName(name);
            category.setDescription(description);
            category.setDisable(disable);
            return category;
        }
        return null;
    }

    public static Category findCategoryByName(Connection conn, String name) throws SQLException {
        String sql = "Select * from Category a where a.name=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, name);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            int id = rs.getInt("id");
            String description = rs.getString("description");
            boolean disable = rs.getBoolean("disable");
            
            Category category = new Category();
            category.setId(id);
            category.setName(name);
            category.setDescription(description);
            category.setDisable(disable);
            return category;
        }
        return null;
    }

    public static void insertCategory(Connection conn, Category category) throws SQLException {
        String sql = "Insert into Category(name, description) values (?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, category.getName());
        pstm.setString(2, category.getDescription());
 
        pstm.executeUpdate();
    }    
    
    public static void updateCategory(Connection conn, Category category) throws SQLException {
        String sql = "Update Category set name =?, description =?, disable=? where id=? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(4, category.getId());
        pstm.setString(1, category.getName());
        pstm.setString(2, category.getDescription());
        pstm.setBoolean(3, category.isDisable());
        pstm.executeUpdate();
    }    
    
    public static void deleteCategory(Connection conn, int id) throws SQLException {
        String sql = "Delete From Category where id= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, id);
 
        pstm.executeUpdate();
    }        
}
