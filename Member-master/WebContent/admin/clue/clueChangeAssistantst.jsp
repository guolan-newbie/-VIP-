<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>线索用户设置小助手</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		var id = ${param.id};
		/* 页面一加载获取小助手 */
		$.post("${pageContext.request.contextPath}/clue/getAssistants.action", function(data) {
			if (isDataStatus(data)) {
				showData(data.data);
			}
		});
		
		/* 保存小助手 */
		$("#change").click(function() {
			var aid = $("#assistants").val();
			if (aid == 0) {
				$("#infoshow").html("请选择一个小助手");
			}
			$.post("${pageContext.request.contextPath}/clue/setAssistant.action", {"admin.id" : aid, id : id}, function(data) {
				if (isDataStatus(data)) {
					parent.$("#flag").val("1");
					parent.layer.closeAll();
				}
			});
		});
		
		/* 显示小助手 */
		function showData(data) {
			var line = "<option value='0'>请选择小助手</option>";
			for (i = 0; i < data.length; i++) {
				line += "<option value='"+data[i].id+"'>";
				line += data[i].realname;
				line += "</option>";
			}
			$("#assistants").html(line);
		}
	});
</script>
</head>
<body>
	<div class="text-c">
		<h1>小助手设置</h1>
		为【${param.name }】设置小助手..<br>
		<select id="assistants">
			<option value="0">请选择小助手</option>
		</select>
		<input type="button" id="change" value="确认"><br>
		<span id="infoshow"></span>
	</div>
</body>
</html>