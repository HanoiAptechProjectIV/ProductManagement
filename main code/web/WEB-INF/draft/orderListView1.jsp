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

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Order List</h3>

            <p style="color: red;">${errorString}</p>

        <table border="1" cellpadding="5" cellspacing="1" >
            <tr>
                <th>Id</th>
                <th>User id</th>
                <th>Product id</th>
                <th>Amount</th>
                <th>Purchase quantity</th>
                <th>Created time</th>
                <th>Payment time</th>
                <th>Status</th>
                <th>Edit</th>
            </tr>
            <c:forEach items="${orderList}" var="order" >  
                <c:forEach items="${orderDetailList}" var="orderDetail" >
                    <c:if test="${order.id == orderDetail.orderId}">                
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.userId}</td>
                            <td>${orderDetail.productId}</td>
                            <td>${order.amount}</td>
                            <td>${orderDetail.purchasedQuantity}</td>
                            <td>${order.createdTime}</td>
                            <td>${order.paymentTime}</td>
                            <td>${orderDetail.status}</td>
                            <td>                        
                                <a href="editOrder?idOrder=${order.id}&idOrderDetail=${orderDetail.id}">Edit</a>
                            </td>                              
                        </tr>
                    </c:if>
                </c:forEach>
            </c:forEach>
        </table>


        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
