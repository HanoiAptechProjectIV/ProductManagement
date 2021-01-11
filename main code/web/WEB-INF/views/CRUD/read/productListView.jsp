<%-- 
    Document   : productListView
    Created on : Dec 8, 2020, 5:15:13 PM
    Author     : Hung
--%>

<%@page import="utils.BrandDAO"%>
<%@page import="beans.Brand"%>
<%@page import="beans.Category"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page import="beans.Product"%>
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

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Product List Page ${page}</h3>

        <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"></jsp:include>
        
        <table border="1" cellpadding="5" cellspacing="1" >
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Price</th>
                <th>Image</th>
                <th>Quantity</th>
                <th>Description</th>
                <th>Date added</th>
                <th>Category id</th>
                <th>Brand id</th>
                <th>Display (or disable)</th>
                <th>Edit</th>
            </tr>
            <c:if test="${productList.size() > 0}">
            <c:forEach items="${productList}" var="product" >
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td><img src="${pageContext.request.contextPath}/images/product/${product.image}"
                             height="50" alt="${product.name} image"/></td>
                    <td>${product.quantity}</td>
                    <td>${product.description}</td>
                    <td>${product.dateAdded}</td>
                        <%
                            Connection conn = MyUtils.getStoredConnection(request);
                            Product product = (Product)pageContext.getAttribute("product");
                            Category cate = CategoryDAO.findCategory(conn, product.getCategoryId());
                            Brand bra = BrandDAO.findBrand(conn, product.getBrandId());
                        %>
                    <td>
                        <div id="categoryAnchor">
                            <a href="categoryList?search=<%=cate.getName()%>"><%=cate.getName()%></a>
                        </div>
                            <div id="categoryDiv">
                                <p><%=cate.getDescription()%></p>
                                <p><%=(cate.isDisable()) ? "disabled": "displayed"%></p>
                            </div>
                    </td>
                    <td>
                        <div id="brandAnchor">
                            <a href="brandList?search=<%=bra.getName()%>"><%=bra.getName()%></a>
                        </div>
                            <div id="brandDiv">
                                <img src="${pageContext.request.contextPath}/images/brand/<%=bra.getLogo()%>"
                                     alt="<%=bra.getName()%> Logo" height="30"/>
                                <p><%=bra.getManufacturer()%></p>
                                <p><%=bra.getDescription()%></p>
                                <p><%=(bra.isDisable()) ? "disabled": "displayed"%></p>
                            </div>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${product.disable == true}">
                                Disabled
                            </c:when>
                            <c:when test="${product.disable == false}">Displayed</c:when>
                        </c:choose>

                    </td>
                    <td>
                        <a href="editProduct?id=${product.id}">Edit</a>
                    </td>
                </tr>
            </c:forEach>
            </c:if>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>
        <style>
            #categoryAnchor, #brandAnchor {
                height: 39px;
                padding-top: 10px;
            }
            #categoryDiv, #brandDiv{display:none}
            #categoryAnchor:hover + #categoryDiv{display: block}
            #brandAnchor:hover + #brandDiv{display: block}
            #categoryDiv p, #brandDiv p{height: fit-content; width: fit-content; margin: 0px}
            #brandDiv img{height: 30px; margin: 0px;}
        </style>
    </body>
</html>
