<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>会员沟通信息-Java互助学习VIP群业务运行系统</title>
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
								lookCommunicationclick();
								addCommunicationclick();
							})

		}
		function drawTable(data) {
			var line = "";
			for (i = 0; i < data.length; i++) {
				line += "<tr class='rows'>";
				line += "<td>" + (i + 1) + "</td>";
				line += "<td>" + data[i].name + "</td>";
				line += "<td>" + data[i].member.name + "</td>";
				line += "<td class='memo' id='memo" + (i + 1) + "'>";
				line += "<a herf='#' title='添加' style='text-decoration:none' class='addCommunication' lang='" + data[i].member.id + "," + data[i].member.name +"'>添加"
						+ "</a>&nbsp;|&nbsp;";
				line += "<a herf='#' title='查看' style='text-decoration:none' class='lookCommunication' lang='" + data[i].member.id + "," + data[i].member.name +"'>查看"
						+ "</a>";
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
		//查看沟通信息点击事件
		function lookCommunicationclick() {
			$(".lookCommunication")
					.click(
							function() {
								var data = this.lang.split(",");
								var id = data[0];
								var name = data[1];
								layer
										.open({
											type : 2,
											title : '查看沟通信息',
											area : [ '700px', '550px' ],
											shift : 1,
											shade : 0.5, //开启遮罩关闭
											content : '${pageContext.request.contextPath}/member/lookcommunication.jsp?id='
													+ id + '&name=' + name,
											end : function() {
												getData(page2);
											}
										});
							})
		}
		//添加沟通信息点击事件
		function addCommunicationclick() {
			$(".addCommunication")
					.click(
							function() {
								var data = this.lang.split(",");
								var id = data[0];
								var name = data[1];
								layer
										.open({
											type : 2,
											title : '添加沟通信息',
											area : [ '810px', '550px' ],
											shift : 1,
											shade : 0.5, //开启遮罩关闭
											content : '${pageContext.request.contextPath}/member/addcommunication.jsp?id='
													+ id + '&name=' + name,
											end : function() {
												getData(page2);
											}
										});
							})
		}
	});
</script>

</head>
<body>
	<h1 class="text-c">VIP会员沟通信息</h1>
	<div class="panel panel-secondary">
		<!-- <div class="panel-header"></div> -->
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>序号</th>
						<th>会员编号</th>
						<th>真实姓名</th>
						<th>沟通信息</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>