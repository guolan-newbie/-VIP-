<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>体验者个人信息</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/H-ui_v3.0/js/H-ui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
$(function() {
	var eid = ${param.eid};
	$.post("${pageContext.request.contextPath}/experience/getExperienceInfoById.action", {eid: eid}, function(data) {
		drawTable(data.data);
	});
	
	function drawTable(data) {
		var content = "";
		content += "<tr><td>用户名：</td><td>" + data.num + "</td></tr>";
		content += "<tr><td>真实姓名：</td><td>" + data.name + "</td></tr>";
		content += "<tr><td>性别：</td><td>" + data.sex + "</td></tr>";
		content += "<tr><td>学校：</td><td>" + data.school + "</td></tr>";
		content += "<tr><td>工作单位：</td><td>" + ((!data.company) ? "" : data.company) + "</td></tr>";
		content += "<tr><td>联系电话：</td><td>" + data.phone + "</td></tr>";
		content += "<tr><td>QQ号码</td><td>" + ((!data.qq) ? "无" : data.qq) + "</td></tr>";
		content += "<tr><td>是否毕业</td><td>" + (data.student ? "未毕业":"已毕业") + "</td></tr>";
		content += "<tr><td>毕业时间</td><td>" + new Date(data.graduateDate).pattern("yyyy-MM-dd") + "</td></tr>";
		content += "<tr><td>体验开始时间</td><td>" + new Date(data.begintime).pattern("yyyy-MM-dd") + "</td></tr>";
		content += "<tr><td>体验结束时间</td><td>" + ((!data.endtime) ? "" : new Date(data.endtime).pattern("yyyy-MM-dd")) + "</td></tr>";
		content += "<tr><td>小助手</td><td>" + data.admin.realname + "</td></tr>";
		content += "<tr><td>是否写周报</td><td>" + (data.summaryflag ? "是" : "否") + "</td></tr>";
		content += "<tr><td>是否会员</td><td>" + (data.flag ? "是" : "否") + "</td></tr>";
		$("#table").html(content);
	}
});
</script>
</head>
<body>
<table id="table" class="table table-border table-bg table-bordered radius" style="width: 500px"></table>
</body>
</html>