<%-- 
    Document   : categoryListView
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
        <title>Category List</title>
    </head>
    <body>

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Category List Page ${page}</h3>

            <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"></jsp:include>
            <table border="1" cellpadding="5" cellspacing="1" >
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Display</th>
                    <th>Edit</th>
                </tr>
            <c:forEach items="${categoryList}" var="category" >
                <c:if test="${category != null}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                    <td>${category.description}</td>
                    <td>
                        <c:choose>
                            <c:when test="${category.disable == true}">
                                Not displayed
                            </c:when>
                                <c:when test="${category.disable == false}">Displayed</c:when>
                        </c:choose>                 
                    </td>
                    <td>
                        <a href="editCategory?id=${category.id}">Edit</a>
                    </td>
                </tr>
                </c:if>
            </c:forEach>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
