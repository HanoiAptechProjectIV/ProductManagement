<%-- 
    Document   : _mainContent
    Created on : Jan 15, 2021, 2:22:28 AM
    Author     : Hung
--%>

<%@page import="beans.CartItem"%>
<%@page import="utils.BrandDAO"%>
<%@page import="beans.Brand"%>
<%@page import="beans.Category"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="beans.Product"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<section class="main-content">
    <div class="row">
        <div class="span12">
            <%
                Connection conn = MyUtils.getStoredConnection(request);
                Map<String, List<Product>> returnedListsMap = (Map<String, List<Product>>) request.getAttribute("lists");
                List<CartItem> cart = null;
                if (session.getAttribute("cart") != null) {
                    cart = (List<CartItem>) session.getAttribute("cart");
                }
                int count=0;
                for (Map.Entry<String, List<Product>> entry : returnedListsMap.entrySet()) {
                    count++;
            %>
            <div class="row">
                <div class="span12">

                    <h4 class="title">
                        <span class="pull-left"><span class="text"><span class="line"><%=entry.getKey()%><strong> Products</strong></span></span></span>
                        <span class="pull-right">
                            <a class="left button" href="#myCarousel<%=count%>" data-slide="prev"></a>
                            <a class="right button" href="#myCarousel<%=count%>" data-slide="next"></a>
                        </span>
                    </h4>

                    <div id="myCarousel<%=count%>" class="myCarousel carousel slide">
                        <div class="carousel-inner">
                            <div class="active item">
                                <ul class="thumbnails">	
                                    <%
                                        for (int i = 0; i < entry.getValue().size(); i++) {
                                            Product prod = entry.getValue().get(i);
                                    %>
                                    <li class="span3" style="min-height: 420px;">
                                        <div class="product-box" style="min-height: inherit;">

                                            <p><a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                                  ><img src="<%=prod.getImage()%>" height="100"
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
                                            <%}%>
                                            <%}%>
                                            <%}%>
                                            <%}%>
                                        </div>
                                    </li>
                                    <%if (i == 3) {
                                                break;
                                    }%>
                                    <%}%>
                                </ul>
                            </div>

                            <div class="item">
                                <ul class="thumbnails">
                                    <%
                                        for (int i = 4; i < entry.getValue().size(); i++) {
                                            Product prod = entry.getValue().get(i);
                                    %>
                                    <li class="span3" style="min-height: 420px;">
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
                                            <%}%>
                                            <%}%>
                                            <%}%>
                                            <%}%>

                                        </div>
                                    </li>
                                    <%if (i == 7) {
                                                break;
                                    }%>
                                    <%}%>
                                </ul>                                    
                            </div>
                        </div>							
                    </div>

                </div>						
            </div>
            <br/>            
            <%}%>
        </div>
    </div>
</section>
