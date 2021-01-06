<%-- 
    Document   : editOrderView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

<%@page import="utils.UserDAO"%>
<%@page import="beans.User"%>
<%@page import="java.util.List"%>
<%@page import="beans.OrderDetail"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.Product"%>
<%@page import="utils.MyUtils"%>
<%@page import="java.sql.Connection"%>
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
    <body onload="findMaxValueQuantity();calculateAmount();selectedStatusOption();">

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Edit Order</h3>

            <p style="color: red;">${errorString}</p>
        <%
            Connection conn = MyUtils.getStoredConnection(request);
            List<Product> listProduct = ProductDAO.queryProduct(conn);
            List<OrderDetail> listDetail = (List<OrderDetail>)request.getAttribute("orderDetail");
            Order order = (Order) request.getAttribute("order");
            User user = UserDAO.findUser(conn, order.getUserId());
        %>
        <c:if test="${not empty order && not empty orderDetail && orderDetail != null}">
            <form method="POST" action="${pageContext.request.contextPath}/editOrder">
                <table border="1" >
                    <tr><p>Order</p></tr>
                    <tr>
                        <td>Order id</td>
                        <td><input type="text" readonly name="id" value="${order.id}"/></td>
                    </tr>
                    <tr>
                        <td>User Name</td>
                        <td><input type="hidden" name="userId" value="${order.userId}"/>
                            <a href="userList?search=<%=user.getName()%>"><%=user.getName()%></a></td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td><input id="amountTxt" type="text" readonly name="amount" value="${order.amount}" /></td>
                    </tr>
                    <tr>
                        <td>Created time</td>
                        <td><input type="text" readonly name="createdTime" value="${order.createdTime}" /></td>
                    </tr>
                    <tr>
                        <td>Payment time</td>
                        <td><input id="paymentTimeInput" type="text" name="paymentTime" value="<%
                            LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
                            if (!order.getPaymentTime().equals(ldt)) {
                                   %><%=order.getPaymentTime()%><%}%>" /><br>
                            <input type="button" onclick="getCurrentTime();" value="Get Current Time"/>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <table border="1" cellpadding="5" cellspacing="1" >
                        <tr><p>Order detail</p></tr>
                        <tr>
                            <th>Order Detail Id</th>
                            <th>Product name</th>
                            <th>Price</th>
                            <th>Purchase quantity</th>
                            <th>Status</th>
                        </tr>
                            <%
                                for(OrderDetail detail : listDetail){
                                    pageContext.setAttribute("orderDetail", detail);
                                    Product prod = ProductDAO.findProduct(conn, detail.getProductId());
                                    if (prod != null) {
                                        if (listProduct.size() > 0) {
                            %>
                            <tr>
                                <td><input type="text" readonly name="idOrderDetail${orderDetail.id}" 
                                           value="${orderDetail.id}" /></td>
                                <td><input class="productNameTxt" type="hidden" name="productName${orderDetail.id}" 
                                           value="<%=prod.getName()%>" />
                                    <a class="productNameAnchor" href="productList?search=<%=prod.getName()%>"
                                       ><%=prod.getName()%></a>
                                    <select class="productNameOption" name="productNameOption${orderDetail.id}"
                                            onchange="findMaxValueQuantity();changeProductNameAnchor();calculateAmount();">
                                        <%for (Product product : listProduct) {
                                            if (product.getName().equals(prod.getName())) {%>
                                        <option value="<%=product.getName()%>" selected><%=product.getName()%></option>
                                        <%} else {%>
                                        <option value="<%=product.getName()%>"><%=product.getName()%></option>  
                                        <%}
                                        }%>
                                    </select>  
                                </td>   
                                <td>
                                    <input type="text" readonly value="<%=prod.getPrice()%>" size="10"/>
                                    <h6 style="display: inline">VND</h6>
                                </td>
                                <td><input onchange="calculateAmount();" 
                                           type="number" min="1" max="1" 
                                           name="purchasedQuantity${orderDetail.id}" 
                                           value="${orderDetail.purchasedQuantity}" /></td>
                                <td><input class="statusTxt" type="text" readonly size="10"
                                           name="status${orderDetail.id}" value="${orderDetail.status}" />
                                    <select class="statusOption" name="statusOption${orderDetail.id}" 
                                            onchange="changeStatusText();calculateAmount();">
                                        <option value="Pending">Pending</option>  
                                        <option value="Canceled">Canceled</option>  
                                        <option value="Shipping">Shipping</option>  
                                        <option value="Success">Success</option>  
                                        <option value="Refund">Refund</option>  
                                    </select>  
                                </td>
                            </tr>
                            <%}
                                }
                                }%>
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
        "use strict";
        var i = 0,
            productNameTxts = document.getElementsByClassName("productNameTxt"),
            statusTxts = document.getElementsByClassName("statusTxt"),
            nameOptions = document.getElementsByClassName("productNameOption"),
            statusOptions = document.getElementsByClassName("statusOption"),
            numbers = document.querySelectorAll('input[type="number"]'),
            anchors = document.getElementsByClassName("productNameAnchor"),
            amount = document.getElementById("amountTxt"),
            nameQuantityMap = new Map(),
            namePriceMap = new Map();
    <%
        for (Product product : listProduct) {
    %>
        nameQuantityMap.set("<%=product.getName()%>", <%=product.getQuantity()%>);
        namePriceMap.set("<%=product.getName()%>", <%=product.getPrice()%>);
    <%}%>                

        function getCurrentTime() {
            var date = new Date();
            date.setTime(date.getTime() + 25200000);
            var nowStr = date.toISOString();
            nowStr = nowStr.substring(0, nowStr.lastIndexOf(":") + 3);
            var paymentTime = document.getElementById("paymentTimeInput");
            paymentTime.value = nowStr;
        }

        function findMaxValueQuantity() {
            i = 0;
            Array.prototype.filter.call(nameOptions, function (option) {
                numbers[i].max = nameQuantityMap.get(option.value);
                i++;
            });
        }

        function changeProductNameAnchor(){
            i=0;
            Array.prototype.filter.call(nameOptions, function (option) {
                productNameTxts[i].value = option.value;
                anchors[i].href = "productList?search="+option.value;
                anchors[i].text = option.value;
                i++;
            });
        }

        function changeStatusText(){
            i=0;
            Array.prototype.filter.call(statusOptions, function (option) {
                statusTxts[i].value = option.value;
                i++;
            });
        }

        function calculateAmount(){
            i=0;
            var amountNum = 0;
            Array.prototype.filter.call(nameOptions, function (option) {
                if(statusOptions[i].value !== "Refund" 
                        && statusOptions[i].value !== "Canceled"){
                    amountNum += namePriceMap.get(option.value) * numbers[i].value;
                }
                i++;
            }); 
            amount.value = amountNum;
        }

        function selectedStatusOption(){
    <%
        for(int i =0; i< listDetail.size(); i++){
    %>
            Array.prototype.filter.call(statusOptions[<%=i%>].options, function (option) {
                if(option.value === "<%=listDetail.get(i).getStatus()%>"){
                    option.selected = true;
                }
            });
    <%}%>
        }
</script>

    </body>
</html>
