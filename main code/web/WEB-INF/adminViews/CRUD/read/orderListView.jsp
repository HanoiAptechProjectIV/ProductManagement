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

            <h3 style="text-align: center; margin-top: 40px">Order List Page ${page}</h3>

        <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"></jsp:include>
            
        <div class="container">
            <div class='span12'>
            <table class="" border="1" cellpadding="5" cellspacing="1" >
                <tr class="">
                    <c:set var="pageNum" value="${(page != null) ? page : 1}"/>
                    <th>Id
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=idASC"
                           ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=idDESC"
                           ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>User name
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=user_idASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=user_idDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Amount
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=amountASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=amountDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Product name
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=product_idASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=product_idDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Price</th>
                    <th>Purchase quantity
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=purchased_quantityASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=purchased_quantityDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Status
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=statusASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=statusDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Created time
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=created_timeASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=created_timeDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Payment time
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=payment_timeASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/orderList?page=${pageNum}&sortBy=payment_timeDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Edit</th>
                </tr>
            <c:if test="${orderList.size() > 0}">
            <c:forEach items="${orderList}" var="order" >
                <tr>
                    <td>${order.id}</td>
                    <%
                        Connection conn = MyUtils.getStoredConnection(request);
                        Order order = (Order) pageContext.getAttribute("order");
                        String sortBy = ((String)request.getAttribute("sortBy") != null) 
                                ? (String)request.getAttribute("sortBy") : "idASC";
                        String ordinal = (sortBy.contains("ASC")) ? "ASC" : "DESC";
                        String abridgedSortBy = sortBy.substring(0, sortBy.lastIndexOf(ordinal));
                        if(abridgedSortBy.equals("id")
                            || abridgedSortBy.equals("user_id")
                            || abridgedSortBy.equals("amount")
                            || abridgedSortBy.equals("created_time")
                            || abridgedSortBy.equals("payment_time")){
                            abridgedSortBy = "product_id";
                            ordinal ="ASC";
                        }                        
                        List<OrderDetail> listDetail = OrderDetailDAO
                                .findOrderDetailList(conn, order.getId(), abridgedSortBy, ordinal);
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
                            <img src="<%=prod.getImage()%>" 
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
        </div>
        </div>

        <jsp:include page="../../_pagination.jsp"/>
        <jsp:include page="../../_footer.jsp"/>
        <style>
            #productAnchor{
            }
            #userAnchor{
                height: 80px;
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
            .container{
                width: 100%;
                min-width: max-content;
            }
        </style>          

    </body>
</html>
