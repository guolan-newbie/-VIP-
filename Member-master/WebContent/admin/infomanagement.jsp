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
								/* abnormalclick(); */
								deleteclick();
								modifymemberinfoclick();
								modifyuserinfoclick();
							})

		}
		function drawTable(data) {
			var line = "";
			for (i = 0; i < data.length; i++) {
				var student = "在学"
				if (data[i].member.student == false) {
					student = "在职";
				}
				line += "<tr class='rows'>"
				line += "<td>" + (i + 1) + "</td>";
				line += "<td>" + data[i].name + "</td>";
				line += "<td class='nowrap'>"
						+ data[i].member.name + "</td>";
				line += "<td>" + data[i].member.school + "</td>";
				line += "<td class='nowrap'>"
						+ data[i].member.mobile + "</td>";
				line += "<td>" + data[i].member.company + "</td>";
				line += "<td>"
						+ data[i].member.formatGraduateDate + "</td>";
				line += "<td>" + student + "</td>";
				var mycheck = "";
				if (data[i].member.abnormal == true) {
					mycheck = "checked";
				}
				/* line += "<td><input type='checkbox' name='abnormal' " + mycheck + " lang=" + data[i].id + "></td>"; */
				line += "<td><a href='javascript:void(0)' class='modifymemberinfo' lang="
						+ data[i].member.id
						+ ","
						+ data[i].id
						+ ","
						+ data[i].member.name + ">修改</a></td>";
				line += "<td><a href='javascript:void(0)' class='modifyuserinfo' lang="
						+ data[i].id
						+ ","
						+ data[i].member.name
						+ ">修改</a></td>";
				line += "<td><a href='javascript:void(0)' class='delete' lang="
						+ data[i].id + ">删除</a></td>";

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
		//特殊复选框点击事件
		/* function abnormalclick() {
			$("[name='abnormal']")
					.click(
							function() {
								$
										.post("${pageContext.request.contextPath}/member/setAbnormal.action?id="
												+ this.lang);
							});
		} */
		//删除点击事件
		function deleteclick() {
			$(".delete").click(
					function() {
						var id = this.lang;
						layer.confirm(
								'您确定要删除该用户吗?删除该用户时，同时也会删除该用户的基本信息和信用信息，请谨慎操作！',
								{
									btn : [ '是', '否' ]
								},//按钮一的回调函数
								function() {
									$.post(
											"${pageContext.request.contextPath}/user/deleteById.action?id="
													+ id, function(data) {
												layer.closeAll('dialog');
												getData(page2);
											});
								});
					});
		}
		function modifymemberinfoclick() {
			$(".modifymemberinfo")
					.click(
							function() {
								var data = this.lang.split(",");
								var id = data[0];
								var uid = data[1];
								var name = data[2];
								//alert(id);
								//alert(name);
								layer
										.open({
											type : 2,
											title : '修改会员信息',
											area : [ '300px', '650px' ],
											// closeBtn: 0, //不显示关闭按钮
											shift : 1,
											shade : 0.5, //开启遮罩关闭
											content : '${pageContext.request.contextPath}/admin/modifymemberinfo.jsp?id='
													+ id
													+ '&uid='
													+ uid
													+ '&name=' + name,
											end : function() {
												getData(page2);
											}
										});

							});
		}
		function modifyuserinfoclick() {
			$(".modifyuserinfo")
					.click(
							function() {
								var data = this.lang.split(",");
								var uid = data[0];
								var name = data[1];
								//alert(id);
								//alert(name);
								layer
										.open({
											type : 2,
											title : '修改信用信息',
											area : [ '500px', '650px' ],
											// closeBtn: 0, //不显示关闭按钮
											shift : 1,
											shade : 0.5, //开启遮罩关闭
											content : '${pageContext.request.contextPath}/admin/modifyuserinfo.jsp?uid='
													+ uid + '&name=' + name,
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
	<h1 class="text-c">VIP会员信息管理</h1>
	<div class="panel panel-secondary">
		<!-- <div class="panel-header"></div> -->
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>序号</th>
						<th style='white-space: nowrap'>用户名</th>
						<th>姓名</th>
						<th>学校名称</th>
						<th>联系电话</th>
						<th>公司名称</th>
						<th>毕业时间</th>
						<th>类型</th>
						<!-- <th>特殊</th> -->
						<th>会员信息</th>
						<th>信用信息</th>
						<th>删除</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>