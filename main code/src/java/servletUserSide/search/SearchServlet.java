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
            response.sendRedirect(request.getContextPath() +"/cart");        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        String errorString = null;
        String returnPage="";
        List<Product> returnProd = new ArrayList<>();
        List<Category> returnCate = new ArrayList<>();
        List<Brand> returnBra = new ArrayList<>();
        try {
            String name = request.getParameter("name");
            
            List<Product> prodList = ProductDAO.queryDisplayProduct(conn);
            List<Brand> braList = BrandDAO.queryDisplayBrand(conn);
            List<Category> cateList = CategoryDAO.queryDisplayCategory(conn);
            
            for(Product prod : prodList){
                if((prod.getName().toLowerCase()).contains(name.toLowerCase())){
                    returnProd.add(prod);
                    request.setAttribute("productList", returnProd);
                    returnPage = "navigation/productsView.jsp";
                }
            }         
            for(Brand bra : braList){
                if((bra.getName().toLowerCase()).contains(name.toLowerCase())){
                    returnBra.add(bra); 
                    request.setAttribute("brandList", returnBra);
                    returnPage = "navigation/brandsView.jsp";
                }
            }
            for(Category cate : cateList){
                if((cate.getName().toLowerCase()).contains(name.toLowerCase())){
                    returnCate.add(cate);  
                    request.setAttribute("categoryList", returnCate);
                    returnPage = "navigation/categoriesView.jsp";
                }
            }
            
            if(returnProd.isEmpty() && returnBra.isEmpty() && returnCate.isEmpty()){
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
