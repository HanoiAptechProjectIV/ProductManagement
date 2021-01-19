<%-- 
    Document   : cartDetail
    Created on : Jan 19, 2021, 5:04:15 AM
    Author     : Hung
--%>

<%@page import="beans.Product"%>
<%@page import="beans.CartItem"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your cart</title>
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/> 
            
            <p style="color: red;">${errorString}</p>
            <section class="main-content">				
                <div class="row">
                    <div class="span9">	
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" value="true" name="cartDetail">
                            <%
                                if (session.getAttribute("cart") != null) {
                                    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                                    int subTotal = 0;
                                    if (cart.size() > 0) {
                            %>
                            <h4 class="title"><span class="text"><strong>Your</strong> Cart</span></h4>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Remove</th>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < cart.size(); i++) {
                                            Product prod = cart.get(i).getProduct();
                                            int quantity = cart.get(i).getQuantity();
                                            subTotal += prod.getPrice() * quantity;
                                    %>
                                    <tr>
                                        <td><input onclick="changeValueCheckBox(this)" class="checkbox" type="checkbox" 
                                                   name="remove<%=i%>" value="false"></td>
                                        <td><a href="products?search=<%=prod.getName()%>"
                                               ><img alt="<%=prod.getName()%> image" 
                                                  src="images/product/<%=prod.getImage()%>"></a></td>
                                        <td><%=prod.getName()%></td>
                                        <td><input type="number" name="quantity<%=i%>" class="input-mini" value="<%=quantity%>"></td>
                                        <td><%=prod.getPrice()%> VND</td>
                                        <td><%=(prod.getPrice() * quantity)%> VND</td>
                                    </tr>			  
                                    <%}%>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>Sub total</td>
                                        <td><strong><%=subTotal%> VND</strong></td>
                                    </tr>		  
                                </tbody>
                            </table>
                            <!--                        <h4>What would you like to do next?</h4>
                                                    <p>Choose if you have a discount code or reward points you want to use or would like to estimate your delivery cost.</p>
                                                    <label class="radio">
                                                        <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
                                                        Use Coupon Code
                                                    </label>
                                                    <label class="radio">
                                                        <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                                        Estimate Shipping &amp; Taxes
                                                    </label>-->
                            <hr>
                            <p class="cart-total right">
                                <strong>Sub-Total</strong>:	<%=subTotal%> VND<br>
                                <!--<strong>Eco Tax (-2.00)</strong>: $2.00<br>-->
                                <strong>VAT (10.0%)</strong>: <%=(subTotal / 100 * 10)%> VND<br>
                                <strong>Total</strong>: <%=(subTotal + subTotal / 100 * 10)%> VND<br>
                            </p>
                            <hr/>
                            <p class="buttons center">				
                                <button class="btn" type="submit">Update</button>
                                <a href="index"><button class="btn" type="button">Continue</button></a>
                                <a href="checkout"><button class="btn btn-inverse" type="button" id="checkout">Checkout</button></a>
                            </p>
                            <%} else {%>
                            <h4 class="center">Your Cart is Empty</h4>
                            <%}
                        } else {%>
                            <h4 class="center">Your Cart is Empty</h4>
                            <%}%>
                        </form>
                    </div>
                    <jsp:include page="../_rightMenu.jsp"/>
                </div>
            </section>
            <jsp:include page="../_footer.jsp"/>
        </div>        
        <script>
            function changeValueCheckBox(checkbox) {
                if(checkbox.value === 'false'){
                    checkbox.value = 'true';
                } else {
                    checkbox.value = 'false';
                }
            }
        </script>
    </body>
</html>
