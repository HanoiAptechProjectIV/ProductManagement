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
 
      <h3 style="text-align: center; margin-top: 40px">Edit Admin</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <div class="container">
         <c:if test="${admin != null}">
         <form method="POST" action="${pageContext.request.contextPath}/editAdmin">
            <div class="form-group w-50">             
               <label>Username</label>
                   <c:if test="${oldUsername == null}">
                   <input class="form-control" type="text" hidden name="oldUsername" value="${admin.username}" />
                   </c:if>
                   <c:if test="${oldUsername != null}">
                   <input class="form-control" type="text" hidden name="oldUsername" value="${oldUsername}" />
                   </c:if>
                   <input class="form-control" type="text" required name="username" value="${admin.username}" />
            </div>
            <div class="form-group w-50">
               <label>Password</label>
               <input class="form-control" type="text" required name="password" value="${admin.password}" />
            </div>
            <div>
               <button class="btn btn-outline-success" type="submit">Submit</button>
               <a href="${pageContext.request.contextPath}/adminList" class="btn btn-outline-warning">Cancel</a>
            </div>
         </form>
      </c:if>
      </div>
 
      <jsp:include page="../../_footer.jsp"></jsp:include>
 
   </body>
</html>
