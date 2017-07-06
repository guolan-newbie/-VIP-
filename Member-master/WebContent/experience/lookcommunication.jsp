<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/commensum.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/H-ui_v3.0/js/H-ui.min.js"></script>
<style type="text/css">
.contentdiv {
	padding-left: 35px;
	padding-top: 15px;
	padding-bottom: 15px;
}

.aa {
	padding-top: 25px;
}
</style>
<script type="text/javascript">
	$(function() {
		var eid = $("[name='id']").val();
		getComs(eid);
		//获取沟通信息
		function getComs(eid) {
			$.ajaxSetup({
				async : false
			});
			$
					.post(
							"${pageContext.request.contextPath}/experience/getCommunicationByEid.action",
							{
								eid : eid
							},
							function(data) {
								if (data.length > 0) {
									var commentsString = "";
									$
											.each(
													data,
													function(i) {
														var contentname = data[i].admin.realname;
														//var contentname=data[i].aid;
														var contenttime = data[i].formatTime;
														var content = data[i].content;
														var commentString = "<div class='commcontendivcod'>";
														commentString += "<span class='commcontendivcods'>"
																+ contentname
																+ "&nbsp;&nbsp;"
																+ "</span>";
														commentString += "<span class='commcontendivcodsins'>"
																+ contenttime
																+ "</span>";
														commentString += "<a class='icon-delete-small' href='javascript:;' lang="+data[i].id+"><i class='Hui-iconfont'>&#xe6e2;</i></a>";
														commentString += "<div class='commcontendivcodd'>";
														commentString += "<div class='contentdiv'>"
																+ content
																+ "</div>";
														commentString += "</div>";
														commentString += "</div>";
														commentsString += commentString;
													});
									$("#comments").html(commentsString);
								} else {
									var commentString = "<div class='commcontendivcod'>";
									commentString += "<div class='commcontendivcodd2'>";
									commentString += "<div class='nocondiv'>";
									commentString += "<span class='nocontent'>"
											+ "暂无沟通信息......" + "</span>";
									commentString += "</div>";
									commentString += "</div>";
									commentString += "</div>";
									$("#comments").html(commentString);
								}
								delComment();
							});
		}
		//删除沟通信息
		function delComment() {
			$(".icon-delete-small")
					.click(
							function() {
								alert("功能暂时未完成");
								return false;

								var id = this.lang;
								if (!confirm('您真的要删除此沟通信息吗？')) {
									return;
								} else {
									$
											.post(
													"${pageContext.request.contextPath}/summary/delComment.action",
													{
														id : id
													}, function() {
														getComs(sumId);
													});
								}
							});
		}

	});
</script>
</head>
<input type="hidden" name="id" value="${param.id }">
<input type="hidden" name="name" value="${param.name }">
<body style="background-color: #EEEEEE;" class="aa">
	<div class="commcontendiv" id="commcontendiv">
		<div class="commcontendivtd">
			<span class="commcontendivtdspan" style="padding-left: 130px;">与【${param.name }】体验者的沟通信息..</span>
		</div>
		<div id="comments"></div>

	</div>
</body>
</html>