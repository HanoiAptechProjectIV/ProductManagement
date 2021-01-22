<%-- 
    Document   : _relatedProducts
    Created on : Jan 19, 2021, 1:58:41 PM
    Author     : Hung
--%>

<%@page import="beans.Brand"%>
<%@page import="utils.BrandDAO"%>
<%@page import="beans.Category"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page import="beans.Product"%>
<%@page import="utils.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection conn = MyUtils.getStoredConnection(request);
    Product product = ((List<Product>) request.getAttribute("productList")).get(0);
    List<Product> productList = ProductDAO.findProductByCategory(conn, product.getCategoryId());
    for(Product prod: productList){
        if(prod.getId() == product.getId()){
            productList.remove(prod);
            break;
        }
    }
%>
<div class="row">
    <div class="span9">	
        <br>
        <h4 class="title">
            <span class="pull-left"><span class="text"><strong>Related</strong> Products</span></span>
            <span class="pull-right">
                <a class="left button" href="#myCarousel-1" data-slide="prev"></a
                ><a class="right button" href="#myCarousel-1" data-slide="next"></a>
            </span>
        </h4>
        <div id="myCarousel-1" class="carousel slide">
            <div class="carousel-inner">
                <div class="active item">
                    <ul class="thumbnails listing-products">
                        <%
                            for (int i = 0; i < productList.size(); i++) {
                                Product prod = productList.get(i);
                        %>
                        <li class="span3">
                            <div class="product-box">
                                <span class="sale_tag"></span>												
                                <a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                   ><img src="<%=prod.getImage()%>" style='min-height: 200px; max-height: 200px; object-fit: cover'
                                      alt="<%=prod.getName()%> image" /></a><br>

                                <%
                                    Category cate = CategoryDAO.findCategory(conn, prod.getCategoryId());
                                    Brand bra = BrandDAO.findBrand(conn, prod.getBrandId());
                                %>
                                <a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                   class="title"><%=prod.getName()%></a><br/>
                                <a href="${pageContext.request.contextPath}/brands?search=<%=bra.getName()%>"
                                   class="category"><%=bra.getName()%></a><br>
                                <a href="${pageContext.request.contextPath}/categories?search=<%=cate.getName()%>"
                                   class="brand"><%=cate.getName()%></a><br/>
                                <p class="price"><%=prod.getPrice()%> VND</p>
                            </div>
                        </li>												
                        <% if (i == 2) {
                                    break;
                                }
                            }%>
                    </ul>
                </div>
                <div class="item">
                    <ul class="thumbnails listing-products">
                        <%
                            for (int i = 3; i < productList.size(); i++) {
                                Product prod = productList.get(i);
                        %>
                        <li class="span3">
                            <div class="product-box">
                                <span class="sale_tag"></span>												
                                <a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                   ><img src="<%=prod.getImage()%>" style='min-height: 200px; max-height: 200px; object-fit: cover'
                                      alt="<%=prod.getName()%> image" /></a><br>

                                <%
                                    Category cate = CategoryDAO.findCategory(conn, prod.getCategoryId());
                                    Brand bra = BrandDAO.findBrand(conn, prod.getBrandId());
                                %>
                                <a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                   class="title"><%=prod.getName()%></a><br/>
                                <a href="${pageContext.request.contextPath}/brands?search=<%=bra.getName()%>"
                                   class="category"><%=bra.getName()%></a><br>
                                <a href="${pageContext.request.contextPath}/categories?search=<%=cate.getName()%>"
                                   class="brand"><%=cate.getName()%></a><br/>
                                <p class="price"><%=prod.getPrice()%> VND</p>
                            </div>
                        </li>												
                        <% if (i == 5) {
                                    break;
                                }
                            }%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>