<%-- 
    Document   : createBrandView
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
      <title>Create Brand</title>
   </head>
   <body>
    
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
       
      <h3 style="text-align: center; margin-top: 40px">Create Brand</h3>
       
      <p style="color: red;">${errorString}</p>
       
      <div class="container">
         <form method="POST" action="${pageContext.request.contextPath}/admin/createBrand" enctype="multipart/form-data">
            <div class="form-group w-50">
               <label>Name</label>
               <input type="text" required name="name" value="${brand.name}"  class="form-control"/>
            </div>
            <div class="form-group w-50">
               <label>Logo</label>
               <input type="file" name="logo"  class="form-control"/>
            </div>           
            <div class="form-group w-50">
               <label>Manufacturer</label>
               <input type="text" name="manufacturer" value="${brand.manufacturer}"  class="form-control"/>
            </div>
            <div class="form-group w-50">
               <label>Description</label>
               <input type="text" name="description" value="${brand.description}"  class="form-control"/>
            </div>
            <div>                
               <button class="btn btn-outline-success" type="submit">Submit</button>
               <a href="brandList" class="btn btn-outline-warning">Cancel</a>
            </div>
      </form>
      </div>
       
      <jsp:include page="../../_footer.jsp"></jsp:include>
       
   </body>
</html>
