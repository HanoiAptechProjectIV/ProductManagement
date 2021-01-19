<%-- 
    Document   : _pagination
    Created on : Dec 31, 2020, 6:19:45 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<div class="pagination pagination-small pagination-centered">

<c:set value="${requestScope['javax.servlet.forward.servlet_path']}" var="servletPath"/>
<%
    String servletPath = pageContext.getAttribute("servletPath").toString();
    Object pageObj = request.getAttribute("page");
%>
<c:set var="sortByObj" value="${(sortBy != null) ? sortBy : 'nameASC'}"/>
<ul>
<c:forEach begin="1" end="${pageQuantity}" var="i">
    <c:choose>
        <c:when test="${i == 1 && page != i}">
            <li><a href="${pageContext.request.contextPath}<%=servletPath%>?page=1&sortBy=${sortByObj}"
                   style="display: inline-block">First</a></li>
        </c:when> 

        <c:when test="${i == pageQuantity && page != i}">
            <li><a href="${pageContext.request.contextPath}<%=servletPath%>?page=${pageQuantity}&sortBy=${sortByObj}"
               style="display: inline-block">Last</a></li>
        </c:when> 

        <c:when test="${page < (i-1) || page > (i+1)}">
            <li><a href="${pageContext.request.contextPath}<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               class="displayNone" style="display: none;">${i}</a></li>
        </c:when>

        <c:when test="${page == (i+1)}">
            <c:if test="${page-1 > 2}">
                <li><a id="firstEllipsis" onclick="executeEllipsis(this)"
                   style="display: inline-block"><u><b>...</b></u></a></li>
                    </c:if>

            <li><a id="previous"href="${pageContext.request.contextPath}<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               style="display: inline-block;">Prev</a></li>
        </c:when>

        <c:when test="${page == (i-1)}">
            <li><a id="next" href="${pageContext.request.contextPath}<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               style="display: inline-block;">Next</a></li>

            <c:if test="${page+2 < pageQuantity}">
                <li><a id="secondEllipsis" onclick="executeEllipsis(this)"
                   style="display: inline-block"><u><b>...</b></u></a></li>
                    </c:if>
                </c:when> 

        <c:otherwise>
            <li><a class="active" href="${pageContext.request.contextPath}<%=servletPath%>?page=${i}&sortBy=${sortByObj}"
               style="display: inline-block;">${i}</a></li>
        </c:otherwise> 
    </c:choose>
</c:forEach> 
    <li>
<c:if test="<%=pageObj != null%>">
    <form action="${pageContext.request.contextPath}<%=servletPath%>" style="display: inline-block;">
        <input style="height:15px; width: 30px; display: inline-block" type="text" size="5" maxlength="3" name="page" placeholder="${page}">
        <input style="margin-top: -12px; display: inline-block"  type="submit" value="Go">
    </form>
</c:if>
    </li>
</ul>
</div>

<script>
    <c:if test="${page != null}">
    function executeEllipsis(atag) {
        "use strict";
        var arr = document.getElementsByClassName("displayNone");
        Array.prototype.filter.call(arr, function (a) {
            var href = a.href;
            if (href[href.indexOf("&") - 1] < ${page}
            && atag.id === "firstEllipsis") {
                a.style.display = "inline-block";
                var previous = document.getElementById("previous");
                previous.textContent = "${page-1}";
            }
            if (href[href.indexOf("&") - 1] > ${page}
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
