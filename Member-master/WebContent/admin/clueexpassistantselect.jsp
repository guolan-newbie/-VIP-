<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style type="text/css">
 .text-c{
 text-align:center
 }
 #infoshow{
 color:red;
 }
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	var id=$("[name='id']").val();
	//alert(mid);
	$.post("${pageContext.request.contextPath}/admin/getAll.action",function(data){
		var line="";
		for(i=0;i<data.length;i++){
			line+="<option value='"+data[i].id+"'>";
			line+=data[i].realname;
			line+="</option>";
		}
		$("#assistants").append(line);		
	})
	$("[type='button']").click(function(){
		var aid=$("#assistants").val();
		//alert(aid);
		if(aid==0){
			$("#infoshow").html("请选择一个小助手");
		}
		$.post("${pageContext.request.contextPath}/clue/setAssistant.action",{aid:aid,id:id},function(){
			layer.msg('设置成功', {
			    icon: 1,
			    time: 1000
			}, function(){
 				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index);
			});
		})
	})
});
</script>
</head>
<body>
<input type="hidden" name="id" value="${param.id }">
<input type="hidden" name="name" value="${param.name }">
<div class="text-c">
<h1>小助手设置</h1>
为【${param.name }】设置小助手..<br>
<select id="assistants">
	<option value="0">请选择小助手</option>
</select>
<input type="button" value="确认"><br>
<span id="infoshow"></span>
</div>
</body>
</html>