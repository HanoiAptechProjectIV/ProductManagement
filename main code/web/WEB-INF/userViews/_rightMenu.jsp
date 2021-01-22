<%-- 
    Document   : _rightSideMenu
    Created on : Jan 17, 2021, 6:35:12 AM
    Author     : Hung
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="utils.OrderDetailDAO"%>
<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%@page import="beans.Product"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.Brand"%>
<%@page import="utils.BrandDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="beans.Category"%>
<%@page import="utils.MyUtils"%>
<%@page import="utils.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection conn = MyUtils.getStoredConnection(request);
    List<Category> cateList = CategoryDAO.queryDisplayCategory(conn, 0, 5, "name", "ASC");
    List<Brand> braList = BrandDAO.queryDisplayBrand(conn, 0, 5, "name", "ASC");
    List<Product> prodList = ProductDAO.queryDisplayProduct(conn);
    Map<Product, Integer> bestSellerMap = OrderDetailDAO.bestSellerMap(conn);
    List<Product> top3BestSeller = new ArrayList<Product>();
    int count = 0;
    for(Product prod : bestSellerMap.keySet()){
        top3BestSeller.add(prod);
        count++;
        if(count == 3) break;
    }
%>
<div class="span3 col">
    <div class="block">	
        <h4>Find product by few category or brand names</h4>
        <ul class="nav nav-list">
            <li class="nav-header">CATEGORIES</li>
                <%
                    for (Category cate : cateList) {
                %>
            <li><a href="products?categoryId=<%=cate.getId()%>"><%=cate.getName()%></a></li>
                <%}%>
        </ul>
        <br/>
        <ul class="nav nav-list below">
            <li class="nav-header">BRANDS</li>
                <%
                    for (Brand bra : braList) {
                %>
            <li><a href="products?brandId=<%=bra.getId()%>"><%=bra.getName()%></a></li>
                <%}%>
        </ul>
    </div>
    <div class="block">
        <h4 class="title">
            <span class="pull-left"><span class="text">Randomize</span></span>
        </h4>
        <div id="myCarousel" class="carousel slide">
            <div class="carousel-inner">
                <%
                    int randomNum = ThreadLocalRandom.current().nextInt(0, prodList.size());
                    Product prod = prodList.get(randomNum);
                %>
                <div class="active item">
                    <ul class="thumbnails listing-products">
                        <li class="span3">
                            <div class="product-box">
                                <span class="sale_tag"></span>	
                                <%
                                    Category cate = CategoryDAO.findCategory(conn, prod.getCategoryId());
                                    Brand bra = BrandDAO.findBrand(conn, prod.getBrandId());
                                %>                                
                                <a href="products?search=<%=prod.getName()%>"><img alt="<%=prod.getName()%> image"
                                                                                   style='min-height: 150px; max-height: 150px; object-fit: cover'
                                                                                   src="<%=prod.getImage()%>"></a><br/>
                                <a href="${pageContext.request.contextPath}/products?search=<%=prod.getName()%>"
                                   class="title"><%=prod.getName()%></a><br/>
                                <a href="${pageContext.request.contextPath}/brands?search=<%=bra.getName()%>"
                                   class="category"><%=bra.getName()%></a><br>
                                <a href="${pageContext.request.contextPath}/categories?search=<%=cate.getName()%>"
                                   class="brand"><%=cate.getName()%></a><br/>
                                <p class="price"><%=prod.getPrice()%> VND</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="block">								
        <h4 class="title"> <span class="text"> <strong> Best</strong> Seller</span></h4>								
        <ul class="small-product">
            <%
                for(Product product : top3BestSeller){
            %>
            <li>
                <a href="products?search=<%=product.getName()%>" title="<%=product.getName()%>">
                    <img src="<%=product.getImage()%>" 
                         style='min-height: 120px; max-height: 120px; min-width: 120px; max-width: 120px; object-fit: cover' alt="<%=product.getName()%> image">
                </a>
                <a href="products?search=<%=product.getName()%>"><%=product.getName()%></a>
            </li>  
            <%}%>
        </ul>
    </div>
</div>
