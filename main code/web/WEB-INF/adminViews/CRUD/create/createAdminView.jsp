<%-- 
    Document   : createAdminView
    Created on : Dec 8, 2020, 5:17:54 PM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>Create Admin</title>
   </head>
   <body>
    
      <jsp:include page="../../_header.jsp"/>
      <jsp:include page="../../_menu.jsp"/>
       
      <h3>Create Admin</h3>
       
      <p style="color: red;">${errorString}</p>
       
      <form method="POST" action="${pageContext.request.contextPath}/admin/createAdmin">
         <table border="0">
            <tr>
               <td>Username</td>
               <td><input type="text" required name="username" value="${admin.username}" /></td>
            </tr>
            <tr>
               <td>Password</td>
               <td><input type="text" required name="password" value="${admin.password}" /></td>
            </tr>
            <tr>
               <td colspan="2">                   
                   <input type="submit" value="Submit" />
                   <a href="adminList">Cancel</a>
               </td>
            </tr>
         </table>
      </form>
       
      <jsp:include page="../../_footer.jsp"/>
       
   </body>
</html>
