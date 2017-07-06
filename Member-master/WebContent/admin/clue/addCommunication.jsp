<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>添加沟通信息</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajaxSetup({
			async : false
		});
		
		/* 初始化编辑器 */
		var ue = UE.getEditor('editor', {
			enableAutoSave : false,
			UEDITOR_HOME_URL : "${pageContext.request.contextPath}/resources/plugin/ueditor/",
			serverUrl : "${pageContext.request.contextPath}/resources/plugin/ueditor/jsp/controller.jsp"
		});
		
		/* 设置默认时间 */
		$("#time").val(datePattern(new Date()));
		
		/* 提交沟通信息 */
		$("#add").click(function() {
			//获取体验者id
			var cid = ${param.id};
			
			//获取内容
			if(!UE.getEditor('editor').hasContents()) {
				layer.msg("沟通内容不能为空!", {icon : 0, time : 1000});
				return ;
			}
			
			$.post("${pageContext.request.contextPath}/clue/addCommunication.action", {
				cid : cid,
				time : new Date($("#time").val()),
				content : UE.getEditor('editor').getContent()
			},function(data) {
				if (isDataStatus(data)) {
					parent.$("#flag").val("1");
					parent.layer.closeAll();
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="text-c">
		<h3>添加与【${param.name}】的沟通信息</h3>
	</div>
	<br>
	<div style="margin-left: 5%">
		沟通时间：
		<input type="text" id="time" 
			onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,readOnly:true,maxDate:new Date()})"
			class="input-text Wdate" style="width: 120px;">
		<br>
		<br>
		<script id="editor" type="text/plain" style="width: 200px; height: 200px;"></script>
		<br>
		<input type="button" id="add" value="提交" class="btn btn-primary radius" style="margin-left: 80%">
	</div>
</body>
</html>