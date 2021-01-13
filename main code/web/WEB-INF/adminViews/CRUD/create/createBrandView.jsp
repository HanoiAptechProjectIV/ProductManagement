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
       
      <h3>Create Brand</h3>
       
      <p style="color: red;">${errorString}</p>
       
      <form method="POST" action="${pageContext.request.contextPath}/createBrand" enctype="multipart/form-data">
         <table border="0">
            <tr>
               <td>Name</td>
               <td><input type="text" required name="name" value="${brand.name}" /></td>
            </tr>
            <tr>
               <td>Logo</td>
               <td><input type="file" name="logo" /></td>
            </tr>           
            <tr>
               <td>Manufacturer</td>
               <td><input type="text" name="manufacturer" value="${brand.manufacturer}" /></td>
            </tr>
            <tr>
               <td>Description</td>
               <td><input type="text" name="description" value="${brand.description}" /></td>
            </tr>
            <tr>
               <td colspan="2">                   
                   <input type="submit" value="Submit" />
                   <a href="brandList">Cancel</a>
               </td>
            </tr>
         </table>
      </form>
       
      <jsp:include page="../../_footer.jsp"></jsp:include>
       
   </body>
</html>
