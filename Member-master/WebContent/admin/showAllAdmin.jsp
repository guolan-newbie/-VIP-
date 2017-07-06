<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/looksummary.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<style type="text/css">
	*{
		margin:0;
		padding:0;
	}
	body {
		background-color: #eeeeee;
	}
	.table th, .table td {
 		text-align: center;
	} 

</style>
<script type="text/javascript">
$(function(){
	$.ajaxSetup({
		async:false
	});
	$.post("${pageContext.request.contextPath }/admin/getAllAdmin.action",function(data){
		$("#content").append(data);
	});
	$(".chmod").click(function(){
		var now = this;
		var info = this.lang.split("?"); 
		$.post("${pageContext.request.contextPath }/admin/chmod.action",{
			"id":info[0],
			"authority":info[1]
		},function(data){
			if(data=="2"){
				$(now).attr("class", "chmod label label-danger radius");
				$(now).text("无");	
			} else{
				$(now).attr("class", "chmod label label-success radius");
				$(now).text("有");	
			}
			now.lang = info[0]+"?"+data;
		});
	});
});	
</script>
</head>
<body>
	<c:if test="${sessionScope.admin.authority != 1 }">
		<script type="text/javascript">
			alert("权限不够");
			window.location.href="/Member/index.jsp";
		</script>
	</c:if>
	<div style="padding-left: 30px; margin-top: 50px; margin-bottom: 50px; z-index: 1;">
        <table id="content" class="table table-border table-bg table-bordered radius
">
            <tr>
                <th width="25%">序号</th><th width="25%">用户名</th><th width="25%">真实姓名</th><th>登陆权限</th>
            </tr>
        </table>
    </div>
</body>
</html>