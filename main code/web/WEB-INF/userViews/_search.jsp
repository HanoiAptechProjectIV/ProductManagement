<%-- 
    Document   : _search
    Created on : Dec 31, 2020, 6:44:30 AM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form style="display: inline;" class="search_form" method="POST" action="${pageContext.request.contextPath}/search">
    <i id="searchicon" class="fa fa-search"
       ><button id="searchBtn" type="submit"></button></i>
    <input id="searchInput" type="text" class="input-block-level search-query" 
           placeholder="Search game, category, brand" name="name" onkeyup="suggest(this)"/>
</form>
<style>
    #searchicon{
        position: absolute; padding: 8px; margin-left: -30px; font-size: 14px;
    }
    #searchBtn{
        border: none; background-color: inherit; width: 14px; height: 14px; margin-left: -15px; position: absolute
    }
    #searchInput{
        display: inline; float: left; padding-right: 0px; margin-right: 0px; height: 30px;
        color: black;
    }
</style>
