<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
.main{width:500px;margin-left:25%;}
#info{font-size:16px;color:red;}
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
		layer.msg('修改成功',{
			icon:1,
		})
		return  true;
	});
});	

</script>
</head>
<body>
<div class="main">
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
</div>
</body>
</html>