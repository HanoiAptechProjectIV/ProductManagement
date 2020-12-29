/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.update;

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

import beans.Admin;
import utils.AdminDAO;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/editAdmin"})
public class EditAdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public EditAdminServlet() {
        super();
    }

    // Hiển thị trang sửa sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        String username = request.getParameter("username");

        String errorString = null;
        Admin admin = null;
        try {
            admin = AdminDAO.findAdmin(conn, username);
        } catch (SQLException ex) {
            ex.printStackTrace();
            errorString = ex.getMessage();
        }

        // Không có lỗi.
        // Sản phẩm không tồn tại để edit.
        // Redirect sang trang danh sách sản phẩm.
        if (errorString != null && admin == null) {
            response.sendRedirect(request.getServletPath() + "/adminList");
            return;
        }

        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("admin", admin);

        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/update/editAdminView.jsp");
        dispatcher.forward(request, response);

    }

    // Sau khi người dùng sửa đổi thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        
        String username = (String) request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = new Admin(username, password);
        String errorString = null;
        try {
            AdminDAO.updateAdmin(conn, admin);
        } catch (SQLException ex) {
            ex.printStackTrace();
            errorString = ex.getMessage();
        }

        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("admin", admin);

        // Nếu có lỗi forward sang trang edit.
        if (errorString != null) {
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/update/editAdminView.jsp");
            dispatcher.forward(request, response);
        } // Nếu mọi thứ tốt đẹp.
        // Redirect sang trang danh sách sản phẩm.
        else {
            response.sendRedirect(request.getContextPath() + "/adminList");
        }
    }

}
