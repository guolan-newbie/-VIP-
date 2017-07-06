<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.net.*"%>
<!DOCTYPE HTML>
<html>
<head>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<meta charset="utf-8">
<title>修改工作日志</title>
</head>
<link
	href="${pageContext.request.contextPath}/resources/plugin/jeDate/css/jedate.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" 
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/jeDate/jedate/jquery.jedate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		var index = parent.layer.getFrameIndex(window.name);
		/* 初始化编辑器 */
		var ue = UE.getEditor('editor', {
			enableAutoSave : false,
			UEDITOR_HOME_URL : "${pageContext.request.contextPath}/resources/plugin/ueditor/",
			serverUrl : "${pageContext.request.contextPath}/resources/plugin/ueditor/jsp/controller.jsp"
		});
		
		$("#wdate").jeDate({
			isinitVal : true,
			festival : true,
			ishmsVal : false,
			festival : false,
			isClear :false,
			format : "YYYY-MM-DD",
			zIndex : 3000,
		})
		
		var id_name = getUrlParam("id_name");
		id_name=decodeURI(id_name,"utf8"); 
		var str=id_name.split("!");
		var id=str[0];
		var name=str[1];
		$.post("${pageContext.request.contextPath}/dailylog/getDailyLogById.action",
						{
							id : id
						}, function(data) {
							var dailylog = eval("(" + data + ")");
							var text="<h3>" + dailylog.name + "<small>在</small>" + new Date(dailylog.time).pattern("yyyy年MM月dd日") + "<small>的工作日志，于" + new Date(dailylog.created).pattern("yyyy年MM月dd日") + "创建</small></h3>";
							$("#text").html(text);
							$("#wdate").val(new Date(dailylog.time).pattern("yyyy-MM-dd"));
							ue.ready(function() {
								ue.setContent(dailylog.context);
							});
		});
		
		/* 修改工作日志 */
		$("#modify").click(function() {
			var contents = UE.getEditor('editor').getContent();
			if (contents == "") {
				layer.msg("工作日志内容不能为空", {icon : 0, time : 1000});
				return false;
			}
			$.ajaxSetup({
				async : false
			});
			$.post("${pageContext.request.contextPath}/dailylog/modifyDailyLog.action",
				{id : id,name : name,context : contents,time :new Date($("#wdate").val())},function(data) {
				if (data.status == 100) {
					parent.layer.close(index);
				} else if (data.status == 201){
					layer.msg("<strong style='color:red;'>你不是管理员没有权限添加！</strong>",{icon : 2});
				} else if (data.status == 204){
					layer.msg("<strong style='color:red;'>你的权限不足,不能修改他人的工作日志！</strong>",{icon : 2});
				} else if (data.status == 302){
					layer.msg("<strong style='color:red;'>日期不能大于今天！</strong>",{icon : 2});
				} else if (data.status == 303){
					layer.msg("<strong style='color:red;'>日期和之前工作日志日期重复！</strong>",{icon : 2});
				} else {
					layer.msg("<strong style='color:red;'>发生了错误，请重试！</strong>",{icon : 2});
				}
			});
		});
	});
</script>
<body>
<div class="container">
	<div class="bs-example" data-example-id="large-well">
		<div class="page-header" id="text">
		</div>
		<div style="background-color: #EEEEEE; width: 703px; height: 50px; border-radius: 6px; position: relative;">
		<span style="font-weight:600;font-size:22px; color: #666666; position: relative; left: 0px; top: 7px;">修改工作日志时间:&nbsp;&nbsp;&nbsp;<input class="form-control" id="wdate" type="text" style="height:20px;" readonly></span>
		</div>
		<div>
		<script id="editor" type="text/plain" style="height: 300px;"></script>
		</div>
	</div>
</div>
	<input type="button" style="margin-left: 640px;" class="btn btn-default radius" id="modify" value="保存日志" />
</body>
</html>