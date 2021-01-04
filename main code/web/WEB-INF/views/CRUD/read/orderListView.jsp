<%-- 
    Document   : orderListView
    Created on : Dec 8, 2020, 5:15:13 PM
    Author     : Hung
--%>

<%@page import="java.time.LocalDateTime"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.Product"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page import="utils.OrderDetailDAO"%>
<%@page import="beans.Order"%>
<%@page import="beans.OrderDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order List</title>
    </head>
    <body>

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Order List Page ${page}</h3>

        <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"></jsp:include>
            <table border="1" cellpadding="5" cellspacing="1" >
                <tr>
                    <th>Id</th>
                    <th>User name</th>
                    <th>Amount</th>
                    <th>Product name</th>
                    <th>Price</th>
                    <th>Purchase quantity</th>
                    <th>Status</th>
                    <th>Created time</th>
                    <th>Payment time</th>
                    <th>Edit</th>
                </tr>
            <c:forEach items="${orderList}" var="order" >
                <tr>
                    <td>${order.id}</td>
                    <c:forEach items="${userList}" step="10" var="user">
                        <c:if test="${user.id == order.userId}">
                            <td><a href="userList?search=${user.name}">${user.name}</a><br></td>
                            </c:if>
                        </c:forEach>
                    <td>${order.amount}</td>

                    <c:set var="orderObj" value="${order}"/>
                    <%
                        List<OrderDetail> listDetail = (List<OrderDetail>) request.getAttribute("orderDetailList");
                        Order orderObj = (Order) pageContext.getAttribute("orderObj");
                        Connection conn = MyUtils.getStoredConnection(request);
                        Product prod = new Product();
                    %>
                    <td>
                    <%
                        for (OrderDetail detail : listDetail) {
                            if (orderObj.getId() == detail.getOrderId()) {
                                prod = ProductDAO.findProduct(conn, detail.getProductId());
                                if (prod != null) {
                    %>
                    <a href="productList?search=<%=prod.getName()%>"><%=prod.getName()%></a><hr>
                    
                    <%
                                }
                            }
                        }
                    %>
                    </td>
                    <td>
                    <%
                        for (OrderDetail detail : listDetail) {
                            if (orderObj.getId() == detail.getOrderId()) {
                                prod = ProductDAO.findProduct(conn, detail.getProductId());
                                if (prod != null) {
                    %>
                    <%=prod.getPrice()%><hr>
                    <%
                                }
                            }
                        }
                    %>
                    </td>
                    <td>
                        <c:forEach items="${orderDetailList}" var="orderDetail" >
                            <c:if test="${order.id == orderDetail.orderId}">
                                ${orderDetail.purchasedQuantity}<hr>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach items="${orderDetailList}" var="orderDetail" >
                            <c:if test="${order.id == orderDetail.orderId}">
                                ${orderDetail.status}<hr>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>${order.createdTime}</td>
                    <td><%
                        LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
                        if(!orderObj.getPaymentTime().equals(ldt)){
                        %>
                            <%=orderObj.getPaymentTime()%>
                        <%   
                        }
                        %></td>
                    <td>

                        <a href="editOrder?id=${order.id}">Edit</a>
                    </td>                              
                </tr>
            </c:forEach>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
