<%-- 
    Document   : editProductView
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
      <title>Edit Product</title>
   </head>
   <body>
 
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
 
      <h3>Edit Product</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <c:if test="${not empty product}">
         <form method="POST" action="${pageContext.request.contextPath}/editProduct" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${product.id}" />
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
               <td>Old image</td>
               <td><img src="${pageContext.request.contextPath}/images/product/${product.image}"
                        height="100" alt="${product.name} image"/></td>
                <input type="hidden" name="oldImage" value="${product.image}"/>
            </tr>
            <tr>
               <td>New image</td>
               <td><input type="file" name="image" value="" /></td>
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
               <td>Disable</td>
               <td><input type="text" name="disable" value="${product.disable}" /></td>
            </tr>
               <tr>
                  <td colspan = "2">
                      <input type="submit" value="Submit" />
                      <a href="${pageContext.request.contextPath}/productList">Cancel</a>
                  </td>
               </tr>
            </table>
         </form>
      </c:if>
 
      <jsp:include page="../../_footer.jsp"></jsp:include>
 
   </body>
</html>
