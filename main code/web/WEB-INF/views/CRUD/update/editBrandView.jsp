<%-- 
    Document   : editBrandView
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
      <title>Edit Brand</title>
   </head>
   <body>
 
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
 
      <h3>Edit Brand</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <c:if test="${not empty brand}">
         <form method="POST" action="${pageContext.request.contextPath}/editBrand" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${brand.id}" />
            <table border="0">
            <tr>
               <td>Name</td>
               <td><input type="text" name="name" value="${brand.name}" /></td>
            </tr>
            <tr>
               <td>Old logo</td>
               <td><img src="${pageContext.request.contextPath}/images/brand/${brand.logo}"
                        height="100" alt="${brand.name} logo"/></td>
               <input type="hidden" name="oldLogo" value="${brand.logo}"/>
            </tr>
            <tr>
               <td>New logo</td>
               <td><input type="file" name="logo" value="" /></td>
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
               <td>Disable</td>
               <td><input type="text" name="disable" value="${brand.disable}" /></td>
            </tr>            
            <tr>
               <td colspan = "2">
                   <input type="submit" value="Submit" />
                   <a href="${pageContext.request.contextPath}/brandList">Cancel</a>
               </td>
            </tr>
            </table>
         </form>
      </c:if>
 
      <jsp:include page="../../_footer.jsp"></jsp:include>
 
   </body>
</html>
