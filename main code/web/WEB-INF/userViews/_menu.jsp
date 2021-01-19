<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="navbar main-menu">
    <div class="navbar-form main-menu">				
        <a href="index.html" class="logo pull-left">
            <div class="logo">
                <img src="resources/themes/img/logo/fnatic.png" class="site_logo" alt="titan">
                <p class="site_text">Titan</p>
            </div>
        </a>
        <nav id="menu" class="pull-right">
            <ul class="sf-js-enabled sf-shadow">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>					
                <li><a href="${pageContext.request.contextPath}/bestSellers">Best seller</a>					
                    <!-- <ul>
                            <li><a href="./products.html">Lacinia nibh</a></li>									
                            <li><a href="./products.html">Eget molestie</a></li>
                            <li><a href="./products.html">Varius purus</a></li>									
                    </ul> -->
                </li>															
                <li><a href="${pageContext.request.contextPath}/products">Game List</a></li>			
                <li><a href="${pageContext.request.contextPath}/categories">Game Categories</a></li>
                <li><a href="${pageContext.request.contextPath}/brands">Producer and Publisher</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
            </ul>
        </nav>
    </div>
</section>
<c:set value="${requestScope['javax.servlet.forward.servlet_path']}" var="servletPath"/>
<%
    String servletPath = pageContext.getAttribute("servletPath").toString();
    if(!servletPath.equals("/index")){
%>    
<section class="header_text sub">
    <img class="pageBanner" src="resources/themes/img/banner/fnatic-black-crop.png" alt="New products">
    <h2><span></span></h2>
</section>            
<%}%>