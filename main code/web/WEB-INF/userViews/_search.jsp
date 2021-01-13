<%-- 
    Document   : _search
    Created on : Dec 31, 2020, 6:44:30 AM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<p style="display: inline;">Search Product, Brand, Category name</p>
<form style="display: inline;" method="POST" action="${pageContext.request.contextPath}">
    <input type="text" name="search"/>
    <input type="submit" value="Search"/>
</form>
