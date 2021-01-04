<%-- 
    Document   : editOrderView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

<%@page import="beans.Order"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Order</title>
    </head>
    <body>

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Edit Order</h3>

            <p style="color: red;">${errorString}</p>

        <c:if test="${not empty order && not empty orderDetail}">
            <form method="POST" action="${pageContext.request.contextPath}/editOrder">
                <table border="1" >
                    <tr>
                        <td>Order id</td>
                        <td><input type="text" readonly name="id" value="${order.id}" /></td>
                    </tr>
                    <tr>
                        <td>User Id</td>
                        <td><input type="text" readonly name="userId" value="${order.userId}" /></td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td><input type="text" readonly name="amount" value="${order.amount}" /></td>
                    </tr>
                    <tr>
                        <td>Created time</td>
                        <td><input type="text" readonly name="createdTime" value="${order.createdTime}" /></td>
                    </tr>
                    <tr>
                        <td>Payment time</td>
                        <td><input id="paymentTimeInput" type="text" name="paymentTime" value="<%
                        LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
                        Order order = (Order) request.getAttribute("order");
                        if(!order.getPaymentTime().equals(ldt)){
                            %><%=order.getPaymentTime()%><%}%>" /><br>
                    <input type="button" onclick="getCurrentTime()" value="Get Current Time"/>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <table border="1" cellpadding="5" cellspacing="1" >
                        <tr>
                            <th>Order Detail Id</th>
                            <th>Product id</th>
                            <th>Purchase quantity</th>
                            <th>Status</th>
                        </tr>
                        <c:forEach items="${orderDetail}" var="orderDetail" >
                            <tr>
                                <td><input type="text" readonly name="idOrderDetail${orderDetail.id}" value="${orderDetail.id}" /></td>
                                <td><input type="text" name="productId${orderDetail.id}" value="${orderDetail.productId}" /></td>
                                <td><input type="text" name="purchasedQuantity${orderDetail.id}" value="${orderDetail.purchasedQuantity}" /></td>
                                <td><input type="text" name="status${orderDetail.id}" value="${orderDetail.status}" /></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <tr>
                        <td colspan = "2">
                            <input type="submit" value="Submit" />
                            <a href="${pageContext.request.contextPath}/orderList">Cancel</a>
                        </td>
                    </tr>
                </table>
            </form>
        </c:if>

        <jsp:include page="../../_footer.jsp"></jsp:include>
        <script>
            getCurrentTime = () => {
                var date = new Date();
                date.setTime(date.getTime()+25200000);
                var nowStr = date.toISOString();
                var paymentTime = document.getElementById("paymentTimeInput");
                nowStr = nowStr.substring(0, nowStr.lastIndexOf(":")+3);
                paymentTime.value = nowStr;
            };
        </script>

    </body>
</html>
