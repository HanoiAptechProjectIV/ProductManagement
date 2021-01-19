<%-- 
    Document   : _login
    Created on : Dec 8, 2020, 5:42:43 AM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
<!-- bootstrap -->
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>      
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"/>

<link href="${pageContext.request.contextPath}/resources/themes/css/bootstrappage.css" rel="stylesheet"/>

<!-- global styles -->
<link href="${pageContext.request.contextPath}/resources/themes/css/flexslider.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/themes/css/main.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/themes/css/jquery.fancybox.css" rel="stylesheet"/>

<script src="${pageContext.request.contextPath}/resources/themes/js/jquery-1.7.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/themes/js/superfish.js"></script>	
<script src="${pageContext.request.contextPath}/resources/themes/js/jquery.scrolltotop.js"></script> 

<![endif]-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css"/>        
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <section class="main-content">
                <div class="row">
                    <div class="span4"></div>
                    <div class="span4">
                        <h4 class="title">
                            <span class="text"><strong>Login</strong> Form</span>
                        </h4>
                        <p style="color: red;">${errorString}</p>
                        <form method="POST" action="${pageContext.request.contextPath}/login">
                            <input type="hidden" name="next" value="/">
                            <fieldset>
                                <div class="control-group">
                                    <label class="control-label" for="username-login">Username</label>
                                    <div class="controls">
                                        <input type="text" name="username" value= "${user.username}"
                                               placeholder="Enter your username" id="username-login" class="input-xlarge">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="password-login">Password</label>
                                    <div class="controls">
                                        <input type="password" name="password" value= "${user.password}"
                                               placeholder="Enter your password" id="password-login" class="input-xlarge">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">Remember me
                                        <input type="checkbox" name="rememberMe" value= "Y" class="input-xlarge"/>
                                    </label>
                                </div>
                                <div class="control-group">
                                    <input tabindex="3" class="btn btn-inverse large" type="submit" value="Login">
                                    <a href="signup">Sign up</a>
                                    <a href="${pageContext.request.contextPath}/">Cancel</a>
                                    <hr>
                                    <p class="reset">
                                        Recover your
                                        <a tabindex="4" href="#" title="Recover your username or password">username or password</a>
                                    </p>
                                </div>
                            </fieldset>
                        </form>
                    
                    <p style="color:blue;">User Name: customer, password: 123</p>                                    
                    </div>
                    <div class="span4"></div>
                </div>
            </section>

            <jsp:include page="../_footer.jsp"/>
        </div>
<!-- scripts -->
<script src="${pageContext.request.contextPath}/resources/themes/js/common.js"></script>
<script src="${pageContext.request.contextPath}/resources/themes/js/jquery.flexslider-min.js"></script>
<script src="${pageContext.request.contextPath}/resources/themes/js/jquery.fancybox.js"></script>
<script type="text/javascript">
    $(function () {
        $(document).ready(function () {
            $('.flexslider').flexslider({
                animation: "fade",
                slideshowSpeed: 4000,
                animationSpeed: 600,
                controlNav: false,
                directionNav: true,
                controlsContainer: ".flex-container" // the container that holds the flexslider
            });
        });
    });
</script>
    </body>
</html>
