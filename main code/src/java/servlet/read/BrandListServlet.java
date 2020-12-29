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
 
import beans.Brand;
import beans.Brand;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import utils.BrandDAO;
import utils.MyUtils;
import utils.BrandDAO;
 
@WebServlet(urlPatterns = { "/brandList" })
public class BrandListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public BrandListServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection conn = MyUtils.getStoredConnection(request);
 
        String errorString = null;
        String name = request.getParameter("search");
        List<Brand> list = new ArrayList<Brand>();
        try {
            if (name != null) {
                list.add(BrandDAO.findBrandByName(conn, name));
            } else {
                list = BrandDAO.queryBrand(conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        }
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("brandList", list);
         
        // Forward sang /WEB-INF/views/brandListView.jsp
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/read/brandListView.jsp");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
