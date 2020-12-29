/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.read;

/**
 *
 * @author Hung
 */
import beans.Admin;
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
 
import beans.Category;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import utils.MyUtils;
import utils.CategoryDAO;
 
@WebServlet(urlPatterns = { "/categoryList" })
public class CategoryListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public CategoryListServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection conn = MyUtils.getStoredConnection(request);
 
        String errorString = null;
        String name = request.getParameter("search");
        List<Category> list = new ArrayList<Category>();
        try {
            if (name != null) {
                list.add(CategoryDAO.findCategoryByName(conn, name));
            } else {
                list = CategoryDAO.queryCategory(conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        }
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("categoryList", list);
         
        // Forward sang /WEB-INF/views/categoryListView.jsp
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/read/categoryListView.jsp");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
