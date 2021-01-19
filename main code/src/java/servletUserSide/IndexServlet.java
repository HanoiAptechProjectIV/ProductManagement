/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletUserSide;

/**
 *
 * @author Hung
 */
import beans.Product;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MyUtils;
import utils.OrderDetailDAO;
import utils.ProductDAO;

@WebServlet(urlPatterns = {"/index", "/home"})
public class IndexServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public IndexServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        List<Product> bestSellers = new ArrayList<>();
        List<Product> lastestProducts = new ArrayList<>();
        Map<String, List<Product>> returnedListsMap = new LinkedHashMap<>();
        String errorString = null;
        try {
            Map<Product, Integer> productPurQuanMap = OrderDetailDAO.bestSellerMap(conn);
            int count =0;
            for (Map.Entry<Product, Integer> entry : productPurQuanMap.entrySet())  {
                bestSellers.add(entry.getKey());
                count++;
                if (count == 8) break;
            }
            lastestProducts = ProductDAO.queryProduct(conn, 0, 8, "date_added", "DESC");
            
            returnedListsMap.put("Best seller", bestSellers);
            returnedListsMap.put("Lastest ", lastestProducts);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = ex.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("lists", returnedListsMap);
            
            // Forward toi trang /WEB-INF/userViews/homeView.jsp
            // (Người dùng không bao giờ truy cập trực tiếp được vào các trang JSP
            // đặt trong WEB-INF)
            RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/userViews/index.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
