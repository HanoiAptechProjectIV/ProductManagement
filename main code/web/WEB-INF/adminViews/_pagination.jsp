<%-- 
    Document   : _pagination
    Created on : Dec 31, 2020, 6:19:45 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<c:set value="${requestScope['javax.servlet.forward.servlet_path']}" var="servletPath"/>
<%
    String servletPath =pageContext.getAttribute("servletPath").toString().replace("/", "");
    Object pageObj = request.getAttribute("page");
%>
<c:set var="sortByObj" value="${(sortBy != null) ? sortBy : 'nameASC'}"/>
<c:forEach begin="1" end="${pageQuantity}" var="i">
    <c:choose>
        <c:when test="${i == 1 && page != i}">
            <a href="<%=servletPath%>?page=1&sortBy=${sortByObj}"
               style="display: inline-block">First</a>
        </c:when> 

        <c:when test="${i == pageQuantity && page != i}">
            <a href="<%=servletPath%>?page=${pageQuantity}&sortBy=${sortByObj}"
               style="display: inline-block">Last</a>
        </c:when> 

        <c:when test="${page < (i-1) || page > (i+1)}">
            <a href="<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               class="displayNone" style="display: none;">${i}</a>
        </c:when>

        <c:when test="${page == (i+1)}">
            <c:if test="${page-1 > 2}">
                <a id="firstEllipsis" onclick="executeEllipsis(this)"
                   style="display: inline-block"><u><b>...</b></u></a>
                    </c:if>

            <a id="previous"href="<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               style="display: inline-block;">Prev</a>
        </c:when>

        <c:when test="${page == (i-1)}">
            <a id="next" href="<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               style="display: inline-block;">Next</a>

            <c:if test="${page+2 < pageQuantity}">
                <a id="secondEllipsis" onclick="executeEllipsis(this)"
                   style="display: inline-block"><u><b>...</b></u></a>
                    </c:if>
                </c:when> 

        <c:otherwise>
            <a href="<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               style="display: inline-block;">${i}</a>
        </c:otherwise> 
    </c:choose>
</c:forEach> 

<c:if test="<%=pageObj != null%>">
|    
<form action="${pageContext.request.contextPath}/<%=servletPath%>" style="display: inline-block;">
    <input type="text" size="5" maxlength="3" name="page" placeholder="${page}">
    <input type="submit" value="Go">
</form>
</c:if>

<script>
    <c:if test="${page != null}">
    function executeEllipsis(atag) {
        "use strict";
        var arr = document.getElementsByClassName("displayNone");
        Array.prototype.filter.call(arr, function (a) {
            var href = a.href;
            if (href[href.indexOf("&")-1] < ${page}
            && atag.id === "firstEllipsis") {
                a.style.display = "inline-block";
                var previous = document.getElementById("previous");
                previous.textContent = "${page-1}";
            }
            if (href[href.indexOf("&")-1] > ${page}
            && atag.id === "secondEllipsis") {
                a.style.display = "inline-block";
                var next = document.getElementById("next");
                next.textContent = "${page+1}";
            }
        });
        atag.style.display = "none";
    }
    </c:if>
</script>
