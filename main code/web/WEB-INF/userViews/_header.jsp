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

<![endif]-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css"/>

<div id="top-bar" class="container">
    <div class="row">
        <div class="span4">
            <form method="POST" class="search_form">
                <input type="text" class="input-block-level search-query" placeholder="Search">
            </form>
        </div>
        <div class="span8">
            <div class="account pull-right">
                <ul class="user-menu">
                    <li><b>Hello ${sessionScope.loginedUser.username}</b></li>
                    <li><a href="${pageContext.request.contextPath}/profile">Your profile</a> </li>
                    <li><a href="${pageContext.request.contextPath}/cart">Your cart</a></li>
                    <li><a href="${pageContext.request.contextPath}/checkout">Checkout</a></li>					 
                    <li><a href="${pageContext.request.contextPath}/login">Log in or sign up</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Log out</a> </li>
                </ul>
            </div>
        </div>
    </div>   
</div>