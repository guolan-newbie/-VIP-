<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$("#register").click(function() {
			$.ajaxSetup({
				async : false
			});
			var oldPwd = $.trim($("[name='oldPwd']").val());
			var pwdVal = $.trim($("[name='pwd']").val());
			var pwd1 = $.trim($("[name='pwd1']").val());
			if (oldPwd == "") {
				$("#info").html("旧密码不能为空");
				return false;
			}
			if (pwdVal == "") {
				$("#info").html("密码不能为空");
				return false;
			}
			if (pwd1 == "") {
				$("#info").html("重复密码不能为空");
				return false;
			}
			if (pwdVal != pwd1) {
				$("#info").html("两次密码不一致");
				return false;
			}
			$.post("${pageContext.request.contextPath}/admin/checkAndModify.action", {
				pwd : pwdVal,
				oldPwd : oldPwd
			}, function(data) {
				if(data=="1")
				{
					$("#info").html("旧密码不正确");
				}
				if(data=="2")
				{
					layer.msg("修改完成");
					$.post("/Member/user/clearsession.action",function() {
								//window.location.href = "/Member/index.jsp";
								var index = parent.layer.getFrameIndex(window.name);
								parent.layer.close(index);
							});
				}
			});
		});

	});
</script>
</head>
<body>
	<table>
		<tr>
			<td>旧 密 码</td>
			<td><input type="password" style="display: none;"> <input type="password" name="oldPwd"></td>
		</tr>
		<tr>
			<td>密 码</td>
			<td><input type="password" name="pwd"></td>
		</tr>
		<tr>
			<td>再次输入密码</td>
			<td><input type="password" name="pwd1"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" id="register" value="确定"></td>
		</tr>
	</table>
	<div id="info"></div>
</body>
</html>