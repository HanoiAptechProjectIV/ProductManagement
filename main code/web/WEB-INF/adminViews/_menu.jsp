<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
    
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #bee5eb; display: flex; justify-content: flex-end">
   <div class="navbar-nav" style="display: flex; justify-content: end;">
   <a href="${pageContext.request.contextPath}/admin/home" class="nav-link">Home</a>
   |
   <a href="${pageContext.request.contextPath}/admin/brandList" class="nav-link">Brand List</a>
   |
   <a href="${pageContext.request.contextPath}/admin/categoryList" class="nav-link">Category List</a>
   |
   <a href="${pageContext.request.contextPath}/admin/productList" class="nav-link">Product List</a>
   |
   <a href="${pageContext.request.contextPath}/admin/orderList" class="nav-link">Order List</a>
   |
   <a href="${pageContext.request.contextPath}/admin/userList" class="nav-link">User List</a>
   |
   <a href="${pageContext.request.contextPath}/admin/adminList" class="nav-link">Admin List</a>
   |
   <a href="${pageContext.request.contextPath}/admin/logout" class="nav-link">Logout</a>
  </div>
</nav>