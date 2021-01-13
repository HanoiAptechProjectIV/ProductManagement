<%-- 
    Document   : index
    Created on : Jan 13, 2021, 7:41:28 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
     <meta charset="UTF-8">
     <title>User Home Page</title>
  </head>
  <body>
 
      <jsp:include page="_header.jsp"></jsp:include><br><br>
     <jsp:include page="_menu.jsp"></jsp:include>
     <br>
      <h2 style="text-align: center;">User Home Page</h2>
      
      This is home page<br><br>
      <b>It includes the following functions for tables:</b>
      <ul>
         <li>View list</li>
         <li>Search</li>
         <li>Create</li>
         <li>Edit</li>
      </ul>
 
     <jsp:include page="_footer.jsp"></jsp:include>
 
  </body>
</html>
