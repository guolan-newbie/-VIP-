<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>图片审核-Java互助学习VIP群业务运行系统</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/picture/getFlagByPage.action",{page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
		})
		
	}	
	function drawTable(data){
		var line="";
		line=line + "<thead class='text-c'>"
		line=line + "<tr>";
		line=line + "<th>序号</th>";
		line=line + "<th>用户名</th>";
		line=line + "<th>真实姓名</th>";
		line=line + "<th>审核</th>";	
		line=line + "</tr>";
		line=line + "</thead>"

		for(i=0;i<data.length;i++){
			line=line + "<tbody class='text-c'>"
			line=line + "<tr>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i].user.name+ "</td>";
			line=line + "<td>" + data[i].member.name + "</td>";
			line=line + "<td><a href='${pageContext.request.contextPath}/uploading/allflag.jsp?id=" + data[i].user.id + "' target='_blank'>审核</a></td>";
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
});	

</script>

</head>
<body>
	<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>	
    <h1 style="text-align:center">用户列表</h1>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title">
		 <span style="color:#F5FAFE">1</span> 
	</div>
	<div class="mt-20">
		<table id="users" class="table table-border table-bg table-bordered radius">
 		</table>
 	</div>
	<br/>
	<div class='page-nav' style="padding-right:120px"></div>
</body>
</html>