<%-- Document : _login Created on : Dec 8, 2020, 5:42:43 AM Author : Hung --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Login</title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<link rel="stylesheet" type="text/css" href="../css/app.css" />
  </head>
  <body>
	<jsp:include page="_header.jsp"></jsp:include>
	<!-- <div class="main-content container"> -->
		<!-- <div class="menu">s -->
		<jsp:include page="_menu.jsp"></jsp:include>
	<!-- </div> -->

    <div class="container">
      <h3 class="login">Login</h3>

      <form method="POST" action="${pageContext.request.contextPath}/adminLogin"">
        <div class="form-group w-25">
          <label for="username">Username:</label>
          <input
            type="text"
            class="form-control"
            name="username"
            id="username"
            value="${admin.username}"
          />
        </div>
        <div class="form-group w-25">
          <label for="password">Password:</label>
          <input
            type="password"
            class="form-control"
            name="password"
            id="password"
            value="${admin.password}"
          />
		</div>
		<p style="color: red">${errorString}</p>
		<dỉv class="invalid-feedback">${errorString}</dỉv>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="Y" name="rememberMe" />
            Remember me
          </label>
        </div>
        <button type="submit" class="btn btn-outline-success">Submit</button>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-warning">Cancel</a>
      </form>

      <p style="color: blue">User Name: admin, password: 123</p>
    </div>
	</div>
    

    <jsp:include page="_footer.jsp"></jsp:include>
  </body>
</html>
