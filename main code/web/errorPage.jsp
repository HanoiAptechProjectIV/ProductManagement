<%-- 
    Document   : 404Page
    Created on : Jan 22, 2021, 3:02:53 PM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
            <c:if test="${pageContext.exception !=null}">
                <h3 class="center" style="color: red;">Exception is: ${pageContext.exception}  </h3>
            </c:if>
            <h3 class="center" style="color: red;">URI: ${pageContext.errorData.requestURI}  </h3>
            <h3 class="center" style="color: red;">Status code: ${pageContext.errorData.statusCode}  </h3>
    </body>
</html>
