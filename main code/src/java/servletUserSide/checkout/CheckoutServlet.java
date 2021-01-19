/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletUserSide.checkout;

/**
 *
 * @author Hung
 */
import beans.CartItem;
import beans.Order;
import beans.OrderDetail;
import beans.Product;
import beans.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import utils.MyUtils;
import utils.OrderDAO;
import utils.OrderDetailDAO;
import utils.ProductDAO;
import utils.UserDAO;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public CheckoutServlet() {
        super();
    }

    // Hiển thị trang sửa sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/userViews/checkout/checkout.jsp");
        dispatcher.forward(request, response);

    }

    // Sau khi người dùng sửa đổi thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        try {
            int userId = (request.getParameter("userId") != null) 
                    ? Integer.parseInt(request.getParameter("userId"))
                    : 0;
            boolean useUserInfo = (request.getParameter("useUserInfo") != null)
                    ? Boolean.parseBoolean(request.getParameter("useUserInfo"))
                    : false;
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            User user = null;
            if(useUserInfo && userId != 0){
                user = UserDAO.findUser(conn, userId);
            } else {
                long now = java.time.Instant.now().toEpochMilli();
                user = new User("Anonymous"+now, "", name, true, phone, email, "");
                UserDAO.insertUser(conn, user);
                user = UserDAO.findUser(conn, "Anonymous"+now);
            }
            
            HashMap<String, String> aliasMap = new HashMap<>();
            aliasMap.put("VST", "Asia/Ho_Chi_Minh");            
            LocalDateTime time = LocalDateTime.now(ZoneId.of("VST", aliasMap));
            
            int amount = Integer.parseInt(request.getParameter("amount"));
            Order order = new Order(0, time, amount, user.getId());
            OrderDAO.insertOrder(conn, order);
            List<Order> orderList = OrderDAO.findOrderByUserId(conn, user.getId());
            order = orderList.get(orderList.size()-1);
            
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>)session.getAttribute("cart");
            for(int i=0;i<cart.size();i++){
                Product prod = cart.get(i).getProduct();
                int quantity = cart.get(i).getQuantity();
                OrderDetail detail = new OrderDetail(order.getId(), prod.getId(), quantity, "Pending");
                OrderDetailDAO.insertOrderDetail(conn, detail);
                prod.setQuantity(prod.getQuantity() - quantity);
                ProductDAO.updateProduct(conn, prod);
            }
            session.removeAttribute("cart");
            errorString = "The transaction has been created, currently pending";
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);

            // Nếu có lỗi forward sang trang edit.
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/userViews/checkout/checkout.jsp");
            dispatcher.forward(request, response);
        }
    }
}
