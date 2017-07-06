<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/css/layer-login.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/signin.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
</head>
<script type="text/javascript" >
$(function(){
	var contents=$("#contents").val();
	var state=$("#state").val();  
	var id=$("#id").val();  //修改周报时候id有值，编写周报时id=0
   	$("#vip").click(function(){
   			//alert(state)
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/user/layerLogin.action",{"name":$(":text[name='name']").val(),"pwd":$(":password[name='pwd']").val(),content:contents,state:state,id:id},function(data){
				if(data=="1"){
	     				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index);
	     		}
				if(data=="0")
				{
					parent.layer.alert('用户名或密码错误', {
						icon: 0,
					});
				}
   			});
	});
   /*	$("#btn").click(function(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/admin/adminlayerLogin.action",{"name":$(":text[name='name']").val(),"pwd":$(":password[name='pwd']").val()},function(data){
			if(data=="1"){
     				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);
     		}
			if(data=="0")
			{
				parent.layer.alert('用户名或密码错误', {
					icon: 0,
				});
			}
			});
});*/
});
</script>
<body>
<div id="login">
	<form action="" method="post" class="form-signin" role="form">
	    <input  type="hidden" value="${ param.contents }" id="contents"/>
	    <input  type="hidden" value="${ param.state }" id="state"/>
	    <input  type="hidden" value="${ param.id }" id="id"/>
        <div id="att" style="color:red;font-size:18px">亲，登录过后周报就会保存啦！</div>
		<input type="text" name="name" class="form-control" placeholder="用会员编号登录" required autofocus style="margin-top:40px"/>
		<input type="password" name="pwd" class="form-control" placeholder="密码" required />	
	      <div id="bt1" class="bt">
	   		 <button class="btn btn-lg btn-warning btn-block" id="vip">&nbsp;会员登录&nbsp;</button>
	   	  </div>	  	
	</form>
</div>
</body>
</html>