<%-- 
    Document   : productsView
    Created on : Jan 15, 2021, 2:39:08 PM
    Author     : Hung
--%>

<%@page import="servletUserSide.cart.CartServlet"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.CartItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.BrandDAO"%>
<%@page import="beans.Brand"%>
<%@page import="beans.Category"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="beans.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
    </head>
    <body>

        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <p style="color: red;">${errorString}</p>
            <section class="main-content">
                <div class="row">
                    <div class="span12">
                        <div class="row">
                            <div class="span9">

                                <h4 class="title">
                                    <span class="pull-left"><span class="text"><span class="line">${title}<strong> List</strong></span></span></span>
                                </h4>

                                <ul class="thumbnails listing-products">	
                                    <%
                                        Connection conn = MyUtils.getStoredConnection(request);
                                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                                        List<CartItem> cart = null;
                                        if (session.getAttribute("cart") != null) {
                                            cart = (List<CartItem>) session.getAttribute("cart");
                                        }
                                        for (Product prod : productList) {
                                    %>
                                    <li class="span3" style="min-height: 300px;">
                                        <div class="product-box" style="min-height: inherit;">

                                            <p><a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                                  ><img src="<%=prod.getImage()%>"
                                                      style='min-height: 250px; max-height: 250px; object-fit: cover'
                                                      alt="<%=prod.getName()%> image" /></a>
                                            </p>
                                            <%
                                                Category cate = CategoryDAO.findCategory(conn, prod.getCategoryId());
                                                Brand bra = BrandDAO.findBrand(conn, prod.getBrandId());
                                            %>
                                            <a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                               class="title"><%=prod.getName()%></a><br/>
                                            <a href="${pageContext.request.contextPath}/brands?search=<%=bra.getName()%>"
                                               class="category"><%=bra.getName()%></a><br>
                                            <a href="${pageContext.request.contextPath}/categories?search=<%=cate.getName()%>"
                                               class="brand"><%=cate.getName()%></a><br/>
                                            <p><span class="error"><%=prod.getPrice()%> VND</span><br>
                                            <% if(prod.getQuantity() > 0){%>
                                            <span class="price"><%=prod.getQuantity()%> left</span><br>
                                            <%} else {%>
                                            <span class="price">Out of stock</span><br>
                                            <%}%>
                                            </p>
                                            <%
                                                if(prod.getQuantity() > 0){
                                                if (cart == null || cart.isEmpty()) {
                                            %>
                                            <a href="cart?action=buy&id=<%=prod.getId()%>"
                                               ><button id="btnAdd<%=prod.getId()%>" class="btn">Add to cart</button></a>
                                            <%} else {%>
                                            <a href="cart?action=buy&id=<%=prod.getId()%>"
                                               ><button id="btnAdd<%=prod.getId()%>" class="btn">Add to cart</button></a>                                            
                                            <%for (CartItem item : cart) {
                                                    if (item.getProduct().getId() == prod.getId()) {
                                            %>
                                            <a href="cart?action=remove&id=<%=prod.getId()%>"
                                               ><button id="btnRemove<%=prod.getId()%>" class="btn">Remove from cart</button></a>                                          
                                            <% break;
                                                } %>
                                            <%}%>
                                            <%}%>
                                            <%}%>
                                        </div>
                                    </li>
                                    <%}%>
                                </ul>

                                <jsp:include page="../_pagination.jsp"/>
                            </div>		
                            <jsp:include page="../_rightMenu.jsp"/>
                        </div>
                        <br/>            
                    </div>
                </div>
            </section>

            <jsp:include page="../_footer.jsp"/>
        </div>

    </body>
</html>

