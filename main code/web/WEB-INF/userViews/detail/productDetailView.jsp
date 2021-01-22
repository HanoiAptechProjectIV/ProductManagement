<%-- 
    Document   : productDetailView
    Created on : Jan 18, 2021, 8:24:06 AM
    Author     : Hung
--%>

<%@page import="beans.CartItem"%>
<%@page import="utils.ProductDAO"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="beans.Brand"%>
<%@page import="beans.Category"%>
<%@page import="utils.BrandDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page import="java.util.List"%>
<%@page import="beans.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Home Page</title>
    </head>
    <body onload="setMaxQuantity();">
            <%
                Connection conn = MyUtils.getStoredConnection(request);
                Product product = ((List<Product>) request.getAttribute("productList")).get(0);
                Brand brand = BrandDAO.findBrand(conn, product.getBrandId());
                Category category = CategoryDAO.findCategory(conn, product.getCategoryId());
                
                List<CartItem> cart = (List<CartItem>)session.getAttribute("cart");
                int oldQuantity = 1;
                if(cart != null && !cart.isEmpty()){
                    for(CartItem item : cart){
                       if(item.getProduct().getId() == product.getId()){
                           oldQuantity = item.getQuantity();
                       }
                    }
                }
            %>            

        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <section class="main-content">				
                <div class="row">						
                    <div class="span9">
                        <div class="row">
                            <div class="span4">
                                <a href="<%=product.getImage()%>" class="thumbnail" 
                                   data-fancybox-group="group1" title="Description 1"
                                   ><img alt="<%=product.getName()%> image" style='min-height: 300px; max-height: 300px; object-fit: cover'
                                      src="<%=product.getImage()%>"></a>												
<!--                                <ul class="thumbnails small">								
                                    <li class="span1">
                                        <a href="themes/images/ladies/2.jpg" class="thumbnail" data-fancybox-group="group1" title="Description 2"><img src="themes/images/ladies/2.jpg" alt=""></a>
                                    </li>								
                                    <li class="span1">
                                        <a href="themes/images/ladies/3.jpg" class="thumbnail" data-fancybox-group="group1" title="Description 3"><img src="themes/images/ladies/3.jpg" alt=""></a>
                                    </li>													
                                    <li class="span1">
                                        <a href="themes/images/ladies/4.jpg" class="thumbnail" data-fancybox-group="group1" title="Description 4"><img src="themes/images/ladies/4.jpg" alt=""></a>
                                    </li>
                                    <li class="span1">
                                        <a href="themes/images/ladies/5.jpg" class="thumbnail" data-fancybox-group="group1" title="Description 5"><img src="themes/images/ladies/5.jpg" alt=""></a>
                                    </li>
                                </ul>-->
                            </div>
                            <div class="span5">
                                <address>
                                    <strong>Product Id:</strong> <span><%=product.getId()%></span><br>
                                    <strong>Name: </strong> <span><%=product.getName()%></span><br>
                                    <strong>Brand: </strong> <a href="brands?search=<%=brand.getName()%>"><span
                                            ><%=brand.getName()%></span><br
                                            ><img alt="<%=brand.getName()%> image" style='min-height: 100px; max-height: 100px; object-fit: scale-down'
                                            src="<%=brand.getLogo()%>"></a><br>
                                    <strong>Category: </strong> <a href="categories?search=<%=category.getName()%>"><span
                                            ><%=category.getName()%></span></a><br>
                                </address>									
                                <h4>Remain quantity: <%=product.getQuantity()%></h4>
                                <h4><strong>Price: <%=product.getPrice()%> VND</strong></h4>
                            </div>
                            <div class="span5">
                                <form method="post" action="${pageContext.request.contextPath}/cart" class="form-inline">
<!--                                    <label class="checkbox">
                                        <input type="checkbox" value=""> Option one is this and that
                                    </label>
                                    <br/>
                                    <label class="checkbox">
                                        <input type="checkbox" value=""> Be sure to include why it's great
                                    </label>-->
                                    <p>&nbsp;</p>
                                    <label>Quantity: </label>
                                    <input type="hidden" name="id" value="<%=product.getId()%>">
                                    <input type="number" required id="quantity" name="quantity" min="1" class="span1" value="<%=oldQuantity%>">
                                    <button class="btn btn-inverse" type="submit">Add to cart</button>
                                </form>
                            </div>							
                        </div>
                        <div class="row">
                            <div class="span9">
                                <ul class="nav nav-tabs" id="myTab">
                                    <li class="active"><a href="#home">Description</a></li>
                                    <!--<li class=""><a href="#profile">Additional Information</a></li>-->
                                </ul>							 
                                <div class="tab-content">
                                    <div class="tab-pane active" id="home"><%=product.getDescription()%></div>
<!--                                    <div class="tab-pane" id="profile">
                                        <table class="table table-striped shop_attributes">	
                                            <tbody>
                                                <tr class="">
                                                    <th>Size</th>
                                                    <td>Large, Medium, Small, X-Large</td>
                                                </tr>		
                                                <tr class="alt">
                                                    <th>Colour</th>
                                                    <td>Orange, Yellow</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>-->
                                </div>							
                            </div>						
                        </div>
                        
                        <jsp:include page="../_relatedProducts.jsp"/>
                    </div>
                    <jsp:include page="../_rightMenu.jsp"/>
                </div>
            </section>
            <jsp:include page="../_footer.jsp"/>
        </div>
        <script>
            function setMaxQuantity(){
                let quantity = document.getElementById("quantity");
                <% if(product.getQuantity() < oldQuantity){%>
                        quantity.value = '<%=product.getQuantity()%>';
                <%}%>
                quantity.max ='<%=product.getQuantity()%>';
            }
        </script>
    </body>
</html>  