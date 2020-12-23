<%-- 
    Document   : _userInfoView
    Created on : Dec 8, 2020, 5:44:06 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <meta charset="UTF-8">
    <title>User Info</title>
 </head>
 <body>
 
    <jsp:include page="../../_header.jsp"></jsp:include>
    <jsp:include page="../../_menu.jsp"></jsp:include>
 
    <h3>Hello: ${user.username}</h3>
 
    User Name: <b>${user.username}</b>
    <br />
    Password: ${user.password } <br />
 
    <jsp:include page="../../_footer.jsp"></jsp:include>
 
 </body>
</html>
