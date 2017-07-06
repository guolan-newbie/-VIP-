<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/extend/layer.ext.js"></script>
<style type="text/css">
a{font-size:16px;}
#nav{margin-left:15px;}
</style>
<script type="text/javascript">
$(function(){
	$("#lookSum").click(function(){
		$.post("${pageContext.request.contextPath}/summary/savePageC.action",function(){
			location.href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp";
		});
	});	
})
</script>
</head>
<body>
<br/>
<div id="nav">
<a href="javascript:;" id="lookSum">会员周报</a> 
<a href="${pageContext.request.contextPath}/admin/check.jsp">用户审核</a> 
<a href="${pageContext.request.contextPath}/admin/checkimage.jsp">图片审核</a> 
<a href="${pageContext.request.contextPath}/admin/fee.jsp">费用管理</a>
<a href="${pageContext.request.contextPath}/admin/amount.jsp">费用统计</a>
<a href="${pageContext.request.contextPath}/admin/initpwd.jsp">密码管理</a>
<a href="${pageContext.request.contextPath}/memberpay/Direction.action">利息市场</a>
<a href="${pageContext.request.contextPath}/admin/history.jsp">来访记录</a>
<a href="${pageContext.request.contextPath}/admin/notice.jsp">公告管理</a>
<a href="${pageContext.request.contextPath}/admin/dutymanagement.jsp">值班管理</a>
<a href="${pageContext.request.contextPath}/index.jsp">网站首页</a>
</div>
<br/>
</body>
</html>