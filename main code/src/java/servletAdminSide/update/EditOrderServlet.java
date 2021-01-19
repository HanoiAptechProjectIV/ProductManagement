/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletAdminSide.update;

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
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import utils.OrderDAO;
import utils.MyUtils;
import utils.OrderDetailDAO;
import utils.ProductDAO;

@WebServlet(urlPatterns = {"/admin/editOrder"})
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
            listDetail = OrderDetailDAO.findOrderDetailList(conn, id, "id", "ASC");
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
                    .getRequestDispatcher("/WEB-INF/adminViews/CRUD/update/editOrderView.jsp");
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
        List<OrderDetail> listDetail = new ArrayList<OrderDetail>();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int amount = Integer.parseInt(request.getParameter("amount"));
            LocalDateTime createdTime = LocalDateTime.parse(request.getParameter("createdTime"));
            LocalDateTime paymentTime = null;
            if (!request.getParameter("paymentTime").equals("")) {
                paymentTime = LocalDateTime.parse(request.getParameter("paymentTime"));
                HashMap<String, String> aliasMap = new HashMap<>();
                aliasMap.put("VST", "Asia/Ho_Chi_Minh");

                if (paymentTime.isBefore(LocalDateTime.now(ZoneId.of("VST", aliasMap)).minusDays(30))
                        || paymentTime.isAfter(LocalDateTime.now(ZoneId.of("VST", aliasMap)))) {
                    errorString = "The payment time must at most 1 month before and must not be after the current date";
                } else {
                    order = new Order(id, createdTime, paymentTime, amount, userId);
                    OrderDAO.updateOrder(conn, order);
                }
            } else {
                order = new Order(id, createdTime, amount, userId);
                OrderDAO.updateOrder(conn, order);
            }

            if (errorString == null) {
                List<OrderDetail> listAddedDetail = new ArrayList<>();
                int countRow = Integer.parseInt(request.getParameter("countRow"));
                for(int i=1;i<=countRow;i++){
                    String productAdded = request.getParameter("productNameOptionAdded"+i);
                    int purchasedQuantityAdded = Integer.parseInt(request.getParameter("purchasedQuantityAdded"+i));
                    String statusAdded = request.getParameter("statusOptionAdded"+i);

                    Product product = ProductDAO.findProductByName(conn, productAdded);
                    if(product != null){
                        int productId = product.getId();
                        OrderDetail detail = new OrderDetail(id, productId, purchasedQuantityAdded, statusAdded);
                        listAddedDetail.add(detail);
                    } else {
                        errorString = "Can not find product";
                    }
                } 
                
                listDetail = OrderDetailDAO.findOrderDetailList(conn, id, "id", "ASC");
                for (OrderDetail detail : listDetail) {
                    int idOrderDetail = Integer.parseInt(request.getParameter("idOrderDetail" + detail.getId()));
                    String productName = request.getParameter("productNameOptionId" + detail.getId());
                    Product product = ProductDAO.findProductByName(conn, productName);
                    if (product != null) {
                        int productId = product.getId();
                        int purchasedQuantity = Integer.parseInt(request.getParameter("purchasedQuantityId" + detail.getId()));
                        String status = request.getParameter("statusOptionId" + detail.getId());

                        List<OrderDetail> deleteAddedDetail = new ArrayList<>();
                        for(OrderDetail addedDetail : listAddedDetail){
                            if(addedDetail.getProductId() == productId 
                                    && addedDetail.getStatus().equals(status)){
                                purchasedQuantity += addedDetail.getPurchasedQuantity();
                                deleteAddedDetail.add(addedDetail);
                            }
                        }
                        deleteAddedDetail.forEach((deleteDetail) -> {
                            listAddedDetail.remove(deleteDetail);
                        });
                        
                        OrderDetail orderDetail = new OrderDetail(idOrderDetail, id, productId, purchasedQuantity, status);
                        OrderDetailDAO.updateOrderDetail(conn, orderDetail);

                        if (!status.equals("Refund") && !status.equals("Canceled")) {
                            product.setQuantity(product.getQuantity() - (purchasedQuantity - detail.getPurchasedQuantity()));
                            ProductDAO.updateProduct(conn, product);
                        } else {
                            product.setQuantity(product.getQuantity() + detail.getPurchasedQuantity());
                            ProductDAO.updateProduct(conn, product);                            
                        }
                    } else {
                        errorString = "Can not find product";
                    }
                }
                
                for(OrderDetail addedDetail : listAddedDetail){
                        OrderDetailDAO.insertOrderDetail(conn, addedDetail);
                        Product product = ProductDAO.findProduct(conn, addedDetail.getProductId());
                        
                        if (!addedDetail.getStatus().equals("Refund") 
                                && !addedDetail.getStatus().equals("Canceled")) {
                            product.setQuantity(product.getQuantity() - addedDetail.getPurchasedQuantity());
                            ProductDAO.updateProduct(conn, product);
                        } 
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("order", order);
            request.setAttribute("orderDetail", listDetail);

            // Nếu có lỗi forward sang trang edit.
            if (errorString != null) {
                RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher("/WEB-INF/adminViews/CRUD/update/editOrderView.jsp");
                dispatcher.forward(request, response);
            } // Nếu mọi thứ tốt đẹp.
            // Redirect sang trang danh sách sản phẩm.
            else {
                response.sendRedirect(request.getContextPath() + "/admin/orderList?id=" + order.getId());
            }
        }
    }

}
