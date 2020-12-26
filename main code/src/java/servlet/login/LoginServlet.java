/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Admin;
import utils.AdminDAO;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    // Hiển thị trang Login.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //logout, đã thêm một servlet riêng
//        boolean logout = Boolean.parseBoolean(request.getParameter("logout"));
//        if (logout) {
//            HttpSession session = request.getSession();
//            MyUtils.deleteLoginedAdmin(session);
//            MyUtils.deleteAdminCookie(response);
//        }

        // Kiểm tra người dùng đã đăng nhập (login) chưa.
        String loginedAdmin = MyUtils.getAdminCookie(request);
        HttpSession session = request.getSession();
        Admin adminLogined = MyUtils.getLoginedAdmin(session);

        // Nếu đã đăng nhập (login).
        if (loginedAdmin != null || adminLogined != null) {
            // Redirect (Chuyển hướng) tới trang login.
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        // Forward tới trang /WEB-INF/views/loginView.jsp
        // (Người dùng không thể truy cập trực tiếp
        // vào các trang JSP đặt trong thư mục WEB-INF).
        RequestDispatcher dispatcher //
                = this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");

        dispatcher.forward(request, response);

    }

    // Khi người nhập username & password, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMeStr = request.getParameter("rememberMe");
        boolean remember = "Y".equals(rememberMeStr);

        Admin admin = null;
        boolean hasError = false;
        String errorString = null;

        if (username == null || password == null || username.length() == 0 || password.length() == 0) {
            hasError = true;
            errorString = "Required username and password!";
        } else {
            Connection conn = MyUtils.getStoredConnection(request);
            try {
                // Tìm admin trong DB.
                admin = AdminDAO.findAdmin(conn, username, password);

                if (admin == null) {
                    hasError = true;
                    errorString = "Username or password invalid";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                hasError = true;
                errorString = e.getMessage();
            }
        }
        // Trong trường hợp có lỗi,
        // forward (chuyển hướng) tới /WEB-INF/views/login.jsp
        if (hasError) {
            admin = new Admin();
            admin.setUsername(username);
            admin.setPassword(password);

            // Lưu các thông tin vào request attribute trước khi forward.
            request.setAttribute("errorString", errorString);
            request.setAttribute("admin", admin);

            // Forward (Chuyển tiếp) tới trang /WEB-INF/views/login.jsp
            RequestDispatcher dispatcher //
                    = this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");

            dispatcher.forward(request, response);
        } // Trường hợp không có lỗi.
        // Lưu thông tin người dùng vào Session.
        // Và chuyển hướng sang trang adminInfo.
        else {
            HttpSession session = request.getSession();
            MyUtils.storeLoginedAdmin(session, admin);

            // Nếu người dùng chọn tính năng "Remember me".
            if (remember) {
                MyUtils.storeAdminCookie(response, admin);
            } // Ngược lại xóa Cookie
            else {
                MyUtils.deleteAdminCookie(response);
            }

            // Redirect (Chuyển hướng) sang trang /adminInfo.
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

}
