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
	var flag=false;
	var msg="";
	
	//设置章节
	$.post("${pageContext.request.contextPath}/course/getChapters.action",function(data){
		showdata(data);
	});
	function showdata(data){
		var line="";
		for(i=0;i<data.length;i++){
			if ($("[name='chid']").val() == data[i].id){
				line = line + "<option value="+data[i].id+" selected='selected'>";
			}
			else{
				line = line + "<option value="+data[i].id+">";
			}
			line = line + data[i].title;
			line = line + "</option>";
		}
		$("[name='chid']").append(line);
	}
	//判断课程名
	$("[name='title']").blur(function(){
		var title=$.trim($("[name='title']").val());
		if(title==""){
			$("#msg").html("课程名称不能为空!");
			return false;
		}
		$("#msg").html("");
		msg="";
		flag=true;
	});

	
	$("#add").click(function(){	
		if(flag==false){			
			$("#msg").html(msg);
			return false;
		}
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/add.action",{chid:$("[name='chid']").val(),title:$("[name='title']").val()},function(data){
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index);	
		})
				
	})
});
</script>
</head>
<body>
<div class="container">
	<div class="well well-sm text-center">课程信息</div>
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="add">
			<table class="table table-hover">
				<tr>
					<th>所属章节</th>
					<td>
						<select name="chid" class="form-control" style="width: 200px"></select>
					</td>
				</tr>			
				<tr>
					<th>课程名称</th>
					<td>
						<input name="title" type="text" style="width: 200px" class="form-control" required /> 
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
							<button type="button" class="btn btn-default" id="add">确定</button>
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