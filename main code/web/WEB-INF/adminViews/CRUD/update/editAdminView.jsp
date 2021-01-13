<%-- 
    Document   : editAdminView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>Edit Admin</title>
   </head>
   <body>
 
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
 
      <h3>Edit Admin</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <c:if test="${admin != null}">
         <form method="POST" action="${pageContext.request.contextPath}/editAdmin">
            <table border="0">
            <tr>             
               <td>Username</td>
               <td>
                   <c:if test="${oldUsername == null}">
                   <input type="text" hidden name="oldUsername" value="${admin.username}" />
                   </c:if>
                   <c:if test="${oldUsername != null}">
                   <input type="text" hidden name="oldUsername" value="${oldUsername}" />
                   </c:if>
                   <input type="text" required name="username" value="${admin.username}" /></td>
            </tr>
            <tr>
               <td>Password</td>
               <td><input type="text" required name="password" value="${admin.password}" /></td>
            </tr>
            <tr>
               <td colspan = "2">
                   <input type="submit" value="Submit" />
                   <a href="${pageContext.request.contextPath}/adminList">Cancel</a>
               </td>
            </tr>
            </table>
         </form>
      </c:if>
 
      <jsp:include page="../../_footer.jsp"></jsp:include>
 
   </body>
</html>
