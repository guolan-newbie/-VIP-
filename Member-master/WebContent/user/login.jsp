<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head lang="zh-CN">
<meta charset="utf-8">
<title>登录-专注建立IT精英圈子</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/signin.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script> 
<script type="text/javascript">
$(function(){
	$(".btn").click(function(){
		var name=$.trim($("[name='name']").val());
		if(name==""){
			//layer.msg("<b style='color:red;'>用户名未填写!</b>");
			layer.tips('用户名未填写!', '#name');
			$("[name='name']").focus();
			return false;
		}
		var pwd=$.trim($("[name='pwd']").val());
		if(pwd==""){
			layer.tips('密码不能为空!', '#pwd');
			$("[name='pwd']").focus();
			return false;
		}
		var flag = this.lang;
		var src = "${pageContext.request.contextPath}/user/check.action";
		if(flag == "admin") {
			src = "${pageContext.request.contextPath}/admin/check.action";
		}
		$.post(src,{name:name,pwd:pwd},function(data) {
			if(data == "0") {
				layer.msg("用户名密码错误!");
				$("[name='name']").focus();
			} 
			else {
				location.href="${pageContext.request.contextPath}/user/login.jsp";
			}
		});
		return false;
	});
	/* $("#admin").click(function(){
			$(".form-signin").attr("action","${pageContext.request.contextPath}/admin/check.action");
	}); */
	$(".img-circle").dblclick(function(){
		//location.href="${pageContext.request.contextPath}/user/register.jsp"; 
		location.href="${pageContext.request.contextPath}/user/register2.jsp";
		/* layer.open({
			title :'注册用户',
			type: 2,
			area: ['700px', '530px'],
			fix: false, //不固定
			maxmin: true,
			content: '${pageContext.request.contextPath}/user/register2.jsp'
		}); */
	});
});
</script>
</head>
<body>
 <c:if test="${sessionScope.TURE==null}" >
<div class="signin">
	<div class="signin-head"><img src="${pageContext.request.contextPath}/images/test/kid.png" alt="" class="img-circle"></div>
	<form class="form-signin" role="form">
		${requestScope.chmod }
		<input type="text" name="name" id="name" class="form-control" placeholder="用会员编号登录" required autofocus />
		<input type="password" name="pwd" id="pwd" class="form-control" placeholder="密码" required />
	<div>
      <div id="bt1" class="bt">
   		 <button class="btn btn-lg btn-warning btn-block" type="submit" lang="user">&nbsp;会员登录&nbsp;</button>
   	  </div>
  	  <div id="bt2" class="bt">
		<button class="btn btn-lg btn-warning btn-block" value="remember-me" lang="admin">管理员登录</button>
	  </div>
	</div>
	</form>
</div>
</c:if>

<c:if test="${sessionScope.admin!=null}">
<c:redirect url="/admin/navbar1.jsp"/>
</c:if>	

<c:if test="${sessionScope.myuser!=null}">
<c:redirect url="/member/navbar1.jsp"/>
</c:if>
	       			   
<c:if test="${sessionScope.experience!=null}">
<c:redirect url="/experience/navbar.jsp"/>
</c:if>	
</body>
</html>