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

   <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

      <!-- jQuery library -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      <!-- Popper JS -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

      <!-- Latest compiled JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

 </head>
 <body>
 
    <jsp:include page="../../_header.jsp"></jsp:include>
    <jsp:include page="../../_menu.jsp"></jsp:include>
 
    <h3 style="text-align: center; margin-top: 40px">Admin List</h3>
 
    <p style="color: red;">${errorString}</p>

    <div class="container">
       <a class="btn btn-outline-primary" href="createAdmin" style="margin-bottom: 20px;" >Create Admin</a>
       <table class="table table-bordered table-striped table-hover" border="1" cellpadding="5" cellspacing="1" >
       <tr class="table-info">
          <th>Username</th>
          <th>Password</th>
          <th>Edit</th>
          <th>Delete</th>
       </tr>
       <c:if test="${adminList.size() > 0}">
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
       </c:if>
    </table>
    </div>

    <jsp:include page="../../_footer.jsp"></jsp:include>
 
 </body>
</html>
