<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<div style="height: 55px; padding: 5px; margin-bottom: 10px;">
  <div>
     <h1 class="text-center" style="text-shadow: 2px 2px dimgray">Titan Game Shop</h1>
  </div>
 
  <div style="float: left; height: 60px; padding-top: 20px; text-align: right; margin:0 40px 40px;">
 
     <!-- Admin store in session with attribute: loginedAdmin -->
     Hello <b>${loginedAdmin.username}</b>
   <br/>
 
  </div>
 
</div>
