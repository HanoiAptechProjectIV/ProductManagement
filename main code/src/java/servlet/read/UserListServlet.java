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
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import beans.User;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import utils.MyUtils;
import utils.UserDAO;
 
@WebServlet(urlPatterns = { "/userList" })
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public UserListServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
 
        // Kiểm tra người dùng đã đăng nhập (login) chưa.
        Admin adminLogined = MyUtils.getLoginedAdmin(session);
        String loginedAdmin = MyUtils.getAdminCookie(request);
        // Nếu chưa đăng nhập (login).
        if (adminLogined == null && loginedAdmin == null) {
            // Redirect (Chuyển hướng) tới trang login.
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Connection conn = MyUtils.getStoredConnection(request);
 
        String errorString = null;
        List<User> list = null;
        try {
            list = UserDAO.queryUser(conn);
            for(User user : list){
                System.out.println(user.getName());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        }        
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("userList", list);
 
        // Nếu người dùng đã login thì forward (chuyển tiếp) tới trang
        // /WEB-INF/views/userInfoView.jsp
        RequestDispatcher dispatcher //
                = this.getServletContext().getRequestDispatcher("/WEB-INF/views/CRUD/read/userListView.jsp");
        dispatcher.forward(request, response);
 
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}

