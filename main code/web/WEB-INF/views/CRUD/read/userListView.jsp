<%-- 
    Document   : _userInfoView
    Created on : Dec 8, 2020, 5:44:06 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Info</title>
    </head>
    <body>

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>User List Page ${page}</h3>

            <p style="color: red;">${errorString}</p>
        <jsp:include page="../../_search.jsp"></jsp:include>
            <table border="1" cellpadding="5" cellspacing="1" >
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Gender</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Address</th>
                </tr>
                <c:if test="${userList.size()>0}">
            <c:forEach items="${userList}" var="user" >
                <c:if test="${user != null}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.username}</td>
                    <td>${user.password}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.gender == true}">
                                Female
                            </c:when>
                            <c:when test="${user.gender == false}">
                                Male
                            </c:when>
                        </c:choose>

                    </td>
                    <td>${user.phone}</td>
                    <td>${user.email}</td>
                    <td>${user.address}</td>
                </tr>
                </c:if>
            </c:forEach>
                </c:if>
        </table>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
