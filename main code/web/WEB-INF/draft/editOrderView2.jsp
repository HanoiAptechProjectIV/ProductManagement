<%-- 
    Document   : editOrderView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

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

        <jsp:include page="../../_header.jsp"/>
        <jsp:include page="../../_menu.jsp"/>

            <h3>Edit Order</h3>

            <p style="color: red;">${errorString}</p>

        <c:if test="${not empty order && not empty orderDetail}">
            <form method="POST" action="${pageContext.request.contextPath}/admin/editOrder">
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
                        <td><input type="text" name="amount" value="${order.amount}" /></td>
                    </tr>
                    <tr>
                        <td>Created time</td>
                        <td><input type="text" name="createdTime" value="${order.createdTime}" /></td>
                    </tr>
                    <tr>
                        <td>Payment time</td>
                        <td><input type="text" name="paymentTime" value="${order.paymentTime}" /></td>
                    </tr>
                    <hr>
                    <br>
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
                                <td><input type="text" name="productId${orderDetail.status}" value="${orderDetail.productId}" /></td>
                                <td><input type="text" name="purchasedQuantity${orderDetail.status}" value="${orderDetail.purchasedQuantity}" /></td>
                                <td><input type="text" name="status${orderDetail.status}" value="${orderDetail.status}" /></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <tr>
                        <td colspan = "2">
                            <input type="submit" value="Submit" />
                            <a href="${pageContext.request.contextPath}/admin/orderList">Cancel</a>
                        </td>
                    </tr>
                </table>
            </form>
        </c:if>

        <jsp:include page="../../_footer.jsp"/>

    </body>
</html>
