/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.update;

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

import beans.Order;
import beans.OrderDetail;
import beans.Product;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import utils.OrderDAO;
import utils.MyUtils;
import utils.OrderDetailDAO;
import utils.ProductDAO;

@WebServlet(urlPatterns = {"/editOrder"})
public class EditOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public EditOrderServlet() {
        super();
    }

    // Hiển thị trang sửa sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        Order order = null;
        List<OrderDetail> listDetail = new ArrayList<OrderDetail>();
        String errorString = null;

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            order = OrderDAO.findOrder(conn, id);
            listDetail = OrderDetailDAO.findOrderDetailList(conn, id);
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {

            // Không có lỗi.
            // Sản phẩm không tồn tại để edit.
            // Redirect sang trang danh sách sản phẩm.
            if (errorString != null && order == null) {
                response.sendRedirect(request.getServletPath() + "/orderList");
                return;
            }

            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("order", order);
            request.setAttribute("orderDetail", listDetail);

            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/update/editOrderView.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Sau khi người dùng sửa đổi thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        Order order = null;
        OrderDetail orderDetail = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int amount = Integer.parseInt(request.getParameter("amount"));
            LocalDateTime createdTime = LocalDateTime.parse(request.getParameter("createdTime"));
            LocalDateTime paymentTime = null;
            if (!request.getParameter("paymentTime").equals("")) {
                paymentTime = LocalDateTime.parse(request.getParameter("paymentTime"));

                order = new Order(id, createdTime, paymentTime, amount, userId);
            } else {
                order = new Order(id, createdTime, amount, userId);
            }
            OrderDAO.updateOrder(conn, order);

            List<OrderDetail> listDetail = OrderDetailDAO.findOrderDetailList(conn, id);
            for (OrderDetail detail : listDetail) {
                int idOrderDetail = Integer.parseInt(request.getParameter("idOrderDetail" + detail.getId()));

                String productName = request.getParameter("productNameOption" + detail.getId());
                Product product = ProductDAO.findProductByName(conn, productName);
                int productId = 0;
                if (product != null) {
                    productId = product.getId();
                    int purchasedQuantity = Integer.parseInt(request.getParameter("purchasedQuantity" + detail.getId()));
                    String status = request.getParameter("statusOption" + detail.getId());

                    if(!status.equals("Refund") && !status.equals("Canceled")){
                        product.setQuantity(product.getQuantity() - (purchasedQuantity - detail.getPurchasedQuantity()));
                        ProductDAO.updateProduct(conn, product);
                    }
                    
                    orderDetail = new OrderDetail(idOrderDetail, id, productId, purchasedQuantity, status);
                    OrderDetailDAO.updateOrderDetail(conn, orderDetail);
                } else {
                    errorString = "Can not find product";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("order", order);
            request.setAttribute("orderDetail", orderDetail);

            // Nếu có lỗi forward sang trang edit.
            if (errorString != null) {
                RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher("/WEB-INF/views/CRUD/update/editOrderView.jsp");
                dispatcher.forward(request, response);
            } // Nếu mọi thứ tốt đẹp.
            // Redirect sang trang danh sách sản phẩm.
            else {
                response.sendRedirect(request.getContextPath() + "/orderList?id=" + order.getId());
            }
        }
    }

}
