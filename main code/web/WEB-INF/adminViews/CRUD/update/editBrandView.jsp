<%-- 
    Document   : editBrandView
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
        <title>Edit Brand</title>
    </head>
    <body onload="selectedDisableOption();">

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3>Edit Brand</h3>

            <p style="color: red;">${errorString}</p>

        <div class="container">
            <c:if test="${brand != null}">
            <form method="POST" action="${pageContext.request.contextPath}/admin/editBrand" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${brand.id}" />
                    <div class="form-group w-50">
                        <label>Name</label>
                        <input type="text" required name="name" value="${brand.name}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>Old logo</label>
                        <img src="${brand.logo}"
                                 height="100" alt="${brand.name} logo"/>
                    <input type="hidden" name="oldLogo" value="${brand.logo}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>New logo</label>
                        <input type="file" name="logo" value="" class="form-control"/>
                    </div>            
                    <div class="form-group w-50">
                        <label>Manufacturer</label>
                        <input type="text" name="manufacturer" value="${brand.manufacturer}" class="form-control"/>
                    </div>
                    <div class="form-group w-50">
                        <label>Description</label>
                        <input type="text" name="description" value="${brand.description}"class="form-control" />
                    </div>
                    <div class="form-group w-50">
                  <label>Disable</label>
                  <div class="col-md-12"> 
                     <div class="row">
                        <input type="text" id="disableTxt" readonly name="disable" value="${brand.disable}" class="form-control col-md-6" />
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
                        <a href="${pageContext.request.contextPath}/admin/brandList" class="btn btn-outline-warning">Cancel</a>
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
                        if (option.value == "${brand.disable}") {
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
