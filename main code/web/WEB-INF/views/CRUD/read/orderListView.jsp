<%-- 
    Document   : orderListView
    Created on : Dec 8, 2020, 5:15:13 PM
    Author     : Hung
--%>

<%@page import="beans.User"%>
<%@page import="utils.UserDAO"%>
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
            <c:if test="${orderList.size() > 0}">
            <c:forEach items="${orderList}" var="order" >
                <tr>
                    <td>${order.id}</td>
                    <%
                        Connection conn = MyUtils.getStoredConnection(request);
                        Order order = (Order) pageContext.getAttribute("order");
                        List<OrderDetail> listDetail = OrderDetailDAO.findOrderDetailList(conn, order.getId());
                        User user = UserDAO.findUser(conn, order.getUserId());
                        Product prod = new Product();
                    %>    
                    <td>
                        <div id="userAnchor">
                            <a href="userList?search=<%=user.getName()%>"><%=user.getName()%></a>
                        </div>
                        <div id="userDiv">
                            <p>Gender: <%=(user.isGender()) ? "Female" : "Male"%></p>
                            <p>Phone: <%=user.getPhone()%></p>
                            <p>Email: <%=user.getEmail()%></p>
                            <p>Address: <%=user.getAddress()%></p>
                        </div>
                    </td>
                    <td>${order.amount}</td>
                    <td>
                        <%
                            for (OrderDetail detail : listDetail) {
                                prod = ProductDAO.findProduct(conn, detail.getProductId());
                                if (prod != null) {
                        %>
                        <div id="productAnchor">
                            <a href="productList?search=<%=prod.getName()%>"><%=prod.getName()%></a>
                        </div>
                        <div id="productDiv">
                            <img src="${pageContext.request.contextPath}/images/product/<%=prod.getImage()%>" 
                                 height="30" alt="<%=prod.getName()%> image"/>
                            <p> | Quantity: <%=prod.getQuantity()%></p>
                        </div>
                        <hr>
                        <%}}%>
                    </td>
                    <td>
                    <%
                        for (OrderDetail detail : listDetail) {
                            prod = ProductDAO.findProduct(conn, detail.getProductId());
                            if (prod != null) {
                    %>                        
                        <%=prod.getPrice()%><hr>
                    <%}}%>
                    </td>
                    <td>
                    <%
                        for (OrderDetail detail : listDetail) {
                    %>
                        <%=detail.getPurchasedQuantity()%><hr>
                    <%}%>
                    </td>
                    <td>
                    <%
                        for (OrderDetail detail : listDetail) {
                    %>                        
                        <%=detail.getStatus()%><hr>
                    <%}%>
                    </td>
                    <td>${order.createdTime}</td>
                    <td><%
                        LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
                        if(!order.getPaymentTime().equals(ldt)){
                        %>
                            <%=order.getPaymentTime()%>
                        <%   
                        }
                        %></td>
                    <td>

                        <a href="editOrder?id=${order.id}">Edit</a>
                    </td>                              
                </tr>
            </c:forEach>
            </c:if>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>
        <style>
            #productAnchor{
                margin-left: 23px;
                width: fit-content;
            }
            #userAnchor{
                height: 50px;
                width: fit-content;
                padding-top: 23px;
            }
            #userDiv, #productDiv{display:none}
            #userAnchor:hover + #userDiv, #productAnchor:hover + #productDiv{display: block; margin: 0px}
            #userDiv p, #productDiv p{ height: fit-content; width: fit-content; margin: 0px; padding: 0px}
            #productDiv img{
                height: 30px; margin-bottom: -8px;
            }
            #productDiv p, #product img{display:inline;}
        </style>          

    </body>
</html>
