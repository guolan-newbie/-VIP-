<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">		
$(function(){	
	var id=$("#id").val();
	var optional_flag=false;
	$.ajaxSetup({async:false});	
	$.post("${pageContext.request.contextPath}/course/getCourseById.action",{id:id},function(data){
		$("[name='title']").val(data.title);
		if(data.optional_flag==true){
			$("input[name='optional_flag']:eq(0)").attr("checked",'checked'); 
			optional_flag=true;
		}
	});
	$("[name='title']").focus();
	var flag=false;
	var msg="";
	
	//判断章节名
	$("[name='title']").blur(function(){
		var title=$.trim($("[name='title']").val());
		if(title==""){
			$("#msg").html("章节名称不能为空!");
			return false;
		}
		$("#msg").html("");
		msg="";
		flag=true;
	});

	//设置选修课标志
	$("input:radio[name='optional_flag']").click(function(){
		if($('input:radio[name="optional_flag"]:eq(0)').is(":checked")==true){
			optional_flag=true;
		}else{
			optional_flag=false;
		}
	})
	
	$("#modify").click(function(){	
		if(flag==false){			
			$("#msg").html(msg);
			return false;
		}
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/modifyChapter.action",{id:id,title:$("[name='title']").val(),optional_flag:optional_flag},function(data){
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index);	
		})
				
	})
});
</script>
</head>
<body>
<input type="hidden" value="${param.id }" id="id">
<div class="container">
	<div class="well well-sm text-center">章节信息</div>
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="add">
			<table class="table table-hover">		
				<tr>
					<th>章节名称</th>
					<td>
						<input name="title" type="text" style="width: 200px" class="form-control" required /> 
					</td>
				</tr>
				<tr>
					<th>是否选修</th>
					<td>
						<input type="radio" value="true" name="optional_flag">是 
						<input type="radio" value="false" name="optional_flag" style="margin-left: 20px" checked="checked">否
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="msg" style="color: red; font-weight: bold; font-size: 15px; " align="center"></div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="margin-left: 110px">
							<button type="button" class="btn btn-default" id="modify">确定</button>
						</div>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>

</div>
</body>
</html>