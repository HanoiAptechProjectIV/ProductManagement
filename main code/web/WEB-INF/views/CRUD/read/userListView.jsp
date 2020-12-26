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
 
    <h3>User List</h3>
 
    <p style="color: red;">${errorString}</p>
 
    <table border="1" cellpadding="5" cellspacing="1" >
       <tr>
          <th>Id</th>
          <th>Username</th>
          <th>Password</th>
          <th>Name</th>
          <th>Gender</th>
          <th>Phone</th>
          <th>Email</th>
          <th>Address</th>
       </tr>
       <c:forEach items="${userList}" var="user" >
          <tr>
              <td>${user.id}</td>
             <td>${user.username}</td>
             <td>${user.password}</td>
             <td>${user.name}</td>
             <td>${user.gender}</td>
             <td>${user.phone}</td>
             <td>${user.email}</td>
             <td>${user.address}</td>
          </tr>
       </c:forEach>
    </table>
 
 
    <jsp:include page="../../_footer.jsp"></jsp:include>
 
 </body>
</html>
