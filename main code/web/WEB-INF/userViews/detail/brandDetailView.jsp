<%-- 
    Document   : brandDetailView
    Created on : Jan 16, 2021, 7:41:15 AM
    Author     : Hung
--%>


<%@page import="java.util.List"%>
<%@page import="beans.Brand"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Home Page</title>
    </head>
    <body>

        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>
            <%
                Brand bra = ((List<Brand>) request.getAttribute("brandList")).get(0);
            %>
            <section class="main-content">
                <div class="row">
                    <div class="span9">
                        <section class="header_text sub">
                            <span class="text"><span class="line"><h4><strong><%=bra.getName()%></strong></h4></span></span><br>							 
                            <a href="images/brand/<%=bra.getLogo()%>" class="thumbnail" data-fancybox-group="group1" 
                               title="Brand detail"
                               ><img alt="<%=bra.getName()%> image" src="images/brand/<%=bra.getLogo()%>"></a><br>
                            <span class="text"><span class="line"><h4><strong>Manufacturer</strong></h4></span></span><br>
                            <div class="tab-content">
                                <div class="tab-pane active" ><%=bra.getManufacturer()%></div>
                            </div><br>
                            <span class="text"><span class="line"><h4><strong>Description</strong></h4></span></span><br>
                            <div class="tab-content">
                                <div class="tab-pane active" ><%=bra.getDescription()%></div>
                            </div>
                        </section>
                    </div>
                    <jsp:include page="../_rightMenu.jsp"/>                    
                </div>
            </section>	            


            <jsp:include page="../_footer.jsp"/>
        </div>

    </body>
</html>            
