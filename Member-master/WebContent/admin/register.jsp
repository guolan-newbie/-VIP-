<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$("#register").click(function(){
		$.ajaxSetup({
			  async: false
		});
		var nameVal=$.trim($("[name='name']").val());
		var pwdVal=$.trim($("[name='pwd']").val());
		var pwd1=$.trim($("[name='pwd1']").val());
		if(nameVal==""){
			$("#info").html("用户名不能为空 ");
			return false;
		}		
		if(pwdVal==""){
			$("#info").html("密码不能为空");
			return false;
		}
		if(pwd1==""){
			$("#info").html("密码不能为空");
			return false;
		}
		if(pwdVal!=pwd1){
			$("#info").html("两次密码不一致");
			return false;
		}
		var str=/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/;
		if (!str.test(nameVal)){
				$("#info").html("用户名只能输入5-20个以字母开头、可带数字、“_”、“.”的字串");
				return false;
		}		
		$.post("${pageContext.request.contextPath}/admin/add.action",{name:nameVal,pwd:pwdVal},function(data){
			alert("恭喜您，注册成功，请联系管理员获取权限");
		});
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	});

});
</script>
</head>
<body>

	<table>
		<tr><td>用户名</td><td><input type="text" name="name"></td></tr>
		<tr><td>密    码</td><td><input type="password" name="pwd"></td></tr>
		<tr><td>再次输入密码</td><td><input type="password" name="pwd1"></td></tr>
		<tr><td colspan="2"><input type="button"  id="register" value="注册"></td></tr>
	</table>	
	<div id="info"></div>
</body>
</html>