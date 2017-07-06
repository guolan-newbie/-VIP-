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

<title>历史公告</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />

<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/history.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript">
$(function(){
		var page2=1;
		getDate(page2);
		function getDate(page2){
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/notice/getNotices.action",{page2:page2},function(data){
				var dataObj = eval("("+data+")");
				var navbar=dataObj.returnMap.navbar;
				var list=dataObj.returnMap.list;
				$(".page-nav").html(navbar);
				btnclick();
				if(list.length>0){
					drawTable(list);
				}
				else{
					$("#title").html("*暂无数据...");
				}
			})
		}
		function drawTable(list){
			$("#contentdiv").empty();
			for(var i=0;i<list.length;i++){
				var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
				var title=$("<p>").addClass("title").appendTo(condiv);
				$("<p>"+list[i].title+"</p>").addClass("title").appendTo(title);
				$("<span>"+list[i].content+"</span>").addClass("condivtil").appendTo(title);
				$("<br>").appendTo(condiv);
				var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
				var iconspaniner=$("<span>").attr({style:"font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
				$("<span>"+"管理员 "+list[i].realname+" 发表于 "+list[i].publishtime+"</span>").addClass("icon1iner").appendTo(iconspaniner)
				$("<hr>").appendTo(condiv);
				}
		}
		//分页按钮点击事件
		function btnclick(){
			$(".nav-btn").click(function(){
				page2=this.lang;
				getDate(page2);
			})
		}
});
</script>
</head>
<body>
		<div class="mywridiv">
			<span class="mywridivspan">历史公告</span>
		</div>
		<div id="contentdiv" style="margin-top: -23px;word-break: break-all;">
			<hr color="#00CCFF" style="height: 3px;" />
		</div>
		<br/>
		<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>