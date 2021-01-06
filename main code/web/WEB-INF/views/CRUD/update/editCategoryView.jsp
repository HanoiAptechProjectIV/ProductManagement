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
   </head>
   <body onload="selectedDisableOption();">
 
      <jsp:include page="../../_header.jsp"></jsp:include>
      <jsp:include page="../../_menu.jsp"></jsp:include>
 
      <h3>Edit Category</h3>
 
      <p style="color: red;">${errorString}</p>
 
      <c:if test="${not empty category}">
         <form method="POST" action="${pageContext.request.contextPath}/editCategory">
            <input type="hidden" name="id" value="${category.id}" />
            <table border="0">
            <tr>
               <td>Name</td>
               <td><input type="text" name="name" value="${category.name}" /></td>
            </tr>
            <tr>
               <td>Description</td>
               <td><input type="text" name="description" value="${category.description}" /></td>
            </tr>
            <tr>
               <td>Disable</td>
               <td><input type="text" id="disableTxt" readonly name="disable" value="${category.disable}" />
                    <select id="disableOption" name="disableOption" 
                            onchange="changeDisableTxt();">
                        <option value="true">True</option>  
                        <option value="false">False</option>  
                    </select> 
               </td>
            </tr>            
            <tr>
               <td colspan = "2">
                   <input type="submit" value="Submit" />
                   <a href="${pageContext.request.contextPath}/categoryList">Cancel</a>
               </td>
            </tr>
            </table>
         </form>
      </c:if>
 
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
