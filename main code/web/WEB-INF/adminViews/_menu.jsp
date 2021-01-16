<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
    
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #bee5eb; display: flex; justify-content: flex-end">
   <div class="navbar-nav" style="display: flex; justify-content: end;">
   <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">Home</a>
   
   <a href="${pageContext.request.contextPath}/brandList" class="nav-link">Brand List</a>
   
   <a href="${pageContext.request.contextPath}/categoryList" class="nav-link">Category List</a>
   
   <a href="${pageContext.request.contextPath}/productList" class="nav-link">Product List</a>
   
   <a href="${pageContext.request.contextPath}/orderList" class="nav-link">Order List</a>
   
   <a href="${pageContext.request.contextPath}/userList" class="nav-link">User List</a>
   
   <a href="${pageContext.request.contextPath}/adminList" class="nav-link">Admin List</a>
   
   <a href="${pageContext.request.contextPath}/adminLogout" class="nav-link">Logout</a>
  </div>
</nav>