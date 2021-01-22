<%-- 
    Document   : notFoundView
    Created on : Jan 22, 2021, 4:00:53 PM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>
            <h3 class="center" style="color: red;"> Can not find your search</h3>
            <jsp:include page="../_footer.jsp"/>
        </div>
    </body>
</html>
