<%-- 
    Document   : brandsView
    Created on : Jan 14, 2021, 9:14:41 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Brand List</title>
    </head>
    <body>

        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <p style="color: red;">${errorString}</p>
            <section class="main-content">
                <div class="row">
                    <div class="span12">
                        <div class="row">
                            <div class="span9">

                                <h4 class="title">
                                    <span class="pull-left"><span class="text"><span class="line">Brand<strong> List</strong></span></span></span>
                                </h4>

                                <ul class="thumbnails listing-products">	
                                    <c:if test="${brandList.size() > 0}">
                                        <c:forEach items="${brandList}" var="brand" >
                                            <c:if test="${brand != null}">                                    
                                                <li class="span3" style="min-height: 300px;">
                                                    <div class="product-box">

                                                        <p><a href="${pageContext.request.contextPath}/brands?search=${brand.name}">
                                                                <img alt="${brand.name} logo" 
                                                                     src="${pageContext.request.contextPath}/images/brand/${brand.logo}">
                                                            </a></p>
                                                        <a href="${pageContext.request.contextPath}/brands?search=${brand.name}"
                                                           class="title">${brand.name}</a><br>
                                                        <p class="manufacture">${brand.manufacturer}</a><br>

                                                    </div>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>                                         
                                </ul>

                                <jsp:include page="../_pagination.jsp"/>                        
                            </div>						
                            <jsp:include page="../_rightMenu.jsp"/>
                        </div>
                        <br/>
                    </div>
                </div>
            </section>


        <jsp:include page="../_footer.jsp"/>
        </div>
</body>
</html>

