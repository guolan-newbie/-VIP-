<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>密码管理-Java互助学习VIP群业务运行系统</title>
		
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
  
 <style type="text/css">
</style>   
    
    
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/user/getUserByPage.action",{type:4,page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
			mycellclick();
		})
		
	}	
	function drawTable(data){
		var line="";
		line=line + "<thead class='text-c'>"
		line=line + "<tr>";
		line=line + "<th>序号</th>";
		line=line + "<th>会员编号</th>";
		line=line + "<th>真实姓名</th>";
		line=line + "<th>重设密码</th>";
		line=line + "</tr>";
		line=line + "</thead>"
		
		for(i=0;i<data.length;i++){
			line=line + "<tbody class='text-c'>"
			line=line + "<tr>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].name + "</td>";
			line=line + "<td>" + data[i].member.name + "</td>";
			line=line + "<td class='mycell' lang='" + data[i].id + "'></td>";	
			line=line + "</tr>";
			line=line + "</tbody>"

		}
		$("#users").html(line);
	}	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	function mycellclick(){
		$(".mycell").dblclick(function(data){
			var authority;
			$.post("${pageContext.request.contextPath}/admin/checkAdminAuthorith.action",function(data){
				if(data == 1)
				{
					authority=data;
				}
			});	
			if(authority==1)
			{
				var newpwd;
				$.post("${pageContext.request.contextPath}/user/getPwd.action",{id:this.lang},function(data){
					newpwd=data;
				});
				$(this).text(newpwd);
			}
			else
			{
				alert("您不具备该权限，请联系管理员!");
			}

		});
	}	
});	
</script>

</head>
<body>
	<h1 style="text-align:center">密码初始化</h1>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title"> 
		<span style="color:#F5FAFE">1</span> 
	</div>
	<div class="mt-20">
		<table id="users" class="table table-border table-bg table-bordered radius">
 		</table>
 	</div>
 	<br>
	<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>