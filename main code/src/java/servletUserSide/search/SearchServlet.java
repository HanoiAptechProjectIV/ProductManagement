/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletUserSide.search;

/**
 *
 * @author Hung
 */

import beans.Brand;
import beans.Category;
import beans.Product;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.BrandDAO;
import utils.CategoryDAO;
import utils.MyUtils;
import utils.ProductDAO;

@WebServlet(urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public SearchServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/userViews/index.jsp");
        dispatcher.forward(request, response);        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        String errorString = null;
        String returnPage="";
        List<Product> returnProd = null;
        List<Category> returnCate = null;
        List<Brand> returnBra = null;
        try {
            String name = request.getParameter("name");
            
            List<Product> prodList = ProductDAO.queryProduct(conn);
            List<Brand> braList = BrandDAO.queryBrand(conn);
            List<Category> cateList = CategoryDAO.queryCategory(conn);
            Product product = null;
            Brand brand = null;
            Category category = null;
            
            for(Product prod : prodList){
                if(prod.getName().equals(name)){
                    product = prod;
                }
            }         
            for(Brand bra : braList){
                if(bra.getName().equals(name)){
                    brand = bra;
                }
            }
            for(Category cate : cateList){
                if(cate.getName().equals(name)){
                    category = cate;
                }
            }
    
            if(product != null){
                returnPage = "detail/productDetailView.jsp";
                returnProd = new ArrayList<>();
                returnProd.add(product);
                request.setAttribute("productList", returnProd);
            } else if(brand != null){
                returnPage = "detail/brandDetailView.jsp";
                returnBra = new ArrayList<>();
                returnBra.add(brand); 
                request.setAttribute("brandList", returnBra);
            } else if(category != null){
                returnPage = "detail/categoryDetailView.jsp";
                returnCate = new ArrayList<>();
                returnCate.add(category);  
                request.setAttribute("categoryList", returnCate);
            } else {
                returnPage = "detail/notFoundView.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            
            // Forward sang /WEB-INF/adminViews/categoryListView.jsp
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/userViews/"+returnPage);
            dispatcher.forward(request, response);
        }        
    }

}
