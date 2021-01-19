<%-- 
    Document   : deleteCategoryErrorView
    Created on : Dec 8, 2020, 5:21:20 PM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
 <head>
    <meta charset="UTF-8">
    <title>Delete Category</title>
 </head>
 
 <body>
 
    <jsp:include page="../../_header.jsp"/>
    <jsp:include page="../../_menu.jsp"/>
    
    <h3>Delete Category</h3>
    
    <p style="color: red;">${errorString}</p>
    <a href="categoryList">Category List</a>
    
    <jsp:include page="../../_footer.jsp"/>
    
 </body>
</html>
