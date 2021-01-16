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

   <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

      <!-- jQuery library -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      <!-- Popper JS -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

      <!-- Latest compiled JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

   <body>
    
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
       
      <h3 style="text-align: center; margin-top: 40px">Create Admin</h3>
       
      <p style="color: red;">${errorString}</p>
       
      <div class="container">
         <form method="POST" action="${pageContext.request.contextPath}/createAdmin">
            <div class="form-group w-50">
               <label>Username</label>
               <input class="form-control" type="text" required name="username" value="${admin.username}" />
            </div>
            <div class="form-group w-50">
               Password
               <input class="form-control" type="text" required name="password" value="${admin.password}" />
            </div>
            <div>                 
               <button type="submit" class="btn btn-outline-success">Submit</button>
               <a href="adminList" class="btn btn-outline-warning">Cancel</a>
            </div>
      </form>
      </div>
       
      <jsp:include page="../../_footer.jsp"></jsp:include>
       
   </body>
</html>
