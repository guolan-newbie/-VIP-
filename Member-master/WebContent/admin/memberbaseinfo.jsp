<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
.main{width:800px;margin-left:25%;}
.img{height:200px;}
.controls{float:left;}
#info{margin-left:60px;color:red;font-size:16px;}
</style>
<script type="text/javascript">
$(function(){
	getMeb();
	getCover();
	function getCover() {
		$.ajaxSetup({async: false});
		$.post("${pageContext.request.contextPath}/picture/getCover.action", {
			"id": $("#uid").val()
		}, function (data) {
			if (data != "") {
				$("#imgdiv").html("<a href='javascript:void(0)' class='setcover'><img src='data: image/jpeg;base64," + data.photo + "' alt='用户头像' class='img'>");
			}
		});
	}
	//设置小助手
	function getMeb(){
		$.ajaxSetup({async: false});
		$.post("${pageContext.request.contextPath}/member/getMemberById.action",{"id":$("#id").val()},function(data){
			if(data.admin!=null){
				$(".assist").html("<td>学习小助手:</td><td>"+data.admin.realname+"</td>");
			}	
		});
	}
});
</script>
</head>
<body>
<div class="main" style="margin:0px;">
${myuser.member.admin.realname }
<input type="hidden" id="uid" value="${myuser.id}">
<input type="hidden" id="id" value="${myuser.member.id}">
<table>
	<tr>
	<td width="500px;">
	<table class="table table-border table-bg table-bordered radius">
		<tr>
			<td>用户名:</td>
			<td>${myuser.name}</td>
		</tr>
		<tr>
			<td>真实姓名:</td>
			<td id="name">${myuser.member.name}</td>
		</tr>
		<tr>
			<td>性别:</td>
			<td id="sex">${myuser.member.sex}</td>
		</tr>
		<tr>
			<td>学校:</td>
			<td id="school">${myuser.member.school}</td>
		</tr>
		<tr>
			<td>工作单位:</td>
			<td id="company">${myuser.member.company}</td>
		</tr>
		<tr>
			<td>移动电话:</td>
			<td id="mobile">${myuser.member.mobile}</td>
		</tr>
		<tr>
			<td>是否毕业:</td>
			<td><c:if test="${myuser.member.student=='true'}">未毕业</c:if>
				<c:if test="${myuser.member.student=='false'}">已毕业</c:if></td>
		</tr>
		<tr>
			<td>毕业时间:</td>
			<td id="graduateDate"><fmt:formatDate value="${myuser.member.graduateDate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td>注册时间:</td>
			<td id=""><fmt:formatDate value="${myuser.member.time}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td>身份证号:</td>
			<td id="province">${myuser.userInfo.idNo}</td>
		</tr>
		<tr>
			<td>QQ号码:</td>
			<td id="province">${myuser.userInfo.qqNo}</td>
		</tr>
		<tr>
			<td>支付宝账号:</td>
			<td id="province">${myuser.userInfo.payAccount}</td>
		</tr>
		<tr>
			<td>家庭联系人:</td>
			<td id="province">${myuser.userInfo.contactName}</td>
		</tr>
		<tr>
			<td>家庭联系人手机:</td>
			<td id="province">${myuser.userInfo.contactMobile}</td>
		</tr>
		<tr>
			<td>与家庭联系人关系:</td>
			<td id="province">${myuser.userInfo.relation}</td>
		</tr>
		<tr>
			<td>本人收件地址:</td>
			<td id="province">${myuser.userInfo.address}</td>
		</tr>
		<tr class="assist"></tr>
	</table>
	<!-- 去掉编辑功能
		    <div class="controls" id="btn">  
                <input class="btn" type="button" value="编辑信息">
            </div>
 	 -->
		<div id="info" class="controls"></div>
	</td>
	<td>
	<div style="margin-left:30px">
		<div id="imgdiv" style="width:250px;height:350px;">
		<c:choose>
			<c:when test="${myuser.member.sex=='男'}">
				<a class="setcover"><img src="${pageContext.request.contextPath}/images/user_male.png" alt="用户头像"
					class="img"></a>
			</c:when>
			<c:otherwise>
				<a class="setcover"><img src="${pageContext.request.contextPath}/images/user_female.png"
					alt="用户头像" class="img"></a>
			</c:otherwise>
		</c:choose>
		</div>	
	</div>
	</td>
	</tr>
</table>
</div>
</body>
</html>