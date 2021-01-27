<%-- 
    Document   : editProductView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

<%@page import="java.util.List"%>
<%@page import="beans.Brand"%>
<%@page import="utils.BrandDAO"%>
<%@page import="beans.Category"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="beans.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
    </head>
    <body onload="selectedDisableOption();">

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3 style="text-align: center; margin-top: 40px">Edit Product</h3>

            <p style="color: red;">${errorString}</p>
        <%
            Connection conn = MyUtils.getStoredConnection(request);
            Product product = (Product) request.getAttribute("product");
            if(product!= null){
            Category cate = CategoryDAO.findCategory(conn, product.getCategoryId());
            Brand bra = BrandDAO.findBrand(conn, product.getBrandId());
            List<Category> listCategory = CategoryDAO.queryCategory(conn);
            List<Brand> listBrand = BrandDAO.queryBrand(conn);
        %>
        
        <div class="container">
            <c:if test="${product != null}">
            <form method="POST" action="${pageContext.request.contextPath}/admin/editProduct" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${product.id}" />
                    <div class="form-group w-50">
                        <label>Name</label>
                        <input type="text" required name="name" value="${product.name}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>Price</label>
                        <input type="text" required name="price" value="${product.price}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>Old image</label>
                        <img src="${product.image}"
                                 height="100" alt="${product.name} image"/>
                    <input type="hidden" name="oldImage" value="${product.image}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>New image</label>
                        <input type="file" name="image" value="" />
                    </div>            
                    <div class="form-group w-50">
                        <label>Quantity</label>
                        <input type="number" required min="0" name="quantity" value="${product.quantity}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>Description</label>
                        <input type="text" name="description" value="${product.description}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>Date added</label>
                        <div class="col-md-12">
                            <div class="row">
                            <input type="text" id="dateAddedInput" name="dateAdded" value="${product.dateAdded}" class="form-control col-md-7"/>
                        <input class="btn btn-outline-primary col-md-5" type="button" onclick="getCurrentTime();" value="Get Current Time"/>
                        </div>
                    </div>
                        
                    </div>
                    <div class="form-group w-50">
                        <label>Category name</label>
                        
                            <div id="categoryAnchor">
                                <a class="btn btn-outline-primary" id="categoryNameAnchor" href="categoryList?search=<%=cate.getName()%>"
                                   ><%=cate.getName()%></a>
                            </div>    
                            <div id="categoryDiv">
                                <p> | <%=cate.getDescription()%></p>
                                <p> | <%=(cate.isDisable()) ? "disabled": "displayed"%></p>
                            </div>                            
                            <select id="categoryNameOption" name="categoryNameOption"
                                    required onchange="changeCategoryNameAnchor();" class="form-control">
                                <%for (Category category : listCategory) {%>
                                <%if (category.getId() == product.getCategoryId()) {%>
                                <option value="<%=category.getName()%>" selected><%=category.getName()%></option>
                                <%} else {%>
                                <option value="<%=category.getName()%>"><%=category.getName()%></option>  
                                <%}%>
                                <%}%>
                            </select>                
                        </div>
                    <div class="form-group w-50">
                        <label>Brand name</label>
                            <div id="brandAnchor">
                                <a class="btn btn-outline-primary" id="brandNameAnchor" href="brandList?search=<%=bra.getName()%>"
                               ><%=bra.getName()%></a>
                            </div>
                            <div id="brandDiv">
                                <img src="<%=bra.getLogo()%>"
                                     alt="<%=bra.getName()%> Logo" height="30"/>
                                <p> | <%=bra.getManufacturer()%> | </p>
                                <p> | <%=bra.getDescription()%></p>
                                <p> | <%=(bra.isDisable()) ? "disabled": "displayed"%></p>
                            </div>                            
                            <select id="brandNameOption" name="brandNameOption" class="form-control"
                                    required onchange="changeBrandNameAnchor();">
                                <%for (Brand brand : listBrand) {%>
                                <%if (brand.getId() == product.getBrandId()) {%>
                                <option value="<%=brand.getName()%>" selected><%=brand.getName()%></option>
                                <%} else {%>
                                <option value="<%=brand.getName()%>"><%=brand.getName()%></option>  
                                <%}%>
                                <%}%>
                            </select>   
                            </div>               
                    <div class="form-group w-50">
                  <label>Disable</label>
                  <div class="col-md-12"> 
                     <div class="row">
                        <input type="text" id="disableTxt" readonly name="disable" value="${product.disable}" class="form-control col-md-6" />
                        <select id="disableOption" name="disableOption" 
                              onchange="changeDisableTxt();" class="form-control col-md-6">
                           <option value="true">True</option>  
                           <option value="false">False</option>  
                     </select> 
                     </div>
                  </div>
               </div>    
                    <div>
                        <button class="btn btn-outline-success" type="submit">Submit</button>
                        <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/admin/productList">Cancel</a>
                    </div>
            </form>
        </c:if>
        </div>

        <jsp:include page="../../_footer.jsp"></jsp:include>
        <style>
            #categoryAnchor, #brandAnchor {
                width: fit-content;
            }
            #categoryDiv, #brandDiv{display:none}
            #categoryAnchor:hover + #categoryDiv, #brandAnchor:hover + #brandDiv{display: inline}
            #categoryDiv p, #brandDiv p, #brandDiv img, #brandAnchor, #categoryAnchor{ display: inline; }
            #categoryNameOption, #brandNameOption{display: block; margin-top: 5px;}
            #brandDiv img{
                margin-bottom: -9px;
            }
        </style>        
            <script>
                var disable = document.getElementById("disableOption"),
                        disableTxt = document.getElementById("disableTxt");
                function selectedDisableOption() {
                    Array.prototype.filter.call(disable.options, function (option) {
                        if (option.value === "${product.disable}") {
                            option.selected = true;
                        }
                    });
                }

                function changeDisableTxt() {
                    disableTxt.value = disable.value;
                }

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

                function changeCategoryNameAnchor() {
                    var categoryOption = document.getElementById("categoryNameOption"),
                            categoryAnchor = document.getElementById("categoryNameAnchor");
                    categoryAnchor.href = "categoryList?search=" + categoryOption.value;
                    categoryAnchor.text = categoryOption.value;
                }

                function changeBrandNameAnchor() {
                    var brandOption = document.getElementById("brandNameOption"),
                            brandAnchor = document.getElementById("brandNameAnchor");
                    brandAnchor.href = "brandList?search=" + brandOption.value;
                    brandAnchor.text = brandOption.value;
                }
        </script>
    <%}%>
    </body>
</html>
