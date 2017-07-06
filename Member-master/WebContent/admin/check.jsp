<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>用户审核-Java互助学习VIP群业务运行系统</title>
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
			$.post("${pageContext.request.contextPath}/user/getUserByPage.action", {
				type : 2,
				page2 : page2
			}, function(data) {
				//alert(data);
				var dataObj = eval("(" + data + ")");
				var navbar = dataObj.returnMap.navbar;
				var list = dataObj.returnMap.list;
				createdl();
				dlclick();
				$(".page-nav").html(navbar);
				btnclick();
				drawTable(list);
				clickRows();
				abnormalclick();
				deleteclick();
				msgclick();
				verifyclick();
			});
		}
		function drawTable(data) {
			var line = "";
			for (i = 0; i < data.length; i++) {
				var student = "在学"
				if (data[i].member.student == false) {
					student = "在职";
				}
				line = line + "<tr class='rows'>"
				line = line + "<td>" + (i + 1) + "</td>";
				line = line + "<td>" + data[i].name + "</td>";
				line = line + "<td>" + data[i].member.name + "</td>";
				line = line + "<td>" + data[i].member.school + "</td>";
				line = line + "<td>" + data[i].member.mobile + "</td>";
				line = line + "<td>" + data[i].member.company + "</td>";
				line = line + "<td>" + data[i].member.formatGraduateDate + "</td>";
				line = line + "<td>" + student + "</td>";
				var mycheck = "";
				if (data[i].member.abnormal == true) {
					mycheck = "checked";
				}

				//line += "<td><input type='checkbox' name='abnormal' " + mycheck + " lang=" + data[i].id + "></td>"
				line += "<td><a href='javascript:void(0)' class='delete' lang="
						+ data[i].id + ">删除</a></td>";
				line += "<td><a href='javascript:void(0)' class='verify' lang="
						+ data[i].member.id + ">审核</a></td>";
				<!--王冰冰将点击单行显示详细改为点击显示按钮显示-->
				line += "<td><input type='button' class='msg' value='显示'" + "lang=" + data[i].id + "></td>";
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
		//生成表格点击事件
		function createdl() {
			$("#download").click(function() {
				$.post("${pageContext.request.contextPath}/user/download.action?type=2", function(data) {
					$("#dl").attr("href", data);
					layer.tips('主人,下载表格我已经为您准备好!', $("#download"), {
						tips : [ 1, '#3595CC' ],
						time : 4000
					});
				});
			});
		}
		//表格下载点击事件
		function dlclick() {
			$("#dl").click(function() {
				if ($("#dl").attr('href') == "#") {
					layer.tips('主人,请先生成下载表格!', $("#dl"), {
						tips : [ 1, '#3595CC' ],
						time : 4000
					});
				}
			});
		}
		//特殊复选框点击事件
		function abnormalclick() {
			$("[name='abnormal']").click(
				function() {
					$.post("${pageContext.request.contextPath}/member/setAbnormal.action?id=" + this.lang);
				});
		}
		//删除点击事件
		function deleteclick() {
			$(".delete").click(
				function() {
					var id = this.lang;
					layer.confirm('您确定要删除该用户吗?删除该用户时，同时也会删除该用户的基本信息和信用信息，请谨慎操作！', {
						btn : [ '是', '否' ]
					}, function() {
						$.post("${pageContext.request.contextPath}/user/deleteById.action?id=" + id, function(data) {
							layer.closeAll('dialog');
							getData(page2);
						});
					});
				});
		}
		//详细信息点击事件
		function msgclick() {
			$(".msg").click(function() {
				var x = $(this);
				$.post("${pageContext.request.contextPath}/user/getinfo.action?id=" + this.lang, function(data) {
					var info = "";
					if (data == "") {
						info = "没有信息，该会员还没有填写";
					} else {
						info = "<table class='table table-border table-bg table-bordered radius'>";
						info += "<tr>";
						info += "<td>身份证号码</td><td>"
								+ data.idNo
								+ "</td>";
						info += "</tr><tr>";
						info += "<td>QQ号码</td><td>"
								+ data.qqNo
								+ "</td>";
						info += "</tr><tr>";
						info += "<td>支付宝</td><td>"
								+ data.payAccount
								+ "</td>";
						info += "</tr><tr>";
						info += "<td>家庭联系人</td><td>"
								+ data.contactName
								+ "</td>";
						info += "</tr><tr>";
						info += "<td>家庭联系人手机</td><td>"
								+ data.contactMobile
								+ "</td>";
						info += "</tr><tr>";
						info += "<td>与家庭联系人关系</td><td>"
								+ data.relation
								+ "</td>";
						info += "</tr><tr>";
						info += "<td>收件地址</td><td>"
								+ data.address
								+ "</td>";
						info += "</tr><tr>";
						info += "</table>";
					}
					layer.alert(info);
				});
			});
		}
		//袁超  将审核分为全费、旧分期、新分期 
		//审核点击事件
		function verifyclick() {
			$(".verify").click(function() {
				layer.open({
					type : 2,
					title : '付费方式',
					area : [ '700px', '500px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/admin/periodchoice.jsp?id='
							+ this.lang,
					end : function() {
						getData(page2);
					}
				});
			});
		}
	});
</script>
</head>
<body>
	<c:if test="${ADMIN==null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<h1 class="text-c">VIP会员基本信息审核</h1>
	<div class="panel panel-secondary">
		<div class="panel-header">
			<div class="btn-group">
				<button type="button" class="btn btn-primary radius" id="download">生成表格</button>
				<a class="btn btn-primary radius" target="_blank" id="dl">点击下载</a>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>序号</th>
						<th>用户名</th>
						<th>真实姓名</th>
						<th>学校名称</th>
						<th>联系电话</th>
						<th>公司名称</th>
						<th>毕业时间</th>
						<th>类型</th>
						<!-- <th>特殊</th> -->
						<th>删除</th>
						<th>审核</th>
						<th>显示详细</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>