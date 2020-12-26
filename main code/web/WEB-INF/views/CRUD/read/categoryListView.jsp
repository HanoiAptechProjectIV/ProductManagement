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
 
    <h3>Category List</h3>
 
    <p style="color: red;">${errorString}</p>
 
    <table border="1" cellpadding="5" cellspacing="1" >
       <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Description</th>
          <th>Edit</th>
          <th>Delete</th>
       </tr>
       <c:forEach items="${categoryList}" var="category" >
          <tr>
             <td>${category.id}</td>
             <td>${category.name}</td>
             <td>${category.description}</td>
             <td>
                <a href="editCategory?id=${category.id}">Edit</a>
             </td>
             <td>
                <a href="deleteCategory?id=${category.id}">Delete</a>
             </td>
          </tr>
       </c:forEach>
    </table>
 
    <a href="createCategory" >Create Category</a>
 
    <jsp:include page="../../_footer.jsp"></jsp:include>
 
 </body>
</html>
