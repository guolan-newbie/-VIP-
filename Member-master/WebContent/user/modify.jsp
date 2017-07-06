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
<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
#change{
	margin-left:30px;
}
.navHeader{
        margin-top: 20px;
        height:50px;
        background-color: black;
        margin-bottom: 100px;
    }
    .container{
        width: 500px;
        height: auto;
        border: solid rosybrown 1px;
    }
    .containerTitle{
        float: left;
    }
    .containerTitle h3{
        font-weight:bolder;
    }
    .containerLine{
        margin-top: 80px;
        clear: both;
        height: 1px;
        background-color: darkgrey;
    }
    .containerInput{
        clear: both;
        margin-top: 40px;
    }
    .everyInput{
        margin-top: 30px;
        margin-bottom: 20px;
    }
</style>  
<script type="text/javascript">
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
       	<div class="navHeader">

</div>

<div align="center" class="container">
    <div class="containerTitle">
        <h3>修改密码</h3>
    </div>
  
    <div class="containerLine">
    	  <span>您必须修改初始密码才能进入会员系统</span>
    </div>
    <div class="containerInput">
    	
       <form method="post" name="f1" action="${pageContext.request.contextPath}/user/changeInitPassword.action">
       		  	<input type="hidden" name="name" value="${myuser.name}">
				<input type="hidden" name="id" value="${myuser.id}">
	        <div class="everyInput">
	            <span>输入旧密码:</span> <input  type="password"  class="input-xlarge" name="old" >
	        </div>
	        <div class="everyInput">
	           <span>输入新密码:</span>  <input  type="password" class="input-xlarge" name="pwd">
	        </div>
	        <div class="everyInput">
	              <span>重复新密码:</span>  <input  type="password"   class="input-xlarge" name="pwd1">
	        </div>
	        <div class="everyInput">
	            <button class="btn btn-block btn-info" type="submit">确定</button>
	        </div>
        </form>
    </div>
   <div id="info"></div> 
</div>
</body>
</html>