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
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Order;
import beans.OrderDetail;
import beans.User;
import java.util.ArrayList;
import utils.OrderDAO;
import utils.MyUtils;
import utils.OrderDetailDAO;
import utils.UserDAO;

@WebServlet(urlPatterns = {"/orderList"})
public class OrderListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public OrderListServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = MyUtils.getStoredConnection(request);

        String errorString = null;
        List<Order> list = new ArrayList<Order>();;
        List<OrderDetail> listDetail = new ArrayList<OrderDetail>();
        List<User> listUser = new ArrayList<User>();

        try {
            String userName = request.getParameter("search");
            String id = request.getParameter("id");
            int orderId = Integer.MAX_VALUE;
            orderId = (id!= null) ? Integer.parseInt(id) : orderId;

            int rowInTable = 0;
            int rowInPage = 2;
            int pageQuantity = 1;
            int pageNum = (request.getParameter("page") != null)
                    ? Integer.parseInt(request.getParameter("page"))
                    : 1;
            pageNum = (pageNum < 1) ? 1 : pageNum;

            if (orderId != Integer.MAX_VALUE){
                list.add(OrderDAO.findOrder(conn, orderId));
                if (list.size() > 0) {
                    for (Order order : list) {
                        listDetail.addAll(OrderDetailDAO.findOrderDetailList(conn, order.getId()));
                        
                        User user = UserDAO.findUser(conn, order.getUserId());
                        listUser.add(user);                        
                    }
                }                
            }            
            else if (userName != null) {
                User user = UserDAO.findUserByName(conn, userName);
                if (user != null) {
                    list = OrderDAO.findOrderByUserId(conn, user.getId());
                    listUser.add(user);
                }

                if (list.size() > 0) {
                    for (Order order : list) {
                        listDetail.addAll(OrderDetailDAO.findOrderDetailList(conn, order.getId()));
                    }
                }
            } 
            
            else {
                rowInTable = OrderDAO.countRows(conn);
                pageQuantity = (rowInTable % 2 == 0) ? rowInTable / 2 : rowInTable / 2 + 1;
                pageNum = (pageNum > pageQuantity) ? pageQuantity : pageNum;
                int offset = (pageNum - 1) * rowInPage;
                list = OrderDAO.queryOrder(conn, offset, rowInPage);

                request.setAttribute("pageQuantity", pageQuantity);
                request.setAttribute("page", pageNum);

                if (list.size() > 0) {
                    for (Order order : list) {
                        listDetail.addAll(OrderDetailDAO.findOrderDetailList(conn, order.getId()));

                        User user = UserDAO.findUser(conn, order.getUserId());
                        listUser.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("orderList", list);
            request.setAttribute("orderDetailList", listDetail);
            request.setAttribute("userList", listUser);

            // Forward sang /WEB-INF/views/orderListView.jsp
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/read/orderListView.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
