/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author Hung
 */
import java.sql.Connection;
 
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import beans.Admin;
 
public class MyUtils {
 
    public static final String ATT_NAME_CONNECTION = "ATTRIBUTE_FOR_CONNECTION";
 
    private static final String ATT_NAME_USER_NAME = "ATTRIBUTE_FOR_STORE_USER_NAME_IN_COOKIE";
 
    // Lưu trữ Connection vào attribute của request.
    // Thông tin lưu trữ này chỉ tồn tại trong thời gian yêu cầu (request)
    // cho tới khi dữ liệu được trả về trình duyệt người dùng.
    public static void storeConnection(ServletRequest request, Connection conn) {
        request.setAttribute(ATT_NAME_CONNECTION, conn);
    }
 
    // Lấy đối tượng Connection đã được lưu trữ trong attribute của request.
    public static Connection getStoredConnection(ServletRequest request) {
        Connection conn = (Connection) request.getAttribute(ATT_NAME_CONNECTION);
        return conn;
    }
 
    // Lưu trữ thông tin người dùng đã login vào Session.
    public static void storeLoginedAdmin(HttpSession session, Admin loginedAdmin) {
        // Trên JSP có thể truy cập thông qua ${loginedAdmin}
        session.setAttribute("loginedAdmin", loginedAdmin);
    }
 
    // Lấy thông tin người dùng lưu trữ trong Session.
    public static Admin getLoginedAdmin(HttpSession session) {
        Admin loginedAdmin = (Admin) session.getAttribute("loginedAdmin");
        return loginedAdmin;
    }
    
    public static void deleteLoginedAdmin(HttpSession session) {
        session.invalidate();
    }
 
    // Lưu thông tin người dùng vào Cookie.
    public static void storeAdminCookie(HttpServletResponse response, Admin admin) {
        Cookie cookieUsername = new Cookie(ATT_NAME_USER_NAME, admin.getUsername());
        // 1 ngày (Đã đổi ra giây)
        cookieUsername.setMaxAge(60*60*24);
        response.addCookie(cookieUsername);
    }
 
    // Lấy thông tin người dùng lưu trữ trong Cookie
    public static String getAdminCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (ATT_NAME_USER_NAME.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
 
    // Xóa Cookie của người dùng
    public static void deleteAdminCookie(HttpServletResponse response) {
        Cookie cookieUsername = new Cookie(ATT_NAME_USER_NAME, null);
        // 0 giây. (Cookie này sẽ hết hiệu lực ngay lập tức)
        cookieUsername.setMaxAge(0);
        response.addCookie(cookieUsername);
    }
 
}