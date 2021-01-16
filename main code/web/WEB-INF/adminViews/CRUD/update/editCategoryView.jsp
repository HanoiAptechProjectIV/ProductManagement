<%-- 
    Document   : editCategoryView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>Edit Category</title>

      <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

      <!-- jQuery library -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      <!-- Popper JS -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

      <!-- Latest compiled JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

   </head>
   <body onload="selectedDisableOption();">
 
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
 
      <h3 style="text-align: center; margin-top: 40px">Edit Category</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <div class="container">
         <c:if test="${category != null}">
            <form method="POST" action="${pageContext.request.contextPath}/editCategory">
               <input type="hidden" name="id" value="${category.id}" class="form-control" />
               <div class="form-group w-50">
                  <label>Name</label>
                  <input type="text" required name="name" value="${category.name}" class="form-control" />
               </div>
               <div class="form-group w-50">
                  <label>Description</label>
                  <input type="text" name="description" value="${category.description}" class="form-control" />
               </div>
               <div class="form-group w-50">
                  <label>Disable</label>
                  <div class="col-md-12"> 
                     <div class="row">
                        <input type="text" id="disableTxt" readonly name="disable" value="${category.disable}" class="form-control col-md-6" />
                        <select id="disableOption" name="disableOption" 
                              onchange="changeDisableTxt();" class="form-control col-md-6">
                           <option value="true">True</option>  
                           <option value="false">False</option>  
                     </select> 
                     </div>
                  </div>
               </div>            
               <div>
                  <button class="btn btn-outline-success" type="submit">Submit</button>
                  <a href="${pageContext.request.contextPath}/categoryList" class="btn btn-outline-warning">Cancel</a>
               </div>
            </form>
         </c:if>
      </div>
 
      <jsp:include page="../../_footer.jsp"></jsp:include>
             <script>
                var disable = document.getElementById("disableOption"),
                    disableTxt = document.getElementById("disableTxt");
                function selectedDisableOption() {
                    Array.prototype.filter.call(disable.options, function (option) {
                        if (option.value == "${category.disable}") {
                            option.selected = true;
                        }
                    });
                }

                function changeDisableTxt() {
                    disableTxt.value = disable.value;
                }
        </script>
   </body>
</html>
