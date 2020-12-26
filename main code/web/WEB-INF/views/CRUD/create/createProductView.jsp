<%-- 
    Document   : createProductView
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
      <title>Create Product</title>
   </head>
   <body>
    
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
       
      <h3>Create Product</h3>
       
      <p style="color: red;">${errorString}</p>
       
      <form method="POST" action="${pageContext.request.contextPath}/createProduct">
         <table border="0">
            <tr>
               <td>Name</td>
               <td><input type="text" name="name" value="${product.name}" /></td>
            </tr>
            <tr>
               <td>Price</td>
               <td><input type="text" name="price" value="${product.price}" /></td>
            </tr>
            <tr>
               <td>Image</td>
               <td><input type="text" name="image" value="${product.image}" /></td>
            </tr>
            <tr>
               <td>Quantity</td>
               <td><input type="text" name="quantity" value="${product.quantity}" /></td>
            </tr>
            <tr>
               <td>Description</td>
               <td><input type="text" name="description" value="${product.description}" /></td>
            </tr>
            <tr>
               <td>Date added</td>
               <td><input type="text" name="dateAdded" value="${product.dateAdded}" /></td>
            </tr>
            <tr>
               <td>Category id</td>
               <td><input type="text" name="categoryId" value="${product.categoryId}" /></td>
            </tr>
            <tr>
               <td>Brand id</td>
               <td><input type="text" name="brandId" value="${product.brandId}" /></td>
            </tr>
            <tr>
               <td colspan="2">                   
                   <input type="submit" value="Submit" />
                   <a href="productList">Cancel</a>
               </td>
            </tr>
         </table>
      </form>
       
      <jsp:include page="../../_footer.jsp"></jsp:include>
       
   </body>
</html>
