<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分期信息-Java互助学习VIP群业务运行系统</title>
<style type="text/css">
	#period{width:350px;margin-left:20px;}
	#title,#saveit{margin-left:20px;}
	#info,#saveit{float:left;}
	#main{margin:0 auto;}
</style>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript">
$(function(){
	//获取url中的参数id
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
	var id=$.getUrlParam('id');
	$.post("${pageContext.request.contextPath}/member/getPeriod.action",{id:id},function(data){
		drawTable(data);
	},"json");
	$.post("${pageContext.request.contextPath}/member/getMemberById.action",{id:id},function(member){
		$("#name").html(member.name);
		if(member.student=="true"){
			$("#studentType").html("学生");				
		}else{
			$("#studentType").html("工作");	
		}
		$("#registerTime").html(member.formatTime);
	},"json");
	$("#saveit").click(function(){
		$('#saveit').attr('disabled', true);
		$.post("${pageContext.request.contextPath}/member/savePeriod.action",{id:id},function(data){
			if(data=="OK"){
				$("#info").html("分期信息保存成功!");
			}
			else{
				$("#info").html("你已经保存过了,不需要再次保存!");
			}
		});
	});
	
	function drawTable(data){
		var line="";
		line=line + "<tr>";
		line=line + "<td>序号</td>";
		line=line + "<td>交费日期</td>";
		line=line + "<td>交费金额</td>";	
		line=line + "</tr>";
		for(i=0;i<data.length;i++){
			line=line + "<tr>";			
			line=line + "<td>" + (i+1) + "</td>";
			
			var d=	new Date();
			d.setTime(data[i].duetime);
			var s=d.format('yyyy-MM-dd');
			
			line=line + "<td>" + s + "</td>";
			line=line + "<td>" + data[i].amount + "</td>";
			line=line + "</tr>";		
		}
		$("#period").append(line);
	}
});
</script>
</head>
<body>
<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
</c:if>
<br/>
<div id="main">
<div id="title">
姓名：<span id="name"></span>&nbsp;&nbsp;
类型：<span id="studentType"></span>
<br/>
注册日期:<span id="registerTime"></span>
</div>
<br/>
<table id="period" class="table table-bordered">
</table>
<input type="button" id="saveit" value="通过审核"><div id="info" style="margin-left:20px"></div>
</div>
<br/>
</body>
</html>