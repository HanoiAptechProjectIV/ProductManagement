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

            <h3 style="text-align: center; margin-top: 40px">User List Page ${page}</h3>

            <p style="color: red;">${errorString}</p>
        <jsp:include page="../../_search.jsp"></jsp:include>
            
        <div class="container">
            <table class="table table-bordered table-striped table-hover" border="1" cellpadding="5" cellspacing="1" >
                <tr class="table-info">
                    <c:set var="pageNum" value="${(page != null) ? page : 1}"/>
                    <th>Id
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=idASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=idDESC"
                        ><i class="fa fa-angle-down"></i></a>
                    </th>
                    <th>Name
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=nameASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=nameDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Gender
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=genderASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=genderDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Phone
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=phoneASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=phoneDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Email
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=emailASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=emailDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
                    <th>Address
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=addressASC"
                        ><i class="fa fa-angle-up"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/userList?page=${pageNum}&sortBy=addressDESC"
                        ><i class="fa fa-angle-down"></i></a>   
                    </th>
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
        </div>

        <jsp:include page="../../_pagination.jsp"></jsp:include>
        <jsp:include page="../../_footer.jsp"></jsp:include>

    </body>
</html>
