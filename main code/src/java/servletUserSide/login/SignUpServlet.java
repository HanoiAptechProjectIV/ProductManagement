/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletUserSide.login;

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

import beans.User;
import utils.UserDAO;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/signup"})
public class SignUpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public SignUpServlet() {
        super();
    }

    // Hiển thị trang Login.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward tới trang /WEB-INF/userViews/login/loginView.jsp
        // (Người dùng không thể truy cập trực tiếp
        // vào các trang JSP đặt trong thư mục WEB-INF).
        RequestDispatcher dispatcher //
                = this.getServletContext().getRequestDispatcher("/WEB-INF/userViews/login/signupView.jsp");

        dispatcher.forward(request, response);

    }

    // Khi người nhập username & password, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = (request.getParameter("name") != null) ? request.getParameter("name") : "";
        String genderStr = request.getParameter("gender");
        boolean gender = (genderStr != null) ? (genderStr.equals("true")) : true;
        String phone = (request.getParameter("phone") != null) ? request.getParameter("phone") : "";
        String email = (request.getParameter("email") != null) ? request.getParameter("email") : "";
        String address = (request.getParameter("address") != null) ? request.getParameter("address") : "";

        User user = null;
        boolean hasError = false;
        String errorString = null;

        if (username == null || password == null || username.length() == 0 || password.length() == 0) {
            hasError = true;
            errorString = "Required username and password!";
        } else {
            Connection conn = MyUtils.getStoredConnection(request);
            try {
                // Tìm user trong DB.
                user = UserDAO.findUser(conn, username);

                if (user != null) {
                    hasError = true;
                    errorString = "Your account was existed";
                } else {
                    user = new User(username, password, name, gender, phone, email, address);
                    UserDAO.insertUser(conn, user);
                }
            } catch (Exception e) {
                e.printStackTrace();
                hasError = true;
                errorString = e.getMessage();
            }
        }
        // Trong trường hợp có lỗi,
        // forward (chuyển hướng) tới /WEB-INF/userViews/login.jsp
        if (hasError) {
            user = new User(username, password, name, gender, phone, email, address);

            // Lưu các thông tin vào request attribute trước khi forward.
            request.setAttribute("errorString", errorString);
            request.setAttribute("user", user);

            // Forward (Chuyển tiếp) tới trang /WEB-INF/userViews/login.jsp
            RequestDispatcher dispatcher //
                    = this.getServletContext().getRequestDispatcher("/WEB-INF/userViews/login/signupView.jsp");

            dispatcher.forward(request, response);
        } // Trường hợp không có lỗi.
        // Lưu thông tin người dùng vào Session.
        // Và chuyển hướng sang trang userInfo.
        else {
            HttpSession session = request.getSession();
            MyUtils.storeLoginedUser(session, user);

            // Redirect (Chuyển hướng) sang trang /userInfo.
            response.sendRedirect(request.getContextPath() + "/index");
        }
    }

}
