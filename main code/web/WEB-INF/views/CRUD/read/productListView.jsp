<%-- 
    Document   : productListView
    Created on : Dec 8, 2020, 5:15:13 PM
    Author     : Hung
--%>

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

            <h3>Product List</h3>

            <p style="color: red;">${errorString}</p>

        <table border="0" cellpadding="5" cellspacing="1" >
            <tr>
                <td>Search Product Name</td>
                <td>
                    <form method="POST" action="${pageContext.request.contextPath}/productList">
                        <input type="text" name="search"/>
                        <input type="submit" value="Search"/>
                    </form>
                </td>
            </tr>             
        </table>
                        <br/>
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
                <th>Disable</th>
                <th>Edit</th>
            </tr>
            <c:forEach items="${productList}" var="product" >
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td>${product.image}</td>
                    <td>${product.quantity}</td>
                    <td>${product.description}</td>
                    <td>${product.dateAdded}</td>
                    <td>${product.categoryId}</td>
                    <td>${product.brandId}</td>
                    <td>
                        <c:choose>
                            <c:when test="${product.disable == true}">
                                Không hiển thị
                            </c:when>
                            <c:otherwise>Được hiển thị</c:otherwise>
                        </c:choose>
                        
                    </td>
                    <td>
                        <a href="editProduct?id=${product.id}">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <a href="createProduct" >Create Product</a>

        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
