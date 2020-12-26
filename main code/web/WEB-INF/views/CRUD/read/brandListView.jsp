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
 
    <h3>Brand List</h3>
 
    <p style="color: red;">${errorString}</p>
 
    <table border="1" cellpadding="5" cellspacing="1" >
       <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Logo</th>
          <th>Manufacturer</th>
          <th>Description</th>
          <th>Edit</th>
          <th>Delete</th>
       </tr>
       <c:forEach items="${brandList}" var="brand" >
          <tr>
             <td>${brand.id}</td>
             <td>${brand.name}</td>
             <td>${brand.logo}</td>
             <td>${brand.manufacturer}</td>
             <td>${brand.description}</td>
             <td>
                <a href="editBrand?id=${brand.id}">Edit</a>
             </td>
             <td>
                <a href="deleteBrand?id=${brand.id}">Delete</a>
             </td>
          </tr>
       </c:forEach>
    </table>
 
    <a href="createBrand" >Create Brand</a>
 
    <jsp:include page="../../_footer.jsp"></jsp:include>
 
 </body>
</html>
