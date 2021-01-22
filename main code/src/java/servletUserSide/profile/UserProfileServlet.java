/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletUserSide.profile;

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

import beans.User;
import javax.servlet.http.HttpSession;
import utils.UserDAO;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/profile"})
public class UserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UserProfileServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String errorString = null;
        User user = null;
        try {
            HttpSession session = request.getSession();
            Connection conn = MyUtils.getStoredConnection(request);
            User userSession = MyUtils.getLoginedUser(session);
            user = UserDAO.findUser(conn, userSession.getUsername());
            if (user == null) {
                errorString = "Error, Can not find your account";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            errorString = ex.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("user", user);

            // Forward sang /WEB-INF/userViews/userListView.jsp
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/userViews/profile/profile.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = null;
        String errorString = null;
        Connection conn = MyUtils.getStoredConnection(request);
        try {
            int id = (request.getParameter("id") != null) 
                    ? Integer.parseInt(request.getParameter("id")) : 0;
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = (request.getParameter("name") != null) ? request.getParameter("name") : "";
            String genderStr = request.getParameter("gender");
            boolean gender = (genderStr != null) ? (genderStr.equals("true")) : true;
            String phone = (request.getParameter("phone") != null) ? request.getParameter("phone") : "";
            String email = (request.getParameter("email") != null) ? request.getParameter("email") : "";
            String address = (request.getParameter("address") != null) ? request.getParameter("address") : "";

            // Tìm user trong DB.
            user = UserDAO.findUser(conn, id);

            if (user == null) {
                errorString = "Can't find your account";
            } else {
                user = new User(id, username, password, name, gender, phone, email, address);
                UserDAO.updateUser(conn, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            if(errorString == null && user != null){
                HttpSession session = request.getSession();
                MyUtils.storeLoginedUser(session, user);
                errorString ="Update profile successful";
            }
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("user", user);

            // Forward sang /WEB-INF/userViews/userListView.jsp
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/userViews/profile/profile.jsp");
            dispatcher.forward(request, response);            
        }
    }
}
