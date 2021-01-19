<%-- 
    Document   : profile
    Created on : Dec 8, 2020, 5:15:13 PM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Your Profile</title>
    </head>
    <body onload="notification();loadGender();">

        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <section class="main-content">
                <div class="row">
                    <div class="span3"></div>
                    <div class="span6">
                        <h4 class="title">
                            <span class="text"><strong>Your profile</strong></span>
                        </h4>
                        <p id="notification" style="color: red;">${errorString}</p>

                        <c:if test="${user != null}">
                            <form id="my-form" action="${pageContext.request.contextPath}/profile" method="post" class="form-stacked">
                                id<input id="userId" type="text" readonly hidden name="id" value="${user.id}"/>
                                <fieldset>
                                    <div class="register-row">
                                        <div class="register-left register-column">
                                            <div class="control-group">
                                                <label class="control-label" for="username-register">Username: *</label>
                                                <div class="controls">
                                                    <input type="text" name="username" required value= "${user.username}" placeholder="Enter your username" class="input-large" id="username-register">
                                                </div>
                                                <span class="error" id="username-error"></span>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="password-register">Password: *</label>
                                                <div class="controls">
                                                    <input type="password" name="password" required value= "${user.password}" placeholder="Enter your password" class="input-large" id="password-register">
                                                </div>
                                                <span class="error" id="password-error"></span>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="re-password-register">Retype Password: *</label>
                                                <div class="controls">
                                                    <input type="password" name="repassword" required value= "${user.password}" placeholder="Enter your password again" class="input-large" id="re-password-register">
                                                </div>
                                                <span class="error" id="re-password-error"></span>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="email-register">Email:</label>
                                                <div class="controls">
                                                    <input type="text" name="email" value= "${user.email}" placeholder="Enter your email" class="input-large" id="email-register">
                                                </div>
                                                <span class="error" id="email-error"></span>
                                            </div>
                                        </div>

                                        <div class="register-right register-column">
                                            <div class="control-group">
                                                <label class="control-label" for="fullname-register">Full name:</label>
                                                <div class="controls">
                                                    <input type="text" name="name" value= "${user.name}" placeholder="Enter your full name" class="input-large" id="fullname-register">
                                                </div>
                                                <span class="error" id="fullname-error"></span>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="phone-register">Phone number:</label>
                                                <div class="controls">
                                                    <input type="text" name="phone" value= "${user.phone}" placeholder="Enter your phone number" class="input-large" id="phone-register">
                                                </div>
                                                <span class="error" id="phone-error"></span>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="address-register">Address:</label>
                                                <div class="controls">
                                                    <input type="text" name="address" value= "${user.address}" placeholder="Enter your address" class="input-large" id="address-register">
                                                </div>
                                                <span class="error" id="address-error"></span>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="gender">Gender:</label>
                                                <div class="controls">
                                                    <input type="radio" value="true" name="gender" id="female" class="input-large">Female
                                                    <input type="radio" value="false" name="gender" id="male" class="input-large">Male
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <hr>
                                    <div class="actions">
                                        <input tabindex="9" class="btn btn-inverse large" type="submit" value="Update your account" id="submit-button">
                                        <a href="${pageContext.request.contextPath}/">Cancel</a>
                                    </div>
                                </fieldset>
                            </form>                             
                        </c:if> 
                    </div>
                    <div class="span3"></div>
                </div>
            </section>        

            <jsp:include page="../_footer.jsp"/>
        </div>

        <script>
            function loadGender() {
            <c:if test="${user != null}">
                let male = document.getElementById("male"),
                        female = document.getElementById("female");
                if (true === ${user.gender})
                    female.checked = true;
                else
                    male.checked = true;
            </c:if>
            }

            function notification() {
                let notification = document.getElementById("notification");
                if ("${errorString}" === "Update profile successful")
                    notification.style.color = "green";
            }
        </script>
    </body>
</html>
