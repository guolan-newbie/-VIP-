<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<style type="text/css">
.main{width:500px;}
#dlDOC{font-size:24px;font-weight:bold;color:blue;cursor:pointer;color:red;}
#protocol1{width:1050px;}
</style>
<script type="text/javascript">
$(function(){
	$.post("${pageContext.request.contextPath}/user/judge.action",function(data){
		if(data=="OK")
		{
			$("#protocol1").load("${pageContext.request.contextPath}/test.jsp");
		}else{
			$("#protocol1").html("加载数据错误！");
		}
	});
	$("#dlDOC").click(function(){
		$.post("${pageContext.request.contextPath}/user/getPDF.action?id="+$("#id").val(),function(url){
			if(url!=null){
				location.href=url;
			}
		});
	});
});
</script>
</head>
<body>
<div class="main">
	<input type="hidden" id="id" value="${myuser.id}">
        <div style="text-align:right;width:1050px;"><a id="dlDOC" href="javascript:;" >[下载文档]</a></div>
		<div id="protocol1"></div>
        <br/><br/>
</div>
</body>
</html>