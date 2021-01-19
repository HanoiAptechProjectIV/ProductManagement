/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletAdminSide.update;

/**
 *
 * @author Hung
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Category;
import utils.CategoryDAO;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/admin/editCategory"})
public class EditCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public EditCategoryServlet() {
        super();
    }

    // Hiển thị trang sửa sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        Category category = null;

        String errorString = null;

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            category = CategoryDAO.findCategory(conn, id);
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {

            // Không có lỗi.
            // Sản phẩm không tồn tại để edit.
            // Redirect sang trang danh sách sản phẩm.
            if (errorString != null && category == null) {
                response.sendRedirect(request.getServletPath() + "/categoryList");
                return;
            }

            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("category", category);

            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/adminViews/CRUD/update/editCategoryView.jsp");
            dispatcher.forward(request, response);
        }

    }

    // Sau khi người dùng sửa đổi thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        Category category = null;
        String name = (String) request.getParameter("name");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String description = request.getParameter("description");
            boolean disable = Boolean.parseBoolean(request.getParameter("disableOption"));

            category = new Category(id, name, description, disable);

            CategoryDAO.updateCategory(conn, category);
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("category", category);

            // Nếu có lỗi forward sang trang edit.
            if (errorString != null) {
                RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher("/WEB-INF/adminViews/CRUD/update/editCategoryView.jsp");
                dispatcher.forward(request, response);
            } // Nếu mọi thứ tốt đẹp.
            // Redirect sang trang danh sách sản phẩm.
            else {
                response.sendRedirect(request.getContextPath() + "/admin/categoryList?search="+name);
            }
        }
    }
}
