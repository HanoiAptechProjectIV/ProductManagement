<%-- 
    Document   : editOrderView
    Created on : Dec 8, 2020, 5:19:39 PM
    Author     : Hung
--%>

<%@page import="utils.UserDAO"%>
<%@page import="beans.User"%>
<%@page import="java.util.List"%>
<%@page import="beans.OrderDetail"%>
<%@page import="utils.ProductDAO"%>
<%@page import="beans.Product"%>
<%@page import="utils.MyUtils"%>
<%@page import="java.sql.Connection"%>
<%@page import="beans.Order"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Order</title>
    </head>
    <body onload="selectedNameOption();selectedStatusOption();findMaxValueQuantity();calculateAmount();">

        <jsp:include page="../../_header.jsp"></jsp:include>
        <jsp:include page="../../_menu.jsp"></jsp:include>

            <h3 style="text-align: center; margin-top: 40px">Edit Order</h3>

            <p style="color: red;">${errorString}</p>
        <%
            Connection conn = MyUtils.getStoredConnection(request);
            List<Product> listProduct = ProductDAO.queryProduct(conn);
            List<OrderDetail> listDetail = (List<OrderDetail>) request.getAttribute("orderDetail");
            Order order = (Order) request.getAttribute("order");

            if (listDetail.size() > 0 && order != null) {
                User user = UserDAO.findUser(conn, order.getUserId());
        %>
        
        <div class="container">
            <form method="POST" action="${pageContext.request.contextPath}/admin/editOrder">
                <strong>Order</strong>
                <div class="form-group w-50">
                    <label>Order id</label>
                    <input class="form-control" type="text" readonly name="id" value="${order.id}"/>
                </div>
                <div class="form-group w-50">
                    <label>User Name</label>
                    <input class="form-control" type="hidden" name="userId" value="${order.userId}"/>
                        <div id="userAnchor">
                            <a class="btn btn-outline-primary" href="userList?search=<%=user.getName()%>"><%=user.getName()%></a>
                        </div>
                        <div id="userDiv">
                            <ul>
                                <li><b>Gender:</b> <%=(user.isGender()) ? "Female" : "Male"%></li>
                                <li><b>Phone:</b> <%=user.getPhone()%></li>
                                <li><b>Email:</b> <%=user.getEmail()%></li>
                                <li><b>Address:</b> <%=user.getAddress()%></li>
                            </ul>
                        </div>
                    
                </div>
                <div class="form-group w-50">
                    <label>Amount</label>
                    <input class="form-control" id="amountTxt" type="text" readonly name="amount" value="${order.amount}" />
                </div>
                <div class="form-group w-50">
                    <label>Created time</label>
                    <input class="form-control" type="text" readonly name="createdTime" value="${order.createdTime}" />
                </div>
                <div class="form-group w-50">
                    <label>Payment time</label>
                    <div class="col-md-12">
                        <div class="row">
                            <input class="form-control col-md-7" id="paymentTimeInput" type="text" name="paymentTime" value="<%
                            LocalDateTime ldt = LocalDateTime.of(1970, 1, 1, 0, 0, 0);
                            if (!order.getPaymentTime().equals(ldt)) {
                                %><%=order.getPaymentTime()%><%}%>" /><br>
                            <input class="btn btn-outline-primary col-md-5" type="button" onclick="getCurrentTime();" value="Get Current Time"/>
                        </div>
                    </div>
                    
                </div>

                <table class="table table-bordered table-striped table-hover" border="1" cellpadding="5" cellspacing="1" >
                    <tr><strong>Order detail</strong></tr>
                    <tr class="table-info">
                        <th>Order Detail Id</th>
                        <th>Product name</th>
                        <th>Price</th>
                        <th>Purchase quantity</th>
                        <th>Status</th>
                    </tr>
                    <%
                        for (OrderDetail detail : listDetail) {
                            pageContext.setAttribute("orderDetail", detail);
                            Product prod = ProductDAO.findProduct(conn, detail.getProductId());
                            if (prod != null) {
                                if (listProduct.size() > 0) {
                    %>
                    <tr>
                        <td style="width: 10%">
                            <div class="form-group">
                                <input class="form-control" type="text" readonly name="idOrderDetail${orderDetail.id}" 
                                   value="${orderDetail.id}" />
                            </div>
                        </td>
                        <td style="max-width: 32%">
                            <div class="col-md-12">
                            <div class="form-group row">
                                <div id="productAnchor" class="col-md-5">
                                    <a class="btn btn-outline-primary productNameAnchor" href="productList?search=<%=prod.getName()%>"
                                    ><%=prod.getName()%></a>
                                </div>
                                <div id="productDiv" class="col-md-2">
                                    <img src="<%=prod.getImage()%>" 
                                        height="30" alt="<%=prod.getName()%> image"/>
                                    <p> | Quantity: <%=prod.getQuantity()%></p>
                                </div>
                                <select style="font-size: 15.5px;" class="productNameOption form-control col-md-7" required name="productNameOptionId${orderDetail.id}"
                                        onchange="findMaxValueQuantity();changeProductNameAnchor();calculateAmount();">
                                    <%for (Product product : listProduct) {%>
                                    <option value="<%=product.getName()%>"><%=product.getName()%></option>  
                                    <%}%>
                                </select>  
                            </div>
                            </div>
                        </td>   
                        <td style="width: 14%">
                            <div class="col-md-12">
                                <div class="form-group row">
                                    <input class="priceTxt form-control col-sm-8" type="text" readonly value="<%=prod.getPrice()%>"
                                           size="15" style="font-size: 15.5px;"/>
                                <p class="col-sm-4" style="margin-top: 6px;">VND</p>
                            </div>
                            </div>
                        </td>
                        <td style="width: 14%;">
                            <div class="form-group">
                                <input class="quantityNumber form-control" required onchange="calculateAmount();" 
                                   type="number" name="purchasedQuantityId${orderDetail.id}" 
                                   value="${orderDetail.purchasedQuantity}" />
                            </div>
                        </td>
                        <td style="max-width: 30%;">
                            <div class="col-md-12">
                                <div class="form-group row">
                                <input class="statusTxt form-control col-md-7" type="text" readonly size="10"
                                   name="status${orderDetail.id}" value="${orderDetail.status}" />
                                <select class="statusOption form-control col-md-5" required name="statusOptionId${orderDetail.id}" 
                                    onchange="changeStatusText();calculateAmount();">
                                <option value="Pending">Pending</option>  
                                <option value="Confirmed">Confirmed</option>  
                                <option value="Canceled">Canceled</option>  
                                <option value="Success">Success</option> 
                            </select>
                            </div>  
                            </div>
                        </td>
                    </tr>
                    <%}
                            }
                        }%>
                </table>
                <tr></tr>
                <style>
                    #addedTable{
                    }
                </style>
                <table class="table table-bordered table-striped table-hover" id="addProductTable" border="1" cellpadding="5" cellspacing="1">
                    <tr><strong>Add product</=></strong></tr>
                    <tr class="table-info">
                        <th>Product name</th>
                        <th>Price</th>
                        <th>Purchased quantity</th>
                        <th>Status</th>
                        <th>Delete</th>
                    </tr>
                    <tr>
                        <div class="form-group" style="display: flex; flex-direction: row;">
                            <input class="btn btn-outline-primary" type="button" onclick="addRow();" value="Add +"/>
                            <input class="form-control col-sm-2" id="countRowTxt" type="text" value="0" name="countRow"/>
                        </div>
                    </tr>
                </table>
                <tr><hr></tr>
                <tr>
                    <td colspan = "2">
                        <button class="btn btn-outline-success" type="submit">Submit</button>
                        <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/admin/orderList">Cancel</a>
                    
                </tr>
        </form>
        </div>

        <jsp:include page="../../_footer.jsp"></jsp:include>
        <style>
            #productAnchor, #userAnchor{
                width: fit-content;
                display: inline;
            }
            #userDiv, #productDiv{display:none}
            #userAnchor:hover + #userDiv, #productAnchor:hover + #productDiv{display: block; margin: 0px}
            #userDiv p, #productDiv p, #productDiv img{ display: inline; }
            #userNameOption, #productNameOption{display: inline; margin-top: 5px;}
            #productDiv img{
                margin-bottom: -8px;
            }
        </style>         
            <script>
                let i = 0,
                        countAddedRow = 0,
                        priceTxts = document.getElementsByClassName("priceTxt"),
                        statusTxts = document.getElementsByClassName("statusTxt"),
                        statusSelects = document.getElementsByClassName("statusOption"),
                        nameSelects = document.getElementsByClassName("productNameOption"),
                        quantityNumbers = document.getElementsByClassName("quantityNumber"),
                        productAnchors = document.getElementsByClassName("productNameAnchor"),
                        amount = document.getElementById("amountTxt"),
                        table = document.getElementById("addProductTable"),
                        nameQuantityMap = new Map(),
                        namePriceMap = new Map();
            <%
                    for (Product product : listProduct) {
            %>
                nameQuantityMap.set("<%=product.getName()%>", <%=product.getQuantity()%>);
                namePriceMap.set("<%=product.getName()%>", <%=product.getPrice()%>);
            <%}%>

                function selectedNameOption() {
            <%
                    for (int i = 0; i < listDetail.size(); i++) {
                        Product product = ProductDAO.findProduct(conn, listDetail.get(i).getProductId());
            %>
                    Array.prototype.forEach.call(nameSelects[<%=i%>].options, function (option) {
                        if (option.value === "<%=product.getName()%>") {
                            option.selected = true;
                        }
                    });
            <%}%>
                }
                
                function selectedStatusOption() {
            <%
                    for (int i = 0; i < listDetail.size(); i++) {
            %>
                    Array.prototype.forEach.call(statusSelects[<%=i%>].options, function (option) {
                        if (option.value === "<%=listDetail.get(i).getStatus()%>") {
                            option.selected = true;
                        }
                    });
            <%}%>
                }

                function findMaxValueQuantity() {
                    i = 0;
                    Array.prototype.forEach.call(nameSelects, function (option) {
                        let min = document.createAttribute("min");
                        let max = document.createAttribute("max");
                        max.value = nameQuantityMap.get(option.value);
                        min.value = 1;
                        quantityNumbers[i].setAttributeNode(max);
                        quantityNumbers[i].setAttributeNode(min);
                        if(quantityNumbers[i].max <= 0) {
                            quantityNumbers[i].min = 0;
                        }
                        if(quantityNumbers[i].name.indexOf("purchasedQuantity") >= 0
                                && quantityNumbers[i].max*1 < quantityNumbers[i].value*1){
                            quantityNumbers[i].removeAttribute("max");
                            quantityNumbers[i].removeAttribute("min");
                            quantityNumbers[i].readOnly = true;
                        } else {
                            quantityNumbers[i].readOnly = false;
                        }
                        i++;
                    });
                }
                
                function calculateAmount() {
                    i = 0;
                    let amountNum = 0;
                    Array.prototype.forEach.call(nameSelects, function (option) {
                        if (statusSelects[i].value !== "Canceled"
                                && statusSelects[i].value !== ""
                                && option.value !== "") {
                            amountNum += namePriceMap.get(option.value) * quantityNumbers[i].value;
                        }
                        i++;
                    });
                    amount.value = amountNum;
                }  
                
                function getCurrentTime() {
                    let date = new Date();
                    date.setTime(date.getTime() + 25200000);
                    let nowStr = date.toISOString();
                    nowStr = nowStr.substring(0, nowStr.lastIndexOf(":") + 3);
                    let paymentTime = document.getElementById("paymentTimeInput");
                    paymentTime.value = nowStr;
                }
                
                function changeProductNameAnchor() {
                    i = 0;
                    Array.prototype.forEach.call(nameSelects, function (option) {
                        productAnchors[i].href = "productList?search=" + option.value;
                        productAnchors[i].innerText = option.value;
                        priceTxts[i].value = (namePriceMap.get(option.value) === undefined)
                                             ? "" : namePriceMap.get(option.value);
                        i++;
                    });
                }

                function changeStatusText() {
                    i = 0;
                    Array.prototype.forEach.call(statusSelects, function (option) {
                        statusTxts[i].value = option.value;
                        i++;
                    });
                }

                function copyAttributes(attributes, element){
                    Array.prototype.slice.call(attributes).forEach(function (value, index, array) {
                        element.setAttribute(value.nodeName, value.nodeValue);
                    });                    
                }
                
                function renameAddedElements(){
                    //change countRow named input tag value
                    let countRowTxt = document.getElementById("countRowTxt");
                    countRowTxt.value = countAddedRow+"";
                    
                    let sliceArr = (arr)=> Array.prototype.slice.call(arr),
                        count = 0;
                    sliceArr(table.children[0].children).forEach(function(value, index, array){
                        if(index !==0 && index !==1 && index !== array.length-1){
                            count++;
                            sliceArr(value.children).forEach(function(value1, index1, array1){
                                if(index1 !==1 && index1 !==4)
                                sliceArr(value1.children).forEach(function(value2, index2, array2){
                                    value2.name = value2.name.slice(0, value2.name.lastIndexOf("Id"));
                                    value2.name = (value2.name.indexOf("Added") !== -1)
                                                  ? value2.name+count : value2.name +"Added"+count;
                                });
                            });
                            if (count > countAddedRow) return;
                        }
                    });  
                }
                
                function addRow() {
                    countAddedRow++;
                    let count = table.rows.length,
                            newRow = table.insertRow(count - 1);

                    let newCell1 = newRow.insertCell(0),
                            element1 = document.createElement("A"),
                            element2 = document.createElement("SELECT"),
                            option = document.createElement("OPTION"),
                            productNodes = nameSelects[0].childNodes;

                    copyAttributes(productAnchors[0].attributes, element1);
                    copyAttributes(nameSelects[0].attributes, element2);
                    element2.appendChild(option);
                    for (let i = 1; i < productNodes.length; i += 2) {
                        let cln = productNodes[i].cloneNode(true);
                        element2.appendChild(cln);
                    }
                    element2.options[0].selected = true;

                    let newCell2 = newRow.insertCell(1),
                            element3 = document.createElement('INPUT'),
                            element4 = document.createElement("H6");

                    copyAttributes(priceTxts[0].attributes, element3);
                    element3.value = "";
                    element4.style.display = "inline";
                    element4.innerHTML = "VND";

                    let newCell3 = newRow.insertCell(2),
                            element5 = document.createElement("INPUT");

                    copyAttributes(quantityNumbers[0].attributes, element5);
                    element5.value = "0";
                    element5.readOnly = true;

                    let newCell4 = newRow.insertCell(3),
                            element6 = document.createElement("INPUT"),
                            element7 = document.createElement("SELECT"),
                            option2 = document.createElement("OPTION"),
                            statusNodes = statusSelects[0].childNodes;

                    copyAttributes(statusTxts[0].attributes, element6);
                    element6.value = "";
                    copyAttributes(statusSelects[0].attributes, element7);
                    element7.appendChild(option2);
                    for (let i = 1; i < statusNodes.length; i += 2) {
                        let cln = statusNodes[i].cloneNode(true);
                        element7.appendChild(cln);
                    }
                    element7.options[0].selected = true;

                    let newCell5 = newRow.insertCell(4),
                        element8 = document.createElement("INPUT");

                    element8.type = "button";
                    element8.value = "Delete";
                    element8.id = "deleteButton";
                    element8.addEventListener("click", function(){
                        let thisRow = element8.parentNode.parentNode,
                            thisRowIndex = Array.prototype.indexOf.call(table.children[0].children, thisRow);

                        table.children[0].removeChild(table.children[0].children[thisRowIndex]);
                        calculateAmount();
                        countAddedRow--;
                        renameAddedElements();                            
                    });

                    newCell1.appendChild(element1);
                    newCell1.appendChild(element2);
                    newCell2.appendChild(element3);
                    newCell2.appendChild(element4);
                    newCell3.appendChild(element5);
                    newCell4.appendChild(element6);
                    newCell4.appendChild(element7);
                    newCell5.appendChild(element8);
                    
                    renameAddedElements();
                }
        </script>
        <%}%>
    </body>
</html>
