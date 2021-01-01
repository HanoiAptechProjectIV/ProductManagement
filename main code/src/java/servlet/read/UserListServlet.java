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

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.User;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.MyUtils;
import utils.UserDAO;

@WebServlet(urlPatterns = {"/userList"})
public class UserListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UserListServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        String name = request.getParameter("search");
        List<User> list = new ArrayList<User>();
        try {
            int rowInTable = 0;
            int rowInPage = 2;
            int pageQuantity = 1;
            int pageNum = (request.getParameter("page") != null)
                    ? Integer.parseInt(request.getParameter("page"))
                    : 1;
            pageNum = (pageNum < 1) ? 1 : pageNum;

            if (name != null) {
                list.add(UserDAO.findUserByName(conn, name));
            } else {
                rowInTable = UserDAO.countRows(conn);
                pageQuantity = (rowInTable % 2 == 0) ? rowInTable / 2 : rowInTable / 2 + 1;
                pageNum = (pageNum > pageQuantity) ? pageQuantity : pageNum;
                int offset = (pageNum - 1) * rowInPage;
                list = UserDAO.queryUser(conn, offset, rowInPage);

                request.setAttribute("pageQuantity", pageQuantity);
                request.setAttribute("page", pageNum);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("userList", list);

            // Nếu người dùng đã login thì forward (chuyển tiếp) tới trang
            // /WEB-INF/views/userInfoView.jsp
            RequestDispatcher dispatcher //
                    = this.getServletContext().getRequestDispatcher("/WEB-INF/views/CRUD/read/userListView.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
