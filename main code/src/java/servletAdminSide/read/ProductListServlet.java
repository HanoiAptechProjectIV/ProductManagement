/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletAdminSide.read;

/**
 *
 * @author Hung
 */
import beans.Brand;
import beans.Category;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Product;
import java.util.ArrayList;
import utils.BrandDAO;
import utils.CategoryDAO;
import utils.ProductDAO;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/admin/productList"})
public class ProductListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ProductListServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        String errorString = null;
        String name = request.getParameter("search");
        List<Product> list = new ArrayList<Product>();
        String sortBy = (request.getParameter("sortBy") != null) ? request.getParameter("sortBy") : "nameASC";
        try {
            int rowInTable = 0;
            int rowInPage = 3;
            int pageQuantity = 1;
            int pageNum = (request.getParameter("page") != null)
                    ? Integer.parseInt(request.getParameter("page"))
                    : 1;
            pageNum = (pageNum < 1) ? 1 : pageNum;

            String ordinal = (sortBy.contains("ASC")) ? "ASC" : "DESC";
            String abridgedSortBy = sortBy.substring(0, sortBy.lastIndexOf(ordinal));

            if (name != null) {
                Product product = ProductDAO.findProductByName(conn, name);
                if (product != null) {
                    list.add(product);
                }
            } else {
                rowInTable = ProductDAO.countRows(conn);
                pageQuantity = (rowInTable % rowInPage == 0) ? rowInTable / rowInPage : rowInTable / rowInPage + 1;
                pageNum = (pageNum > pageQuantity) ? pageQuantity : pageNum;
                int offset = (pageNum - 1) * rowInPage;

                list = ProductDAO.queryProduct(conn, offset, rowInPage, abridgedSortBy, ordinal);
                request.setAttribute("pageQuantity", pageQuantity);
                request.setAttribute("page", pageNum);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {

            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("productList", list);
            request.setAttribute("sortBy", sortBy);

            // Forward sang /WEB-INF/adminViews/productListView.jsp
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/adminViews/CRUD/read/productListView.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
