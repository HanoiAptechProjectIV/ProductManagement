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
    String typeEntity = servletPath.substring(0, servletPath.indexOf("List"))
            .replace("/"+servletPath.charAt(1), (""+servletPath.charAt(1)).toUpperCase());
    String name = (typeEntity.equals("Order")) ? "user name" : "name";
    String search = request.getParameter("search");
%>
        <table border="0" cellpadding="5" cellspacing="1" >
            <tr>
                <td>Search <%=typeEntity +" by "+name%></td>
                <td>
                    <form method="POST" action="${pageContext.request.contextPath}<%=servletPath%>">
                        <input type="text" name="search"/>
                        <input type="submit" value="Search"/>
                    </form>
                </td>
            </tr>
            <tr></tr>
            <% if(search == null && !typeEntity.equals("Order") && !typeEntity.equals("User")){%>
            <tr>
                <td><a href="create<%=typeEntity%>" >Create <%=typeEntity%></a></td>
            </tr>
            <%}else{}%>
        </table>
        <br/>
