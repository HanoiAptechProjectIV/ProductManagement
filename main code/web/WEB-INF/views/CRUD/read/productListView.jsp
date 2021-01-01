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
                <th>Display</th>
                <th>Edit</th>
            </tr>
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
                    <td>
                        <c:forEach items="${categoryList}" step="2" var="category">
                            <a href="categoryList?search=${category.name}" >${category.name}</a>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach items="${brandList}" step="2" var="brand">
                            <a href="brandList?search=${brand.name}">${brand.name}</a>
                        </c:forEach>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${product.disable == true}">
                                Not displayed
                            </c:when>
                            <c:when test="${product.disable == false}">Displayed</c:when>
                        </c:choose>

                    </td>
                    <td>
                        <a href="editProduct?id=${product.id}">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>
    </body>
</html>
