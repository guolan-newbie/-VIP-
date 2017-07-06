<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>VIP会员应缴费用-Java互助学习VIP群业务运行系统</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
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
		/* 页面一加载获取数据  */
		getData(0, 1);

		/* 点击按钮获取对应数据  */
		$(".choices").click(function() {
			var type = this.lang;
			$(".choices").removeClass("active");
			$(this).addClass("active");
			getData(type, 1);
		});

		/* 分页查询  */
		function btnpage() {
			alert("==============")
			$(".nav-btn").click(function() {
				var page = this.lang;
				getData($(".active").attr("lang"), page);
			});
		}

		/* 统一的查询方法  */
		function getData(type, page) {
			$.post("${pageContext.request.contextPath}/member/getMemberCost.action", {
				type : type,
				page : page,
			}, function(data) {
				if(isDataStatus(data)) {
					showData(data.data);
					clickRows();
					$("#paging").html(showpage(data.page, data.count));
					btnpage();
					apishow();
				}
			});
		}

		/* 显示数据 */
		function showData(data) {
			var line = "";
			for (i = 0; i < data.length; i++) {
				if (data[i].alog > 0) {
					line += "<tr class='rows success'>"; //有未审核的费用
				} else {
					line += "<tr class='rows'>";
				}

				line += "<td>" + data[i].no + "</td>";
				line += "<td class='nowrap'>" + data[i].name
						+ "</td>";
				line += "<td>" + data[i].school + "</td>";
				line += "<td class='nowrap'>" + data[i].mobile + "</td>";
				line += "<td><a target='_blank' href='http://wpa.qq.com/msgrd?v=1&uin="
						+ data[i].qq + "&site=qq&menu=yes'>" + data[i].qq
						+ "</a></td>";
				line += "<td>" + data[i].unpaidAmount + "</td>";
				line += "<td>"
						+ datePattern(data[i].finalPaymentDate, "yyyy-MM-dd")
						+ "</td>";
				line += "<td>"
						+ datePattern(data[i].agreementPaymentDate, "dd")
						+ "号</td>";
				line += "<td><a class='show' lang=" + data[i].uid + ">API</a></td>"
				line += "</tr>";
			}
			$("#tbody").html(line);
		}

		/* 显示API信息 */
		function apishow() {
			$(".show").click(function() {
				layer.open({
					type : 2,
					title : '详细费用信息',
					area : [ '800px', '500px' ],
					skin : 'layui-layer-rim',
					shift : 5,
					maxmin : true,
					content : '${pageContext.request.contextPath}/member/show.action?id='
							+ this.lang
				});
			});
		}

		/* 生成表格 */
		$("#download").click(function() {
			$.post("${pageContext.request.contextPath}/member/getMemberCosts.action", function(data) {
				if(isDataStatus(data)) {
					$("#dl").attr("href", "${pageContext.request.contextPath}/" + data.data);
					layer.tips('下载表格已准备好!', $("#download"), {
						tips : [ 1, '#3595CC' ],
						time : 4000
					});
				}
			});
		});

		/* 下载表格 */
		$("#dl").click(function(){
			if ($("#dl").attr('href') == "#") {
				layer.tips('请先生成下载表格!', $("#dl"), {
					tips : [ 1, '#3595CC' ],
					time : 4000
				});
			}
		});
	});
</script>
</head>
<body>
	<c:if test="${ADMIN == null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<h1 class="text-c">VIP会员应缴费用</h1>
	<div class="panel panel-secondary">
		<div class="panel-header cl">
			<div class="btn-group f-l">
				<span class="btn btn-primary radius active choices" lang="0">全部信息</span>
				<span class="btn btn-primary radius choices" lang="1">延期信息</span>
				<span class="btn btn-primary radius choices" lang="2">异常信息</span>
			</div>
			<div class="btn-group f-r">
				<a id="download" class="btn btn-success radius">生成表格</a>
				<a id="dl" class="btn btn-success radius">点击下载</a>
			</div>
		</div>
		<div class="panel-primary">
			<table id="table" class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>编号</th>
						<th>姓名</th>
						<th>校名</th>
						<th>手机</th>
						<th>QQ</th>
						<th>欠缴金额</th>
						<th>最后缴费日期</th>
						<th>协议缴费日期</th>
						<th>信息</th>
					</tr>
				</thead>
				<tbody class='text-c' id="tbody"></tbody>
			</table>
		</div>
	</div>
	<div class="page-nav" style="float: right; margin-top: 10px;" id="paging"></div>
</body>
</html>