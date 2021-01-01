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
import java.util.ArrayList;
import utils.MyUtils;
import utils.BrandDAO;

@WebServlet(urlPatterns = {"/brandList"})
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
            int rowInTable = 0;
            int rowInPage = 2;
            int pageQuantity = 1;
            int pageNum = (request.getParameter("page") != null)
                    ? Integer.parseInt(request.getParameter("page"))
                    : 1;
            pageNum = (pageNum < 1) ? 1 : pageNum;

            if (name != null) {
                list.add(BrandDAO.findBrandByName(conn, name));
            } else {
                rowInTable = BrandDAO.countRows(conn);
                pageQuantity = (rowInTable % 2 == 0) ? rowInTable / 2 : rowInTable / 2 + 1;
                pageNum = (pageNum > pageQuantity) ? pageQuantity : pageNum;
                int offset = (pageNum - 1) * rowInPage;
                list = BrandDAO.queryBrand(conn, offset, rowInPage);

                request.setAttribute("pageQuantity", pageQuantity);
                request.setAttribute("page", pageNum);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } catch (NullPointerException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } catch (NumberFormatException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("brandList", list);

            // Forward sang /WEB-INF/views/brandListView.jsp
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/read/brandListView.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
