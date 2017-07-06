<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>利息交易</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<style>
	a{color:#333}a:hover,a:focus,.maincolor,.maincolor a{color:#06c}
</style>
<script type="text/javascript">
$(function(){
	var status=0;
	$.ajaxSetup({async:false});
	$("#mobile").blur(function(){
		status=0;
		$("#msg").empty();
		var mobile=$("#mobile").val();
		$.post("${pageContext.request.contextPath}/thanksgiving/checkName.action",{"mobile":mobile},function(data){
			var data=data.split(",");
			if(data[0]=="2"){
				status=2;
			}else{
				status=1;
			}
			$("#msg").html("*"+data[1]);
		})
	});
	$("#pay").click(function(){
		var reg=/^[1-9]\d*$/;
		if(status!=2){
			return;
		}
		if(!reg.test($("#money").val())){
			$("#msg").html("*请输入有效金额(正整数)!");
			return;
		}
		$.post("${pageContext.request.contextPath}/thanksgiving/pay.action",{"mobile":$("#mobile").val(),"money":$("#money").val()},
		function(data){
			if(data==""){
			location.href="${pageContext.request.contextPath}/thanksgiving/payinfo.jsp";
			}
			else{
				$("#msg").html(data);
			}
		})
	});
})
</script>
</head>
<body>
<div class="wrap" style="padding-left:50px;margin-top:30px">
	<nav>
    	<a href="${pageContext.request.contextPath}/thanksgiving/restinfo.jsp">利息明细</a>&nbsp;|&nbsp;
		<a href="${pageContext.request.contextPath}/thanksgiving/payinfo.jsp">交易明细</a>&nbsp;|&nbsp;
		<a href="${pageContext.request.contextPath}/thanksgiving/pay.jsp">利息交易</a>
	</nav>
	<br/>
	可用利息为：<font color="red"><c:out value="${rest}"></c:out></font>元<br/>
	<form class="main form-horizontal" >
	<legend>利息交易</legend>
	<div id="msg" class="controls"></div>
	<div class="control-group">
	      <label class="control-label">*手机号码</label>
	      <div class="controls">
	          <input id="mobile" type="text" placeholder="*对方手机号码" class="input-xlarge"  required>
	      </div>
	</div>
	<div class="control-group">
	      <label class="control-label">*金额</label>
	      <div class="controls">
	          <input id="money" type="text" placeholder="*输入整数金额" class="input-xlarge"  required>
	      </div>
	</div>
    <div class="control-group">  
        <label class="control-label"></label>  
    	<div class="controls">  
           	<button class="btn" type="button" id="pay" >赠予</button>  
    	</div>  
	</div>   
	</form>
</div>
</body>
</html>