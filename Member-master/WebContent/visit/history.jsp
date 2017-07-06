<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>访问历史-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>

    
<script type="text/javascript">

$(function(){
	$.ajaxSetup({
		  async: false
	});
	    var vid="";
	    vid="${visitor.id}";
		$.post("${pageContext.request.contextPath}/visit/getOne.action",{vid:vid,pageno:$("#page").val()},function(data){
			$("#visits").append("<thead><tr class='text-c'><th>序号</th><th>来访时间</th><th>访问的url</th><th>用户类型</th></tr></thead>");
			for(i=0;i<data.length;i++)
			{
				if(data[i].url==null)
				{
				 	data[i].url="";
				}
				var d=	new Date();
				var l="";
				d.setTime(data[i].visitTime);
				var s=d.format('yyyy-MM-dd HH:mm:ss');
				var b=	new Date();
				var u=(data[i].agent);
				if(u==true){
					u="电脑用户";
				}
				if(u==false){
					u="手机用户";
				}
				$("#visits").append("<tr class='text-c'><td>"+(i+1)+"</td><td>"+s+"</td><td>"+(data[i].url)+"</td><td>"+u+"</td></tr>")
			}
			},"json")
})	

</script>

</head>
<body>


<br/>
<br/>
	<h1 align="center">访问历史</h1>
	<div id="title"  class="cl pd-5 bg-1 bk-gray mt-20" >
		<span style="color:#F5FAFE">1</span> 
	</div>
<br/>
<c:choose>
	<c:when test="${param.pageno==''}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pageno==null}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pageno!=null}">
		<input type="hidden" id="page" value="${param.pageno+1}"> 
	</c:when>
</c:choose>
<div class="mt-20">
<table class="table table-border table-bg table-bordered radius"></table>
</div>
</div>
<div id="page-footer"  style="padding-left:200px">
<a href="${pageContext.request.contextPath}/visit/history.jsp?pageno=1">首 页</a>	
<a href="${pageContext.request.contextPath}/visit/history.jsp?pageno=${param.pageno-1}">上一页</a>
<a href="${pageContext.request.contextPath}/visit/history.jsp?pageno=${param.pageno+1}">下一页</a>
<a id="pagecount" href="${pageContext.request.contextPath}/visit/history.jsp?pageno=${pagecount}">尾页</a>
<c:choose>
	<c:when test="${param.pageno==null}">
		当前第1页<span id="pageCount"></span>
	</c:when>
	<c:when test="${param.pageno!=null}">
		<strong>当前第${param.pageno+1}页</strong><span id="pageCount"></span>
	</c:when>
</c:choose>	

				
			<!-- 正文 结束-->




</body>
</html>