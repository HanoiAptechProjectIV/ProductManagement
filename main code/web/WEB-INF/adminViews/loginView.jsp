<%-- Document : _login Created on : Dec 8, 2020, 5:42:43 AM Author : Hung --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Login</title>
    </head>
    <body>
        <jsp:include page="_header.jsp"></jsp:include>

        <div class="container">
            <h3 class="login">Login</h3>

            <form method="POST" action="${pageContext.request.contextPath}/admin/login">
                <div class="form-group w-25">
                    <label for="username">Username:</label>
                    <input class="form-control" type="text" name="username" value= "${admin.username}" />
                </div>
                <div class="form-group w-25">
                    <label for="password">Password:</label>
                    <input class="form-control" type="password" name="password" value= "${admin.password}" />
                </div>
                <div class="invalid-feedback">${errorString}</div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="rememberMe" value= "Y" />
                        Remember me
                    </label>
                </div>
                <button type="submit" class="btn btn-outline-success">Submit</button>
                <a href="${pageContext.request.contextPath}/admin/" class="btn btn-outline-warning">Cancel</a>
            </form>

        </div>


        <jsp:include page="_footer.jsp"></jsp:include>
    </body>
</html>
