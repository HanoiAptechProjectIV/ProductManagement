<%-- 
    Document   : brandListView
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
        <title>Brand List</title>
    </head>
    <body>

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Brand List Page ${page}</h3>

            <p style="color: red;">${errorString}</p>

        <jsp:include page="../../_search.jsp"></jsp:include>
            <table border="1" cellpadding="5" cellspacing="1" >
                <tr>
                    <c:set var="pageNum" value="${(page != null) ? page : 1}"/>
                    <th>Id
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=idASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=idDESC"
                        ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>Name
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=nameASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=nameDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Logo</th>
                    <th>Manufacturer
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=manufacturerASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=manufacturerDESC"
                        ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>Description</th>
                    <th>Display (or disable)
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=disableASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/brandList?page=${pageNum}&sortBy=disableDESC"
                        ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>Edit</th>
                </tr>
            <c:if test="${brandList.size() > 0}">
            <c:forEach items="${brandList}" var="brand" >
                <c:if test="${brand != null}">
                <tr>
                    <td>${brand.id}</td>
                    <td>${brand.name}</td>
                    <td><img src="${pageContext.request.contextPath}/images/brand/${brand.logo}" 
                             height="30" alt="${brand.name} logo"/></td>
                    <td>${brand.manufacturer}</td>
                    <td>${brand.description}</td>
                    <td>
                        <c:choose>
                            <c:when test="${brand.disable == true}">
                                Disabled
                            </c:when>
                            <c:when test="${brand.disable == false}">
                                Displayed
                            </c:when>
                        </c:choose>             
                    </td>
                    <td>
                        <a href="editBrand?id=${brand.id}">Edit</a>
                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </c:if>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
