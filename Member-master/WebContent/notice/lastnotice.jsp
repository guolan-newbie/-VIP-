<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
		<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css" />
				<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<title>最新公告</title>
<script type="text/javascript">
$(function(){
	$.post("${pageContext.request.contextPath}/notice/getLastestNotice.action",function(data){
		if(data=="")
			return;
		var data=eval("data="+data); 
		var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
		var title=$("<p>").addClass("title").appendTo(condiv);
		$("<p>"+data.title+"</p>").addClass("title").appendTo(title);
		$("<span>"+data.content+"</span>").addClass("condivtil").appendTo(title);
		$("<br>").appendTo(condiv);
		var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
		var iconspaniner=$("<span>").attr({style:"font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
		$("<span>"+"管理员 "+data.realname+" 发表于 "+data.publishtime+"</span>").addClass("icon1iner").appendTo(iconspaniner)
		$("<hr>").appendTo(condiv);
	});
});
</script>
</head>
<body>
		<div class="mywridiv">
			<span class="mywridivspan">最新公告</span>
		</div>
		<div id="contentdiv" style="margin-top: -23px;word-break: break-all;">
			<hr color="#00CCFF" style="height: 3px;" />
		</div>
</body>
</html>