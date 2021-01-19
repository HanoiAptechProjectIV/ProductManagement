<%-- 
    Document   : createProductView
    Created on : Dec 8, 2020, 5:17:54 PM
    Author     : Hung
--%>

<%@page import="utils.BrandDAO"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="utils.MyUtils"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="beans.Brand"%>
<%@page import="beans.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>Create Product</title>
   </head>
   <body onload="changeCategoryNameAnchor();changeBrandNameAnchor();">
    
      <jsp:include page="../../_header.jsp"/>
      <jsp:include page="../../_menu.jsp"/>
       
      <h3>Create Product</h3>
       
      <p style="color: red;">${errorString}</p>
      <%
          Connection conn = MyUtils.getStoredConnection(request);
          List<Category> listCategory = CategoryDAO.queryCategory(conn);
          List<Brand> listBrand = BrandDAO.queryBrand(conn);
      %>       
      <form method="POST" action="${pageContext.request.contextPath}/admin/createProduct" enctype="multipart/form-data">
         <table border="0">
            <tr>
               <td>Name</td>
               <td><input type="text" required name="name" value="${product.name}" /></td>
            </tr>
            <tr>
               <td>Price</td>
               <td><input type="text" required name="price" value="${product.price}" /></td>
            </tr>
            <tr>
               <td>Image</td>
               <td><input type="file" name="image" value="" /></td>
            </tr>
            <tr>
               <td>Quantity</td>
               <td><input type="text" required name="quantity" value="${product.quantity}" /></td>
            </tr>
            <tr>
               <td>Description</td>
               <td><input type="text" name="description" value="${product.description}" /></td>
            </tr>
            <tr>
               <td>Date added</td>
               <td><input type="text" id="dateAddedInput" name="dateAdded" value="${product.dateAdded}" />
                   <input type="button" onclick="getCurrentTime();" value="Get Current Time"/>
               </td>
            </tr>
            <tr>
               <td>Category name</td>
               <td>
                   <a id="categoryNameAnchor" href="categoryList?search="></a>
                   <select id="categoryNameOption" name="categoryNameOption"
                            required onchange="changeCategoryNameAnchor();">
               <%for(Category category : listCategory){%>
                        <option value="<%=category.getName()%>"><%=category.getName()%></option>  
               <%}%>
                   </select>                
               </td>
            </tr>
            <tr>
               <td>Brand name</td>
               <td>
                   <a id="brandNameAnchor" href="brandList?search="></a>
                   <select id="brandNameOption" name="brandNameOption"
                            required onchange="changeBrandNameAnchor();">
               <%for(Brand brand : listBrand){%>
                        <option value="<%=brand.getName()%>"><%=brand.getName()%></option>  
               <%}%>
                   </select>                 
               </td>
            </tr>
            <tr>
               <td colspan="2">                   
                   <input type="submit" value="Submit" />
                   <a href="productList">Cancel</a>
               </td>
            </tr>
         </table>
      </form>
       
      <jsp:include page="../../_footer.jsp"/>
      <script>
            function getCurrentTime() {
                var d = new Date(),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();

                if (month.length < 2) 
                    month = '0' + month;
                if (day.length < 2) 
                    day = '0' + day;

                var today = [year, month, day].join('-'),                 
                    dateAdded = document.getElementById("dateAddedInput");
                dateAdded.value = today;
            }  
            
            function changeCategoryNameAnchor(){
                var categoryOption = document.getElementById("categoryNameOption"),
                    categoryAnchor = document.getElementById("categoryNameAnchor");
                categoryAnchor.href = "categoryList?search="+categoryOption.value;
                categoryAnchor.text = categoryOption.value;
            }
            
            function changeBrandNameAnchor(){
                var brandOption = document.getElementById("brandNameOption"),
                    brandAnchor = document.getElementById("brandNameAnchor");
                brandAnchor.href = "brandList?search="+brandOption.value;
                brandAnchor.text = brandOption.value;
            }             
      </script>
       
   </body>
</html>
