<%-- 
    Document   : _search
    Created on : Dec 31, 2020, 6:44:30 AM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form style="display: inline;" method="POST" action="${pageContext.request.contextPath}">
    <input type="text" placeholder="search something by name" name="search" size="50"/>
    <input type="submit" value="Search"/>
</form>
