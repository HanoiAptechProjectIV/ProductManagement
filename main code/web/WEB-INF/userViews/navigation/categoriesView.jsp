<%-- 
    Document   : categoriesView
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
        <title>Category List</title>
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
                                    <span class="pull-left"><span class="text"><span class="line">Category<strong> List</strong></span></span></span>
                                </h4>

                                <ul class="thumbnails listing-products">	
                                    <c:if test="${categoryList.size() > 0}">
                                        <c:forEach items="${categoryList}" var="category" >
                                            <c:if test="${category != null}">                                    
                                                <li class="span3" style="min-height: 300px;">
                                                    <div class="product-box">

                                                        <p><a href="${pageContext.request.contextPath}/categories?search=${category.name}">
                                                                <img alt="${category.name} image" 
                                                                     src="${pageContext.request.contextPath}/images/category/category.png">
                                                            </a></p>
                                                        <a href="${pageContext.request.contextPath}/categories?search=${category.name}"
                                                           class="title">${category.name}</a><br>

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

