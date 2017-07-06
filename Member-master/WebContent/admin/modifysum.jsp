<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript">
$(function(){
	$("#previous").click(function(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/modifyTitle.action",{title:$("[name='title']").val(),"weekType":"pre"},function(data){
			$("[name='title']").val(data);
		});
	});
	$("#next").click(function(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/modifyTitle.action",{title:$("[name='title']").val(),"weekType":"next"},function(data){
			$("[name='title']").val(data);
		});
	});
   	$("#btn").click(function(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/summary/update1Summary.action",{"title":$("[name='title']").val(),"id":$(":hidden[name='id']").val()},function(data){
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);	
			});
		});
});
</script>
</head>
<body>
<form action="" method="post">
<input type="hidden" name="id" value="${param.id }">
<table align="center" class="table table-border table-bg table-bordered radius">
<tr><th colspan="3">周报标题</th></tr>
<tr> <td><input type="button" value="向前一周" id="previous"></td> 
<td><input type="text"  name="title" value="${param.title }"></td>
 <td><input type="button" value="向后一周" id="next"></td></tr>
<tr> <td align="center" colspan="3"><input type="submit" value="保存" id="btn"></td>
</table>
</form>
</body>
</html>