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

        <jsp:include page="../../_header.jsp"/>
        <jsp:include page="../../_menu.jsp"/>

            <h3>Edit Product</h3>

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
        <c:if test="${product != null}">
            <form method="POST" action="${pageContext.request.contextPath}/admin/editProduct" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${product.id}" />
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
                        <td><input type="number" required min="0" name="quantity" value="${product.quantity}" /></td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td><input type="text" name="description" value="${product.description}" /></td>
                    </tr>
                    <tr>
                        <td>Date added</td>
                        <td><input type="text" id="dateAddedInput" name="dateAdded" value="${product.dateAdded}" /><br>
                            <input type="button" onclick="getCurrentTime();" value="Get Current Time"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Category name</td>
                        <td>
                            <div id="categoryAnchor">
                                <a id="categoryNameAnchor" href="categoryList?search=<%=cate.getName()%>"
                                   ><%=cate.getName()%></a>
                            </div>    
                            <div id="categoryDiv">
                                <p> | <%=cate.getDescription()%></p>
                                <p> | <%=(cate.isDisable()) ? "disabled": "displayed"%></p>
                            </div>                            
                            <select id="categoryNameOption" name="categoryNameOption"
                                    required onchange="changeCategoryNameAnchor();">
                                <%for (Category category : listCategory) {%>
                                <%if (category.getId() == product.getCategoryId()) {%>
                                <option value="<%=category.getName()%>" selected><%=category.getName()%></option>
                                <%} else {%>
                                <option value="<%=category.getName()%>"><%=category.getName()%></option>  
                                <%}%>
                                <%}%>
                            </select>                
                        </td>
                    </tr>
                    <tr>
                        <td>Brand name</td>
                        <td>
                            <div id="brandAnchor">
                                <a id="brandNameAnchor" href="brandList?search=<%=bra.getName()%>"
                               ><%=bra.getName()%></a>
                            </div>
                            <div id="brandDiv">
                                <img src="${pageContext.request.contextPath}/images/brand/<%=bra.getLogo()%>"
                                     alt="<%=bra.getName()%> Logo" height="30"/>
                                <p> | <%=bra.getManufacturer()%> | </p>
                                <p> | <%=bra.getDescription()%></p>
                                <p> | <%=(bra.isDisable()) ? "disabled": "displayed"%></p>
                            </div>                            
                            <select id="brandNameOption" name="brandNameOption"
                                    required onchange="changeBrandNameAnchor();">
                                <%for (Brand brand : listBrand) {%>
                                <%if (brand.getId() == product.getBrandId()) {%>
                                <option value="<%=brand.getName()%>" selected><%=brand.getName()%></option>
                                <%} else {%>
                                <option value="<%=brand.getName()%>"><%=brand.getName()%></option>  
                                <%}%>
                                <%}%>
                            </select>                 
                        </td>
                    </tr>
                    <tr>
                        <td>Disable</td>
                        <td><input type="text" id="disableTxt" readonly name="disable" value="${product.disable}" />
                            <select id="disableOption" name="disableOption" 
                                    onchange="changeDisableTxt();">
                                <option value="true">True</option>  
                                <option value="false">False</option>  
                            </select>  
                        </td>
                    </tr>
                    <tr>
                        <td colspan = "2">
                            <input type="submit" value="Submit" />
                            <a href="${pageContext.request.contextPath}/admin/productList">Cancel</a>
                        </td>
                    </tr>
                </table>
            </form>
        </c:if>
        <jsp:include page="../../_footer.jsp"/>
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
