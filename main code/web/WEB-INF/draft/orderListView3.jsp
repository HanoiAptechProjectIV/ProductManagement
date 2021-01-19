<%-- 
    Document   : orderListView
    Created on : Dec 8, 2020, 5:15:13 PM
    Author     : Hung
--%>

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

        <jsp:include page="../../_header.jsp"/>
        <jsp:include page="../../_menu.jsp"/>

            <h3>Order List Page ${page}</h3>

        <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"/>
            <table border="1" cellpadding="5" cellspacing="1" >
                <tr>
                    <th>Id</th>
                    <th>User name</th>
                    <th>Product name</th>
                    <th>Amount</th>
                    <th>Purchase quantity</th>
                    <th>Created time</th>
                    <th>Payment time</th>
                    <th>Status</th>
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
                    <td>
                        <c:forEach items="${orderDetailList}" var="orderDetail" >
                            <c:if test="${order.id == orderDetail.orderId}">
                                <c:forEach items="${productList}" var="product" >
                                    <c:if test="${product.id == orderDetail.productId}">
                                          <a href="productList?search=${product.name}">${product.name}</a><br>
                                    </c:if>
                                </c:forEach>                                
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>${order.amount}</td>
                    <td>
                        <c:forEach items="${orderDetailList}" var="orderDetail" >
                            <c:if test="${order.id == orderDetail.orderId}">
                                ${orderDetail.purchasedQuantity}<hr>
                            </c:if>
                        </c:forEach>
                    </td></td>
                    <td>${order.createdTime}</td>
                    <td>${order.paymentTime}</td>
                    <td>
                        <c:forEach items="${orderDetailList}" var="orderDetail" >
                            <c:if test="${order.id == orderDetail.orderId}">
                                ${orderDetail.status}<hr>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>

                        <a href="editOrder?id=${order.id}">Edit</a>
                    </td>                              
                </tr>
            </c:forEach>
        </table>

        <jsp:include page="../../_pagination.jsp"/>
        <jsp:include page="../../_footer.jsp"/>

    </body>
</html>
