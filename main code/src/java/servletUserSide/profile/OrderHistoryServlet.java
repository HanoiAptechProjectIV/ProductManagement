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
import beans.Order;
import beans.User;
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

import java.util.ArrayList;
import utils.MyUtils;
import utils.OrderDAO;
import utils.UserDAO;

@WebServlet(urlPatterns = {"/history"})
public class OrderHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public OrderHistoryServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = MyUtils.getStoredConnection(request);

        String errorString = null;
        List<Order> list = new ArrayList<>();
        String sortBy = (request.getParameter("sortBy") != null) ? request.getParameter("sortBy") : "idDESC";
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            int rowInTable = 0;
            int rowInPage = 1;
            int pageQuantity = 1;
            int pageNum = (request.getParameter("page") != null)
                    ? Integer.parseInt(request.getParameter("page"))
                    : 1;
            pageNum = (pageNum < 1) ? 1 : pageNum;

            String ordinal = (sortBy.contains("ASC")) ? "ASC" : "DESC";
            String abridgedSortBy = sortBy.substring(0, sortBy.lastIndexOf(ordinal));
            if (abridgedSortBy.equals("product_id")
                    || abridgedSortBy.equals("purchased_quantity")
                    || abridgedSortBy.equals("status")) {
                abridgedSortBy = "id";
                ordinal = "DESC";
            }
            rowInTable = OrderDAO.findOrderByUserId(conn, userId).size();
            pageQuantity = (rowInTable % rowInPage == 0) ? rowInTable / rowInPage : rowInTable / rowInPage + 1;
            pageNum = (pageNum > pageQuantity) ? pageQuantity : pageNum;
            int offset = (pageNum - 1) * rowInPage;
            list = OrderDAO.findOrderByUserId(conn, userId, offset, rowInPage, abridgedSortBy, ordinal);

            request.setAttribute("pageQuantity", pageQuantity);
            request.setAttribute("page", pageNum);
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("orderList", list);
            request.setAttribute("sortBy", sortBy);

            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/userViews/profile/historyView.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
