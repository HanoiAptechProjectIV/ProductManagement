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
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import utils.OrderDAO;
import utils.MyUtils;
import utils.OrderDetailDAO;

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
        int userId = (request.getParameter("search") != null)
                ? Integer.parseInt(request.getParameter("search"))
                : 0;
        List<Order> list = new ArrayList<Order>();;
        List<OrderDetail> listDetail = new ArrayList<OrderDetail>();
        try {
            if (userId != 0) {
                list.addAll(OrderDAO.findOrderByUserId(conn, userId));               
                for (Order order : list) {
                    listDetail.addAll(OrderDetailDAO.findOrderDetailList(conn, order.getId()));
                }                
            } else {
                list = OrderDAO.queryOrder(conn);
                for (Order order : list) {
                    listDetail.addAll(OrderDetailDAO.findOrderDetailList(conn, order.getId()));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        }
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("orderList", list);
        request.setAttribute("orderDetailList", listDetail);

        // Forward sang /WEB-INF/views/orderListView.jsp
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/read/orderListView.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
