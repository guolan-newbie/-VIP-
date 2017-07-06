<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>修改密码-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />

	
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>

<style type="text/css">
#change{
	margin-left:30px;
}
</style>  
<script type="text/javascript">

//	$("#modify").click(function(){
//			var index=layer.open({
//			    type: 2,
//			    title:'修改',
//			    area: ['740px', '560px'],
//			    shift:5,
//			    maxmin: true,
//			    content: '${pageContext.request.contextPath}/ueditor/modify.jsp'
//			});	
//	});
//	$("#mywrite").click(function(){
//		window.location.href="${pageContext.request.contextPath}/ueditor/showsummaryin.jsp";
//		$.ajaxSetup({ async : false });
//				var index=layer.open({
//			    type: 2,
//			    title:'查看周报',
//			    area: ['740px', '560px'],
//			    shift:5,
//			    maxmin: true,
//			    content: '${pageContext.request.contextPath}/ueditor/showsummaryin.jsp'
//			});
//	});


	
	
//});

$(function(){
	$("[name='f1']").submit(function(){
		var flag=true;
		$.ajaxSetup({
			  async: false
			  });
		$.post("${pageContext.request.contextPath}/user/checkOldPwd.action",{name:$("[name='name']").val(),old:$("[name='old']").val()},function(data){
			if(data=="ERROR"){
			$("#info").html("旧密码输入错误!");
				flag=false;
			}
		});
		var pwd=$("[name='pwd']").val();
		var pwd1=$("[name='pwd1']").val();
		if(pwd==""){
			
			$("#info").html("新密码不能为空!");
			flag=false;
		}
		if(pwd1!=pwd){
			$("#info").html("两次新密码输入不一致!");
			
			flag=false;
		}
		if(!flag){
			
			return flag;
			
			
		}
		return  true;
		alert("修改密码成功")
		
	});
});	

</script>

</head>
<body>
	
<!-- 正文 -->

<%--
  <div id="change">

<br/>
<br/>
<form method="post" name="f1" action="${pageContext.request.contextPath}/user/changePassword.action">
<input type="hidden" name="name" value="${myuser.name}">
<input type="hidden" name="id" value="${myuser.id}">
<table style="padding-left:200px">
<tr><td>用户名 </td><td>${myuser.name}</td></tr>
<tr><td>输入旧密码 </td><td><input type="password" name="old"></td></tr>
<tr><td>输入新密码 </td><td><input type="password" name="pwd"></td></tr>
<tr><td>重复密码 </td><td><input type="password" name="pwd1"></td></tr>
<tr><td colspan="2"><input type="submit" value="修改密码"></td></tr>
</table>
</form>
<br/>
<div id="info"></div>
</div>  
--%>

    	
       <form method="post" name="f1" action="${pageContext.request.contextPath}/user/changePassword.action">
       	<input type="hidden" name="name" value="${myuser.name}">
	<input type="hidden" name="id" value="${myuser.id}">
		
       	<legend class="controls">修改密码</legend>
      
       
          <div class="control-group">
            <label class="control-label">输入旧密码</label>
            <div class="controls">
                <input  type="password"  class="input-xlarge" name="old" >
            </div>
        </div>
          <div class="control-group">
            <label class="control-label">输入新密码</label>
            <div class="controls">
                <input  type="password" class="input-xlarge" name="pwd">
            </div>
        </div>
          <div class="control-group">
            <label class="control-label">重复新密码</label>
            <div class="controls">
                <input  type="password"   class="input-xlarge" name="pwd1">
            </div>
        </div>
       
        <div class="control-group">  
            <label class="control-label">  
            </label>  
            <div class="controls">  
                <button class="btn" type="submit" >确定</button>  
            </div>  
        </div>   
    </form>
    <div id="info"></div>
</body>
</html>