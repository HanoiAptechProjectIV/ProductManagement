/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filter;

/**
 *
 * @author Hung
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import beans.Admin;
import beans.User;
import utils.AdminDAO;
import utils.MyUtils;
import utils.UserDAO;

@WebFilter(filterName = "sessionCookieFilter", urlPatterns = {"/*"})
public class SessionCookieFilter implements Filter {

    public SessionCookieFilter() {
    }

    @Override
    public void init(FilterConfig fConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        // cho admin 
        Admin adminInSession = MyUtils.getLoginedAdmin(session);
        // đã đăng nhập
        if (adminInSession != null) {
            session.setAttribute("SESSION_ADMIN_CHECKED", "CHECKED");
        } else {
            session.removeAttribute("SESSION_ADMIN_CHECKED");
        }

        // Connection đã được tạo trong JDBCFilter.
        Connection conn = MyUtils.getStoredConnection(request);
        // Cờ (flag) để kiểm tra Cookie.
        String checked = (String) session.getAttribute("SESSION_ADMIN_CHECKED");
        if (checked == null && conn != null) {
            String username = MyUtils.getAdminCookie(req);
            Admin admin = null;
            try {
                admin = AdminDAO.findAdmin(conn, username);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            if (admin != null) {
                MyUtils.storeLoginedAdmin(session, admin);
                // Đánh dấu đã kiểm tra Cookie.
                session.setAttribute("COOKIE_ADMIN_CHECKED", "CHECKED");
            } else {
                session.removeAttribute("COOKIE_ADMIN_CHECKED");
            } 
        }
        
        // cho user
        User userInSession = MyUtils.getLoginedUser(session);
        // đã đăng nhập
        if (userInSession != null) {
            session.setAttribute("SESSION_USER_CHECKED", "CHECKED");
        } else {
            session.removeAttribute("SESSION_USER_CHECKED");
        }

        // Cờ (flag) để kiểm tra Cookie.
        checked = (String) session.getAttribute("SESSION_USER_CHECKED");
        if (checked == null && conn != null) {
            String username = MyUtils.getUserCookie(req);
            User user = null;
            try {
                user = UserDAO.findUser(conn, username);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            if (user != null) {
                MyUtils.storeLoginedUser(session, user);
                // Đánh dấu đã kiểm tra Cookie.
                session.setAttribute("COOKIE_USER_CHECKED", "CHECKED");
            } else {
                session.removeAttribute("COOKIE_USER_CHECKED");
            }
        }        

        chain.doFilter(request, response);
    }

}
