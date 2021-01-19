<%-- 
    Document   : index
    Created on : Jan 13, 2021, 7:41:28 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Home Page</title>
    </head>
    <body>

        <jsp:include page="_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="_menu.jsp"/>
            <jsp:include page="_homepageSlider.jsp"/>
            <jsp:include page="_headerText.jsp"/>
<p style="color: red;">${errorString}</p>
            <jsp:include page="_mainContent.jsp"/>

            <jsp:include page="_featureBox.jsp"/>
            <jsp:include page="_ourClient.jsp"/>
            <jsp:include page="_footer.jsp"/>
        </div>

    </body>
</html>
