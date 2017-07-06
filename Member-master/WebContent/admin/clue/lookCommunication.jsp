<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>线索用户的沟通信息</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/images/icon/H~ui_ICON_1.0.8/iconfont.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajaxSetup({
			async : false
		});
		var cid = ${param.id};
		
		/* 获取个人信息 */
		$.post("${pageContext.request.contextPath}/clue/getClueById.action", {id : cid}, function(data) {
			if (isDataStatus(data)) {
				data = data.data;
				var content = "";
				content += "<tr class='text-c'><th bgcolor='#F5FAFE'>用户名</th><td>"
					+ data.num
					+ "</td><th bgcolor='#F5FAFE'>qq号码</th><td>"
					+ data.qq
					+ "</td><th bgcolor='#F5FAFE'>真实姓名</th><td>"
					+ isBlank(data.realName)
					+ "</td><th bgcolor='#F5FAFE'>联系电话</th><td>"
					+ isBlank(data.phone) + "</td></tr>";
				content += "<tr class='text-c'><th bgcolor='#F5FAFE'>小助手</th><td>"
					+ data.admin.realname
					+ "</td><th bgcolor='#F5FAFE'>性别</th><td>"
					+ data.sex
					+ "</td><th bgcolor='#F5FAFE'>开始时间</th><td>"
					+ datePattern(data.btime)
					+ "</td><th bgcolor='#F5FAFE'>结束时间</th><td>"
					+ datePattern(data.etime)
					+ "</td></tr>";
				content += "<tr class='text-c'><th bgcolor='#F5FAFE'>学校</th><td>"
					+ isBlank(data.school)
					+ "</td><th bgcolor='#F5FAFE'>毕业时间</th><td>"
					+ datePattern(data.graduateDate)
					+ "</td><th bgcolor='#F5FAFE'>是否毕业</th><td>"
					+ isBlank(!data.type, "未毕业", "已毕业")
					+ "</td><th bgcolor='#F5FAFE'>是否为体验者</th><td>"
					+ ((data.flag == 1) ? "是(" + data.exnum
							+ ")" : "否") + "</td></tr>";
				$("#table").html(content);
			}
		});
		
		/* 获取沟通信息 */
		$.post("${pageContext.request.contextPath}/clue/getCommunication.action", {cid : cid}, function(data) {
			if (isDataStatus(data)) {
				drawTable(data.data);
				delComm();
			}
		});
		
		/* 显示数据 */
		function drawTable(data) {
			if(data.length == 0) {
				$("#comm").html("<h4 class='text-c c-error'>暂无沟通信息</h4>");
				return ;
			}
			var line = "";
			for (i = 0; i < data.length; i++) {
				line += "<li class='item cl'>";
				line += "<i class='avatar size-L radius'>";
				line += "<img src='${pageContext.request.contextPath}/resources/images/user_male.png'>";
				line += "</i>";
				line += "<div class='comment-main'>";
				line += "<header class='comment-header'>";
				line += "<div class='comment-meta'>";
				line += "<h5 class='c-black'>" + data[i].admin.realname
						+ "<small>沟通于</small>" + datePattern(data[i].time);
				line += "<span class='f-r del' lang='"
						+ data[i].id
						+ ","
						+ data[i].admin.id
						+ ","
						+ datePattern(data[i].time)
						+ "'><i class='Hui-iconfont Hui-iconfont-del2'></i></span><h5>";
				line += "</div>";
				line += "</header>";
				line += "<div class='comment-body'>" + data[i].content + "</div>";
				line += "</div>";
				line += "</li>";
			}
			$("#comm").html(line);
		}
		
		function delComm() {
			$(".del").click(function() {
				var str = this.lang.split(",");
				var aid = ${ADMIN.id};
				if(str[1] != aid) {
					layer.msg('你不能删除其他人的沟通信息！', {icon: 0});
					return ;
				}
				var li = $(this).parents("li");
				var string = "你确定删除在<b class='c-warning'>【" + str[2] + "】</b>沟通的信息么？";
				layer.confirm(string, {btn : ['确定','取消']}, function(){
					$.post("${pageContext.request.contextPath}/clue/deleteClueCommunication.action", {
						id : str[0]
					}, function(data) {
						if (isDataStatus(data)) {
							parent.$("#flag").val(parseInt(parent.$("#flag").val()) + 1);
							li.remove();
							layer.closeAll();
						}
					});
				});
			});
		}
	});
</script>
</head>
<body>
	<div class="container">
		<h4 class="text-c"><b>与【${param.name }】的沟通信息</b></h4>
		<table class="table table-border table-bg table-bordered radius" id="table">
			<tr class='text-c'>
				<th bgcolor='#F5FAFE'>用户名</th>
				<td>XS0241</td>
				<th bgcolor='#F5FAFE'>qq号码</th>
				<td>1234567891</td>
				<th bgcolor='#F5FAFE'>真实姓名</th>
				<td>李四</td>
				<th bgcolor='#F5FAFE'>联系电话</th>
				<td>1234567890</td>
			</tr>
			<tr class='text-c'>
				<td>小助手</td>
				<td>休息休息</td>
				<td>性别</td>
				<td>难</td>
				<td>开始时间</td>
				<td>2017-01-01</td>
				<td>结束时间</td>
				<td>2017-01-01</td>
			</tr>
			<tr class='text-c'>
				<td>学校</td>
				<td>清华大学</td>
				<td>毕业时间</td>
				<td>2017-01-01</td>
				<td>是否毕业</td>
				<td>未毕业</td>
				<td>是否是体验者</td>
				<td>休息休息</td>
			</tr>
		</table>
		<ul class="commentList" id="comm"></ul>
	</div>
</body>
</html>