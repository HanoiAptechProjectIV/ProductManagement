<%-- 
    Document   : historyView
    Created on : Jan 20, 2021, 8:30:12 AM
    Author     : Hung
--%>
<%@page import="utils.MyUtils"%>
<%@page import="beans.Order"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.OrderDetailDAO"%>
<%@page import="utils.UserDAO"%>
<%@page import="beans.User"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.OrderDetail"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="beans.Product"%>
<%@page import="beans.CartItem"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <c:set value="${page}" var="pageNum"/>
            <%
                String pageNumStr = ""+pageContext.getAttribute("pageNum");
                String maxPageStr = ""+request.getAttribute("pageQuantity");
                int pageNum = Integer.parseInt(pageNumStr);
                int maxPage = Integer.parseInt(maxPageStr);
                int previousPage = pageNum-1;
                int nextPage = pageNum+1;
                
                User loginedUser = (User)session.getAttribute("loginedUser");
                String href = "history?userId="+loginedUser.getId()+"&page=";                
                
                String errorString = (String) request.getAttribute("errorString");
                if (errorString != null) {
                    if (errorString.equals("The transaction has been created, currently pending")) {
            %>
            <p class="center" style="color: green;"><%=errorString%></p>
            <%} else {%>
            <p class="center" style="color: red;"><%=errorString%></p>
            <%}
            } else {%>

            <section class="main-content">
                <div class="row">
                    <div class="span12">
                        <div class='row'>
                            <div class="span1">
                                <%
                                    if(previousPage >= 1){
                                %>
                                <a href="<%=(href+previousPage)%>&sortBy=${sortBy}"
                                                  ><i id="previous-button" style="font-size:48px;" class="fa fa-angle-left" 
                                    aria-hidden="true"></i></a>
                                <%}%>
                            </div>
                            <div class="span10">
                                <table id='my-table' class="table-striped" border='1' cellpadding="5" cellspacing="1" >
                                    <tr>
                                        <c:set var="pageNum" value="${(page != null) ? page : 1}"/>
                                        <th>Id</th>
                                        <th>User name</th>
                                        <th>Amount
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=amountASC"
                                               ><i class="fa fa-angle-up"></i></a>
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=amountDESC"
                                               ><i class="fa fa-angle-down"></i></a>   
                                        </th>
                                        <th>Product name
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=product_idASC"
                                               ><i class="fa fa-angle-up"></i></a>
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=product_idDESC"
                                               ><i class="fa fa-angle-down"></i></a>   
                                        </th>
                                        <th>Price</th>
                                        <th>Purchase quantity
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=purchased_quantityASC"
                                               ><i class="fa fa-angle-up"></i></a>
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=purchased_quantityDESC"
                                               ><i class="fa fa-angle-down"></i></a>   
                                        </th>
                                        <th>Status
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=statusASC"
                                               ><i class="fa fa-angle-up"></i></a>
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=statusDESC"
                                               ><i class="fa fa-angle-down"></i></a>   
                                        </th>
                                        <th>Created time
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=created_timeASC"
                                               ><i class="fa fa-angle-up"></i></a>
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=created_timeDESC"
                                               ><i class="fa fa-angle-down"></i></a>   
                                        </th>
                                        <th>Payment time
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=payment_timeASC"
                                               ><i class="fa fa-angle-up"></i></a>
                                            <a href="${pageContext.request.contextPath}/history?userId=${loginedUser.id}&page=${pageNum}&sortBy=payment_timeDESC"
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
                                                    String sortBy = ((String) request.getAttribute("sortBy") != null)
                                                            ? (String) request.getAttribute("sortBy") : "idASC";
                                                    String ordinal = (sortBy.contains("ASC")) ? "ASC" : "DESC";
                                                    String abridgedSortBy = sortBy.substring(0, sortBy.lastIndexOf(ordinal));
                                                    if (abridgedSortBy.equals("id")
                                                            || abridgedSortBy.equals("user_id")
                                                            || abridgedSortBy.equals("amount")
                                                            || abridgedSortBy.equals("created_time")
                                                            || abridgedSortBy.equals("payment_time")) {
                                                        abridgedSortBy = "product_id";
                                                        ordinal = "ASC";
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
                                                        <img src="${pageContext.request.contextPath}/images/product/<%=prod.getImage()%>" 
                                                             height="30" alt="<%=prod.getName()%> image"/>
                                                        <p> | Quantity: <%=prod.getQuantity()%></p>
                                                    </div>
                                                    <hr>
                                                    <%}
                                                }%>
                                                </td>
                                                <td>
                                                    <%
                                                        for (OrderDetail detail : listDetail) {
                                                            prod = ProductDAO.findProduct(conn, detail.getProductId());
                                                            if (prod != null) {
                                                    %>                        
                                                    <%=prod.getPrice()%><hr>
                                                    <%}
                                                }%>
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
                                                    if (!order.getPaymentTime().equals(ldt)) {
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
                                               <hr>
                            </div>
                            <div class="span1">
                                <%
                                    if(nextPage <= maxPage){
                                %>
                                <a href="<%=(href+nextPage)%>&sortBy=${sortBy}"
                                                  ><i id="next-button" style="font-size:48px;" class="fa fa-angle-right" 
                                    aria-hidden="true"></i></a>
                                <%}%>
                            </div>
                        </div>
                        <jsp:include page="../_pagination.jsp"/>
                    </div>
                </div>
            </section>

            <%}%>
            <jsp:include page="../_footer.jsp"/>
        </div> 
<%
    Connection conn = MyUtils.getStoredConnection(request);
    Order order = ((List<Order>)request.getAttribute("orderList")).get(0);
    List<OrderDetail> ldt = OrderDetailDAO
            .findOrderDetailList(conn, order.getId(), "id", "DESC");
    double marginTop = ((ldt.size()+0.95)*60/2)-10;
%>        
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
            #previous-button, #next-button{
                margin-top: <%=marginTop%>px;
                margin-left: 25px;
            }
            #my-table{
                width: inherit;
            }    
        </style> 
    </body>
</html>
