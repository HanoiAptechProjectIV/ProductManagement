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

    <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

      <!-- jQuery library -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      <!-- Popper JS -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

      <!-- Latest compiled JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

   </head>
   <body onload="changeCategoryNameAnchor();changeBrandNameAnchor();">
    
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
       
      <h3 style="text-align: center; margin-top: 40px">Create Product</h3>
       
      <p style="color: red;">${errorString}</p>
      <%
          Connection conn = MyUtils.getStoredConnection(request);
          List<Category> listCategory = CategoryDAO.queryCategory(conn);
          List<Brand> listBrand = BrandDAO.queryBrand(conn);
      %>       
      
      <div class="container">
          <form method="POST" action="${pageContext.request.contextPath}/createProduct" enctype="multipart/form-data">
            <div class="form-group w-50">
               <label>Name</label>
               <input class="form-control"  type="text" required name="name" value="${product.name}" />
            </div>
            <div class="form-group w-50">
               <label>Price</label>
               <input class="form-control"  type="text" required name="price" value="${product.price}" />
            </div>
            <div class="form-group w-50">
               <label>Image</label>
               <input class="form-control"  type="file" name="image" value="" />
            </div>
            <div class="form-group w-50">
               <label>Quantity</label>
               <input class="form-control"  type="text" required name="quantity" value="${product.quantity}" />
            </div>
            <div class="form-group w-50">
               <label>Description</label>
               <input class="form-control"  type="text" name="description" value="${product.description}" />
            </div>
            <div class="form-group w-50">
               <label>Date added</label>
               <div class="col-md-12">
                   <div class="row">
                       <input class="form-control col-md-9"  type="text" id="dateAddedInput" name="dateAdded" value="${product.dateAdded}" />
                <input class="btn btn-outline-primary col-md-3" type="button" onclick="getCurrentTime();" value="Get Current Time"/>
                   </div>
               </div>
               
            </div>
            <div class="form-group w-50">
               <label>Category name</label>
               
                   <a class="btn btn-outline-primary" id="categoryNameAnchor" href="categoryList?search="></a>
                   <select class="form-control"  id="categoryNameOption" name="categoryNameOption"
                            required onchange="changeCategoryNameAnchor();">
               <%for(Category category : listCategory){%>
                        <option value="<%=category.getName()%>"><%=category.getName()%></option>  
               <%}%>
                   </select>                
               
            </div>
            <div class="form-group w-50">
               <label>Brand name</label>
               
                   <a class="btn btn-outline-primary" id="brandNameAnchor" href="brandList?search="></a>
                   <select class="form-control"  id="brandNameOption" name="brandNameOption"
                            required onchange="changeBrandNameAnchor();">
               <%for(Brand brand : listBrand){%>
                        <option value="<%=brand.getName()%>"><%=brand.getName()%></option>  
               <%}%>
                   </select>                 
               
            </div>
            <div>
                <button type="submit" class="btn btn-outline-success">Submit</button>
                <a class="btn btn-outline-warning" href="productList">Cancel</a>
               
            </div>
      </form>
      </div>
       
      <jsp:include page="../../_footer.jsp"></jsp:include>
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
