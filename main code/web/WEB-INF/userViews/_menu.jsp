<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<div style="float: left; text-align: left;">
    <jsp:include page="_search.jsp"></jsp:include>
</div>

<div style="float: right; text-align: right;">
    <a href="${pageContext.request.contextPath}/">Home</a>
    |    
    <a href="${pageContext.request.contextPath}/bestSeller">Best seller</a>
    |
    <a href="${pageContext.request.contextPath}/products">Product List</a>
    |
    <a href="${pageContext.request.contextPath}/brands">Brand List</a>
    |
    <a href="${pageContext.request.contextPath}/categories">Category List</a>
    |
    <a href="${pageContext.request.contextPath}/categories">About us</a>
</div>  