<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
	list-style: none;
}

.grnavbar {
	width: 100%;
	height: 30px;
	line-height: 30px;
	margin-top: 20px;
	background: #636871;
}

.grnavbar p {
	color: #fff;
	text-decoration: none;
	display: block;
	float: left;
	height: 30px;
	line-height: 30px;
	padding: 0px 50px;
	font-size: 15px;
	background: #636871;
}

.grnavbar p {
	float: left;
	position: relative;
	height: 30px;
	line-height: 30px;
}

.grnavbar p {
	margin-left: 32%;
}

#tip {
	font-size: 16px;
	color: red;
}

#tips {
	margin-left: 31%;
}

table table tr td:first-child{
	width:100px;
}
</style>
<script type="text/javascript">
	$(function() {
		$.ajaxSetup({async: false});
		getCover();
		$("#modifyPwd").click(function() {
			$("#modify").load("${pageContext.request.contextPath}/admin/modifyPwd.jsp");
		});
		$("#adminInfo").click(function(){
			window.location.reload();
		});
		//图片上传
		$(".setcover").click(function(){
				layer.open({
				    type: 2,
				    title:'头像设置',
				    area: ['700px', '550px'],
				    shift:5,
				    maxmin: true,
				    content: '${pageContext.request.contextPath}/uploading/setAdminCover.jsp',
				    end: function(){
				    	getCover();
					    }
				});	
		});
		function getCover(){
			$.post("${pageContext.request.contextPath}/picture/getAdminCover.action",function(data){
				if(data!=""){
					$("#imgdiv").html("<a href='javascript:void(0)' class='setcover'><img src='data: image/jpeg;base64,"+data.photo+"' alt='用户头像' class='img'>");
				}
				
			});
		}
	});
</script>
</head>
<body>
	<c:if test="${empty sessionScope.admin }">
		<c:redirect url="/user/login.jsp" />
	</c:if>
	<!-- 顶部 -->
	<div class="grnavbar">
		<div class="grmenu">

			<p>
				<c:if test="${sessionScope.admin.authority == 1 }">
					<span style="cursor: pointer;" id="adminInfo">超级管理员</span>
				</c:if>
				<c:if test="${sessionScope.admin.authority != 1 }">
					管理员
				</c:if>
			</p>
		</div>
	</div>
	<!-- 内容 -->
	<div class="content" align="center">
		<div class="grwrap"
			style="padding-left: 50px; margin-top: 50px; margin-bottom: 50px; z-index: 1;">
			<div class="main">
				<input type="hidden" id="id" value="${sessionScope.admin.id}"> 
				<table>
					<tr>
						<td width="500px;">
							<table class="table table-hover">
								<tr>
									<td>用户名:</td>
									<td id="name">${sessionScope.admin.name}</td>
								</tr>
								<tr>
									<td>真实姓名:</td>
									<td>${sessionScope.admin.realname}</td>
								</tr>
								<tr>
									<td style="cursor: pointer;" id="modifyPwd">修改密码</td>
									<td id="modify"></td>
								</tr>
							</table> 
						</td>
						<td>
							<div style="margin-left: 30px">
								<div id="imgdiv">
											<a class="setcover"><img
												src="${pageContext.request.contextPath}/images/user_male.png"
												alt="用户头像" class="img"></a>
								</div>
								<div id="cnav" style="margin-top: 15px; margin-left: 100px;">
									<a class="setcover">设置头像</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>

		</div>
	</div>

</body>
</html>