<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div style="background: #E0E0E0; height: 55px; padding: 5px;">
    <div style="float: left; padding-top: -10px;">
        <h1 style="float: left; padding-top: -10px;">User Site</h1>
    </div>

    <div style="align-content: stretch; text-align: center;">
        Support 24/7: 0987654321
    </div>

    <div style="float: right; padding: 10px; text-align: right;">
        Hello <b>${loginedUser.username}</b>
        |
        <a href="${pageContext.request.contextPath}/userProfile">Your profile</a>        
        |
        <a href="${pageContext.request.contextPath}/cart">Your cart</a>
        |
        <a href="${pageContext.request.contextPath}/userLogin">Log in or sign up</a>
        |
        <a href="${pageContext.request.contextPath}/userLogout">Log out</a> 
    </div>

</div>