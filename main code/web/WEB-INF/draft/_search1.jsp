<%-- 
    Document   : _search1
    Created on : Jan 22, 2021, 2:43:25 PM
    Author     : Hung
--%>

<%@page import="utils.BrandDAO"%>
<%@page import="beans.Brand"%>
<%@page import="utils.CategoryDAO"%>
<%@page import="beans.Category"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.MyUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form style="display: inline;" class="search_form" method="POST" action="${pageContext.request.contextPath}/search">
    <i id="searchicon" class="fa fa-search"
       ><button id="searchBtn" type="submit"></button></i>
    <input id="searchInput" type="text" class="input-block-level search-query" 
           placeholder="Search game, category, brand" name="name" onkeyup="suggest(this)"/>
    <div id="searchSuggestDiv" class="span4"></div>
</form>
<!--old button style border: none; background-color: inherit; display: inline; margin-left: 0px; margin-top: 4px; padding-left: 0px; width: 30px;-->
<style>
    #searchicon{
        position: absolute; padding: 8px; margin-left: -30px; font-size: 14px;
    }
    #searchBtn{
        border: none; background-color: inherit; width: 14px; height: 14px; margin-left: -15px; position: absolute
    }
    #searchInput{
        display: inline; float: left; padding-right: 0px; margin-right: 0px; height: 30px;
    }
    #searchSuggestDiv{
        background-color: white;
        max-height: 309px; 
        margin-left: 0px;
        position: absolute;
        margin-top: 32px;
        z-index: 10;
    }
</style>
<%
    Connection conn = MyUtils.getStoredConnection(request);
    List<Product> prodList = ProductDAO.queryProduct(conn);
    List<Brand> braList = BrandDAO.queryBrand(conn);
    List<Category> cateList = CategoryDAO.queryCategory(conn);
%>
<script>
    let searchInput = document.getElementById("searchInput"),
        searchSuggestDiv = document.getElementById("searchSuggestDiv");

    let prodArray = [
      <%
          for(Product prod : prodList){
      %>  
              "<%=prod.getName()%>",
      <%}%>                
    ];
    
    let braArray = [
      <%
          for(Brand bra : braList){
      %>  
              "<%=bra.getName()%>",
      <%}%>                
    ];
    
    let cateArray = [
      <%
          for(Category cate : cateList){
      %>  
              "<%=cate.getName()%>",
      <%}%>                
    ];

    function suggest(input){
        prodArray.forEach(function(item, index){
            if(item.includes(input.value)){
                let element = document.createElement("LI");
                element.innerHTML = item;
                searchSuggestDiv.appendChild(element);
            }
        });
    }
</script>