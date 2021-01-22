<%@page import="beans.CartItem"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-- bootstrap -->
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>      
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"/>

<link href="${pageContext.request.contextPath}/resources/themes/css/bootstrappage.css" rel="stylesheet"/>

<!-- global styles -->
<link href="${pageContext.request.contextPath}/resources/themes/css/flexslider.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/themes/css/main.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/themes/css/jquery.fancybox.css" rel="stylesheet"/>

<script src="${pageContext.request.contextPath}/resources/themes/js/jquery-1.7.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/themes/js/superfish.js"></script>	
<script src="${pageContext.request.contextPath}/resources/themes/js/jquery.scrolltotop.js"></script> 

<!--my css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css"/>

<!--icon-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
<style>
    #cart{
    }
    .fa-shopping-cart {
        font-size: 20px;
    }
    
    .badge {
      padding-left: 9px;
      padding-right: 9px;
      -webkit-border-radius: 9px;
      -moz-border-radius: 9px;
      border-radius: 9px;
    }

    .label-warning[href],
    .badge-warning[href] {
      background-color: #c67605;
    }
    #lblCartCount {
        font-size: 12px;
        background: #FF5F00;
        color: #fff;
        padding: 0 5px;
        vertical-align: top;
        margin-left: -10px; 
    }    
</style>
<div id="top-bar" class="container">
    <div class="row">
        <div class="span4">
            <jsp:include page="_search.jsp"/>
        </div>
        <div class="span8">
            <div class="account pull-right">
                <ul class="user-menu">
                    <c:if test="${sessionScope.loginedUser !=null}">
                    <li><b>Hello ${sessionScope.loginedUser.username}</b></li>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/profile">Your profile</a> </li>
                   
                    <%
                        int cartQuantity=0;
                        if (session.getAttribute("cart") != null) {
                            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");   
                            if (cart.size() > 0) {
                                cartQuantity = cart.size();
                            }
                        }
                        if(cartQuantity > 0){
                    %> 
                    <li><a id="cart" href="${pageContext.request.contextPath}/cart"
                           ><i class="fa fa-shopping-cart"></i
                            ><span class='badge badge-warning' id='lblCartCount'><%=cartQuantity%></span></a></li>
                    <%} else {%>
                    <li><a id="cart" href="${pageContext.request.contextPath}/cart"
                           ><i class="fa fa-shopping-cart"></i
                            ><span class='badge badge-warning' id='lblCartCount'></span></a></li>
                    <%}%>
                    <li><a href="${pageContext.request.contextPath}/checkout">Checkout</a></li>	
                    
                    <c:if test="${sessionScope.loginedUser == null}">
                    <li><a href="${pageContext.request.contextPath}/login">Log in or sign up</a></li>
                    </c:if>
                    <c:if test="${sessionScope.loginedUser != null}">
                    <li><a href="${pageContext.request.contextPath}/logout">Log out</a> </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>   
</div>