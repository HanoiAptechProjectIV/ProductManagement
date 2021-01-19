/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletAdminSide.login;

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
import javax.servlet.http.HttpSession;
 
import utils.MyUtils;
 
@WebServlet(urlPatterns = {"/admin/logout" })
public class AdminLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public AdminLogoutServlet() {
        super();
    }
 
    // xóa session, cookie và chuyển đến trang login
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        MyUtils.deleteLoginedAdmin(session);
        MyUtils.deleteAdminCookie(response);
        
        // Forward tới trang /WEB-INF/adminViews/loginView.jsp
        // (Người dùng không thể truy cập trực tiếp
        // vào các trang JSP đặt trong thư mục WEB-INF).
        RequestDispatcher dispatcher //
                = this.getServletContext().getRequestDispatcher("/WEB-INF/adminViews/loginView.jsp");
 
        dispatcher.forward(request, response);
 
    }    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }    
}
