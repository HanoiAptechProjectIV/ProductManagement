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
 
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
 
      <h3>Edit Order</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <c:if test="${not empty order && not empty orderDetail}">
         <form method="POST" action="${pageContext.request.contextPath}/editOrder">
            <input type="hidden" name="idOrderDetail" value="${orderDetail.id}" />
            <table border="0">
            <tr>
               <td>Order id</td>
               <td><input type="text" readonly name="id" value="${order.id}" /></td>
            </tr>
            <tr>
               <td>User Id</td>
               <td><input type="text" readonly name="userId" value="${order.userId}" /></td>
            </tr>
            <tr>
               <td>Product Id</td>
               <td><input type="text" name="productId" value="${orderDetail.productId}" /></td>
            </tr>
            <tr>
               <td>Amount</td>
               <td><input type="text" name="amount" value="${order.amount}" /></td>
            </tr>
            <tr>
               <td>Purchased quantity</td>
               <td><input type="text" name="purchasedQuantity" value="${orderDetail.purchasedQuantity}" /></td>
            </tr>
            <tr>
               <td>Created time</td>
               <td><input type="text" name="createdTime" value="${order.createdTime}" /></td>
            </tr>
            <tr>
               <td>Payment time</td>
               <td><input type="text" name="paymentTime" value="${order.paymentTime}" /></td>
            </tr>
            <tr>
               <td>Status</td>
               <td><input type="text" name="status" value="${orderDetail.status}" /></td>
            </tr>
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
 
   </body>
</html>
