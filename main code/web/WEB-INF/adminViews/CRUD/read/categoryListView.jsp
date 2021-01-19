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

        <jsp:include page="../../_header.jsp"/>
        <jsp:include page="../../_menu.jsp"/>

            <h3>Category List Page ${page}</h3>

            <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"/>
            <table border="1" cellpadding="5" cellspacing="1" >
                <tr>
                <c:set var="pageNum" value="${(page != null) ? page : 1}"/>
                    <th>
                        Id 
                        <a href="${pageContext.request.contextPath}/admin/categoryList?page=${pageNum}&sortBy=idASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/categoryList?page=${pageNum}&sortBy=idDESC"
                        ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>Name
                        <a href="${pageContext.request.contextPath}/admin/categoryList?page=${pageNum}&sortBy=nameASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/categoryList?page=${pageNum}&sortBy=nameDESC"
                        ><i class="fa fa-angle-down"></i></a>                    
                    </th>
                    <th>Description</th>
                    <th>Display (or disable)
                        <a href="${pageContext.request.contextPath}/admin/categoryList?page=${pageNum}&sortBy=disableASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/categoryList?page=${pageNum}&sortBy=disableDESC"
                        ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>Edit</th>
                </tr>
                <c:if test="${categoryList.size() > 0}">
            <c:forEach items="${categoryList}" var="category" >
                <c:if test="${category != null}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                    <td>${category.description}</td>
                    <td>
                        <c:choose>
                            <c:when test="${category.disable == true}">
                                Disabled
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
                </c:if>
        </table>

        <jsp:include page="../../_pagination.jsp"/>
        <jsp:include page="../../_footer.jsp"/>
        <script>
            
        </script>
    </body>
</html>
