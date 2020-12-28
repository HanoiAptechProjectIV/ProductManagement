<%-- 
    Document   : adminListView
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
    <title>Admin List</title>
 </head>
 <body>
 
    <jsp:include page="../../_header.jsp"></jsp:include>
    <jsp:include page="../../_menu.jsp"></jsp:include>
 
    <h3>Admin List</h3>
 
    <p style="color: red;">${errorString}</p>
 
    <table border="1" cellpadding="5" cellspacing="1" >
       <tr>
          <th>Username</th>
          <th>Password</th>
          <th>Edit</th>
          <th>Delete</th>
       </tr>
       <c:forEach items="${adminList}" var="admin" >
          <tr>
             <td>${admin.username}</td>
             <td>${admin.password}</td>
             <td>
                <a href="editAdmin?username=${admin.username}">Edit</a>
             </td>
             <td>
                <a href="deleteAdmin?username=${admin.username}">Delete</a>
             </td>
          </tr>
       </c:forEach>
    </table>
 
    <a href="createAdmin" >Create Admin</a>
 
    <jsp:include page="../../_footer.jsp"></jsp:include>
 
 </body>
</html>
