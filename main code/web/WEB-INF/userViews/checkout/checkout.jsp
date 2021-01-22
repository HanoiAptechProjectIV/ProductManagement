<%-- 
    Document   : checkout
    Created on : Jan 19, 2021, 3:23:24 PM
    Author     : Hung
--%>

<%@page import="beans.Product"%>
<%@page import="beans.CartItem"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <%
                String errorString = (String) request.getAttribute("errorString");
                if (errorString != null) {
                    if (errorString.equals("The transaction has been created, currently pending")) {
            %>
            <p class="center" style="color: green;"><%=errorString%></p>
            <%} else {%>
            <p class="center" style="color: red;"><%=errorString%></p>
            <%}
                } else {%>
            <section class="main-content">
                <div class="row">
                    <div class="span12">
                        <div class="accordion" id="accordion2">
                            <form method="post" action="checkout" id="my-form" class="form-stacked">
                                <div class="accordion-group">
                                    <div class="accordion-heading">
                                        <a class="accordion-toggle" data-toggle="collapse" 
                                           data-parent="#accordion2" href="#collapseTwo">Account &amp; Billing Details</a>
                                    </div>
                                    <div id="collapseTwo" class="accordion-body collapse in">
                                        <div class="accordion-inner">
                                            <div class="row-fluid">

                                                <div class='cart-detail'>
                                                    <%
                                                        if (session.getAttribute("cart") != null) {
                                                            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                                                            int subTotal = 0;
                                                            if (cart.size() > 0) {
                                                    %>                                                    
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>Image</th>
                                                                <th>Product Name</th>
                                                                <th>Purchase quan</th>
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
                                                                <td><a href="products?search=<%=prod.getName()%>"
                                                                       ><img alt="<%=prod.getName()%> image" 
                                                                          style='min-width: 100px; max-width: 100px; object-fit: cover'
                                                                          src="<%=prod.getImage()%>"></a></td>
                                                                <td><%=prod.getName()%></td>
                                                                <td><input type="number" readonly name="quantity<%=i%>" class="input-mini" 
                                                                           value="<%=quantity%>"></td>
                                                                <td><%=prod.getPrice()%> VND</td>
                                                                <td><%=(prod.getPrice() * quantity)%> VND</td>
                                                            </tr>			  
                                                            <%}%>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                                <td>Sub total</td>
                                                                <td><strong><%=subTotal%> VND</strong></td>
                                                            </tr>		  
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                                <td><strong>VAT (10.0%): </strong></td>
                                                                <td><strong><%=(subTotal / 100 * 10)%> VND</strong></td>
                                                            </tr>		  
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                                <td><strong>Total: </strong></td>
                                                                <%
                                                                    int total = subTotal + subTotal / 100 * 10;
                                                                %>
                                                        <input type="hidden" name="amount" value="<%=total%>">
                                                        <td><strong><%=total%> VND</strong></td>
                                                        </tr>		  
                                                        </tbody>
                                                    </table> 
                                                    <hr>
                                                    <a href="${pageContext.request.contextPath}/cart" 
                                                       ><button class="btn" type="button">Modify your cart</button></a>
                                                    <%} else {%>
                                                    <h4 class="center">Your Cart is Empty</h4>
                                                    <%}
                                                    } else {%>
                                                    <h4 class="center">Your Cart is Empty</h4>
                                                    <%}%>                                                    
                                                </div>

                                                <div class="span12">
                                                    <h4>Receiver Details</h4>
                                                    <c:if test="${sessionScope.loginedUser != null}">
                                                        <div class="control-group">
                                                            <p>Use your account detail </p>
                                                            <input onclick="userAccountDetail(this)" name="useUserInfo" type="checkbox" value="false">  
                                                            <input type="hidden" name="userId" value="${sessionScope.loginedUser.id}">
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${sessionScope.loginedUser == null}">
                                                        <div class="control-group">
                                                            <p>Login first to save your info</p>
                                                            <a href="login" ><button type="button" class="btn">Login</button></a>                                                      
                                                        </div>
                                                    </c:if>
                                                    <div class="control-group">
                                                        <p>Full name: </p>
                                                        <input type="text" name="name" value= "" required style="width: 250px;"
                                                               placeholder="fullname: John Doe" class="input-large" id="fullname-register">
                                                        <span class="error" id="fullname-error"></span>
                                                    </div>
                                                    <div class="control-group">
                                                        <p>Email:</p>
                                                        <input type="text" name="email" value= "" required style="width: 250px;"
                                                               placeholder="email: -_mY.ownsite12@you.me.com" class="input-large" id="email-register">
                                                        <span class="error" id="email-error"></span>
                                                    </div>					  
                                                    <div class="control-group">
                                                        <p>Phone: </p>
                                                        <input type="text" name="phone" value= "" required style="width: 250px;"
                                                               placeholder="phone: 0123456789" class="input-large" id="phone-register">
                                                        <span class="error" id="phone-error"></span>
                                                    </div>
                                                </div>


                                                <input onclick="checkAndSubmit()" type="button" tabindex="9" value="Confirm order" 
                                                       class="btn btn-inverse large" id="submit-button">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--                                <div class="accordion-group">
                                                                    <div class="accordion-heading">
                                                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">Confirm Order</a>
                                                                    </div>
                                                                    <div id="collapseThree" class="accordion-body collapse in">
                                                                        <div class="accordion-inner">
                                                                            <div class="row-fluid">
                                                                                <div class="control-group">
                                                                                    <label for="textarea" class="control-label">Comments</label>
                                                                                    <div class="controls">
                                                                                        <textarea rows="3" id="textarea" class="span12"></textarea>
                                                                                    </div>
                                                                                </div>									
                                                                                <button class="btn btn-inverse pull-right" type="submit">Confirm order</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                                                </div>-->
                            </form>
                        </div>				
                    </div>
                </div>
            </section>    

            <script>
                const emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                const phoneRegex = /(84|0)+([1-9]{1})([0-9]{8})\b/g;
                const fullNameRegex = /(^[A-Za-z]{3,16})([ ]{0,1})([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})/;
                const submitButton = document.querySelector('#submit-button');
                const phoneError = document.querySelector('#phone-error');
                const fullNameError = document.querySelector('#fullname-error');
                const emailError = document.querySelector('#email-error');
                const phone = document.querySelector('#phone-register');
                const fullname = document.querySelector('#fullname-register');
                const email = document.querySelector('#email-register');
                const myForm = document.querySelector('#my-form');

                function userAccountDetail(checkbox) {
                    if (checkbox.value === 'false') {
                        fullname.value = '${sessionScope.loginedUser.name}';
                        phone.value = '${sessionScope.loginedUser.phone}';
                        email.value = '${sessionScope.loginedUser.email}';
                        checkbox.value = 'true';
                    } else {
                        checkbox.value = 'false';
                        fullname.value = '';
                        phone.value = '';
                        email.value = '';
                        return;
                    }
                }

                function checkAndSubmit() {
                <%
                    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                    if(cart != null && !cart.isEmpty()){
                %>
                    if (checkValid()) {
                        myForm.submit();
                    } else {
                        return;
                    }
                <%}%>
                }

                const checkValid = () => {
                    if (fullname.value === '') {
                        fullNameError.textContent = 'Name must not be blank';
                        return false;
                    } else if(!fullNameRegex.test(fullname.value)){
                        fullNameError.textContent = 'Invalid full name (full name must has atleast 2 words with 3 characters each word)';
                    } else {
                        fullNameError.textContent = '';
                    }

                    if (email.value === '') {
                        emailError.textContent = 'Email must not be blank';
                        return false;
                    } else if (!emailRegex.test(String(email.value).toLocaleLowerCase())) {
                        emailError.textContent = 'Invalid email (valid example: -_mY.ownsite12@you.me.com)';
                        return false;
                    } else {
                        emailError.textContent = '';
                    }

                    if (phone.value === '') {
                        phoneError.textContent = 'Phone must not be blank';
                        return false;
                    } else if (!phoneRegex.test(phone.value)) {
                        phoneError.textContent = 'Invalid phone for Vietnamese countries (start with 0 or 84, next number by 1->9, last 8 numbers by 0->9)';
                        return false;
                    } else {
                        phoneError.textContent = '';
                    }

                    return true;
                };
            </script>
            <%}%>
            <jsp:include page="../_footer.jsp"/>
        </div> 
    </body>
</html>
