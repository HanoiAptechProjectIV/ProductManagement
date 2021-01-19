<%-- 
    Document   : categoryDetailView
    Created on : Jan 16, 2021, 7:41:15 AM
    Author     : Hung
--%>


<%@page import="java.util.List"%>
<%@page import="beans.Category"%>
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
                Category cate = ((List<Category>) request.getAttribute("categoryList")).get(0);
            %>
            <section class="main-content">	
                <div class="row">
                    <div class="span9">
                        <section class="header_text sub">
                            <span class="text"><span class="line"><h4><strong><%=cate.getName()%></strong></h4></span></span><br>							 
                            <a href="images/category/category.png" class="thumbnail" 
                               data-fancybox-group="group1" 
                               title="Category detail"><img alt="<%=cate.getName()%> image" 
                                                         src="images/category/category.png"></a> <br>                               
                            <span class="text"><span class="line"><h4><strong>Description</strong></h4></span></span><br>							 
                            <div class="tab-content">
                                <div class="tab-pane active" ><%=cate.getDescription()%></div>
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
