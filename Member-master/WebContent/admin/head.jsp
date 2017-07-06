<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>费用管理-Java互助学习VIP群业务运行系统</title>
	

	
<!-- Le styles -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    <!-- Fav and touch icons -->
    
 
<script type="text/javascript">
$(function(){
	$("#main-content").load("${pageContext.request.contextPath}/admin/fee.jsp");
	$("[title='用户审核']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/check.jsp");
			});
	$("[title='图片审核']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/checkimage.jsp");
			});
	$("[title='值班日志审核']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/ondutylog/toCheck.action");
				$.layer.close();
			});
	$("[title='密码管理']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/initpwd.jsp");
			});
	$("[title='费用管理']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/fee.jsp");
			});
	$("[title='公告管理']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/notice.jsp");
			});
	$("[title='费用统计']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/amount.jsp");
			});
	$("[title='利息市场']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath }/memberpay/main.action");
				$.layer.close();
			});
	$("[title='来访记录']").click(function()
			{
				$("#main-content").load("${pageContext.request.contextPath}/admin/history.jsp");
			});
	
});
$(function(){
	
	//$("#lookSum").click(function(){
		//$.post("${pageContext.request.contextPath}/summary/savePageC.action",function(){
			//$("#main-content").load("${pageContext.request.contextPath}/ueditor/membersum.jsp",{"pages":"+1"});
			location.href="${pageContext.request.contextPath}/ueditor/membersum.jsp?pages="+1;
		});
</script>

</head>
<body>
<br/>
<c:if test="${myuser.member.flag}">
<jsp:include page="/admin/navbar.jsp"></jsp:include>
</c:if>
 
</body>
</html>