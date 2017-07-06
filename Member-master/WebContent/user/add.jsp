<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<style type="text/css">
#add{margin-top:30px;margin-left:30px}
</style>
<script type="text/javascript">
$(function(){
	$("[type='submit']").click(function(){	
		$.ajaxSetup({
			  async: false
		});
		var name=$.trim($("[name='name']").val());
		var pwd=$.trim($("[name='pwd']").val());
		var pwd1=$.trim($("[name='pwd1']").val());
		if(pwd==""){
			return false;
		}
		if(pwd!=pwd1){
			return false;
		}
		var regemail=/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*$/;
		if (!regemail.test(name)){
			var patrn=/^\d+$/;
			if (!patrn.test(name)){
				$("#info").html("用户名必须是会员号或邮箱号");
				return false;
			}
		}
		
		var flag = false;
		$.post("${pageContext.request.contextPath}/user/checkExists.action",{"name":$("[name='name']").val()},function(data){
				if (data == "1"){
					flag = false;
					$("#info").html("用户名已存在,请重新输入！");
				}
				else{
					flag = true;
				}
		});
		if (!flag){
			return flag;
		}		
	});
});
</script>
</head>
<body>
<div id="add">
<form action="${pageContext.request.contextPath}/user/add.action" method="post">
<table>
<tr><td>用户名</td><td><input type="text" name="name"><c:if test="${!empty username}"><font color="red">${username}</font></c:if></td></tr>
<tr><td>密码</td><td><input type="password" name="pwd"></td></tr>
<tr><td>重复密码</td><td><input type="password" name="pwd1"></td></tr>
<tr><td colspan="2"><input type="submit" value="注册"></td></tr>
</table>
<br/>
<div id="info"></div>
<br/>
<a href="login.jsp">返回登陆页面</a>
</form>
</div>
</body>
</html>