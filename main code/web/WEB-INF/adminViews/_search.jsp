<%-- 
    Document   : _search
    Created on : Dec 31, 2020, 6:44:30 AM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set value="${requestScope['javax.servlet.forward.servlet_path']}" var="servletPath"/>
<%
    String servletPath = pageContext.getAttribute("servletPath").toString();
    String typeEntity = servletPath.substring(servletPath.indexOf("admin")+6, servletPath.indexOf("List"))
            .replace((""+servletPath.charAt(7)), (""+servletPath.charAt(7)).toUpperCase());
    String name = (typeEntity.equals("Order")) ? "user name" : "name";
    String search = request.getParameter("search");
%>
        <div class="container" style="display: flex; justify-content: space-between">
            <% if(search == null && !typeEntity.equals("Order") && !typeEntity.equals("User")){%>
        <div>
            <a href="create<%=typeEntity%>" class="btn btn-outline-primary">Create <%=typeEntity%></a>
        </div>
        <%}else{}%>
            <form method="POST" action="${pageContext.request.contextPath}<%=servletPath%>">
                <div class="input-group">
                    <input type="text" name="search" class="form-control input-large" style="min-width: 300px" placeholder='Search <%=typeEntity +" by "+name%>'/>
                    <!-- <input type="submit" value="Search"/> -->
                    <button class="btn btn-primary" type="submit">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                        </svg>
                    </button>
                </div>
            </form>
        </div>
        
    <br/>
