<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
    <script type="text/javascript">
    	$(function(){
			$("#frame").load("${pageContext.request.contextPath}/notice/lastnoticeExperience.jsp");
    		$("#history").click(function(){
    			$("#frame").load("${pageContext.request.contextPath}/notice/history.jsp");
    		});
    		$("#lastnotice").click(function(){
    			$("#frame").load("${pageContext.request.contextPath}/notice/lastnoticeExperience.jsp");
    		});
    	});
    </script>
<title>Insert title here</title>
</head>
<body style="background-color:#EBF2F9;">
<span style="margin-left: 11px;">
<a href="javascript:;" style="text-decoration: none;color: #000000; font-weight: 600;" id="lastnotice">最新公告</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:;" style="text-decoration: none;color: #000000; font-weight: 600;" id="history">历史公告</a>
</span>
<br><br>
<div>
	<div id="frame" style="width:650px;height:auto; margin-left: 30px;">
	</div>
</div>
</body>
</html>