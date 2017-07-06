<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>基础设置-Java互助学习VIP群业务运行系统</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/Icon.ico" />
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		//第一次点击进来的默认值
		var page2 = 1;
		getData(page2);
		function getData(page2) {
			$.ajaxSetup({
				async : false
			});
			$
					.post(
							"${pageContext.request.contextPath}/user/getUserByPage.action",
							{
								type : 4,
								page2 : page2
							}, function(data) {
								//alert(data);
								var dataObj = eval("(" + data + ")");
								var navbar = dataObj.returnMap.navbar;
								var list = dataObj.returnMap.list;
								$(".page-nav").html(navbar);
								btnclick();
								drawTable(list);
								clickRows();
								summarytdclick();
								setupclick();
								resetclick();
							})

		}
		function drawTable(data) {
			var line = "";
			for (i = 0; i < data.length; i++) {
				line += "<tr class='rows'>";
				line += "<td>" + (i + 1) + "</td>";
				line += "<td>" + data[i].name + "</td>";
				line += "<td>" + data[i].member.name + "</td>";
				line += "<td class='td-status' lang='"+ data[i].member.id +"'>";
				if (data[i].member.summaryflag == '1') {
					line += "<span class='label label-danger radius'>需要</span>";
				} else {
					line += "<span class='label label-success radius'>不需要</span>";
				}
				line += "</td>";
				if (data[i].admin != null) {
					line += "<td>" + data[i].admin.realname + "</td>";
				} else {
					line += "<td>" + "" + "</td>";
				}
				line += "<td>";
				line += "<a href='javascript:void(0)' lang='"
						+ data[i].member.id + "," + data[i].member.name
						+ "' class='setup' >设置</a>";
				line += "&nbsp;&nbsp;";
				line += "<a href='javascript:void(0)' lang='"
						+ data[i].member.id + "' class='reset' >重置</a>";
				line += "</td>";
				line += "</tr>";
			}
			$("#tbody").html(line);
		}
		//分页按钮点击事件
		function btnclick() {
			$(".nav-btn").click(function() {
				page2 = this.lang;
				getData(page2);
			})
		}
		//周报标记td点击事件
		function summarytdclick() {
			$(".td-status")
					.click(
							function() {
								id = this.lang;
								$
										.post(
												"${pageContext.request.contextPath}/member/toggleSummryflag.action",
												{
													id : id
												}, function() {
													getData(page2);
												})
							})
		}
		//周报标记td点击事件
		function summarytdclick() {
			$(".td-status")
					.click(
							function() {
								id = this.lang;
								var msg = ""
								//alert($(this).children("span").text());
								if ($(this).children("span").text() == "需要") {
									msg = "你确定要设置\"不需要\"提交周报？";
								} else {
									msg = "你确定要设置\"需要\"提交周报？";
								}
								layer
										.confirm(
												msg,
												{
													btn : [ '确定', '取消' ]
												},
												function(index, layero) {
													$
															.post(
																	"${pageContext.request.contextPath}/member/toggleSummryflag.action",
																	{
																		id : id
																	},
																	function() {
																		getData(page2);
																		layer
																				.closeAll();
																	})
												});
							})
		}
		function setupclick() {
			$(".setup")
					.click(
							function() {
								var data = this.lang.split(",");
								var id = data[0];
								var name = data[1];
								//alert(id);
								//alert(name);
								layer
										.open({
											type : 2,
											title : '设置小助手',
											area : [ '600px', '361px' ],
											// closeBtn: 0, //不显示关闭按钮
											shift : 1,
											shade : 0.5, //开启遮罩关闭
											content : '${pageContext.request.contextPath}/admin/assistantselect.jsp?id='
													+ id + '&name=' + name,
											end : function() {
												getData(page2);
											}
										});

							});
		}
		function resetclick() {
			$(".reset")
					.click(
							function() {
								var mid = this.lang;
								$
										.post(
												"${pageContext.request.contextPath}/member/resetAssistant.action",
												{
													id : mid
												}, function() {
													getData(page2);
												});
							})
		}
	});
</script>
</head>
<body>
	<c:if test="${ADMIN==null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<h1 class="text-c">VIP会员基础设置</h1>
	<div class="mt-20">
		<table id="users"
			class="table table-border table-bg table-bordered radius">
		</table>
	</div>
	<div class="panel panel-secondary">
		<!-- <div class="panel-header"></div> -->
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>序号</th>
						<th>会员编号</th>
						<th>会员姓名</th>
						<th>是否需要写周报</th>
						<th>小助手姓名</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>