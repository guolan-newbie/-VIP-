<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<head>
<style type="text/css">
table {
	width: 600px;
}

table, td, th {
	border: 1px solid green;
}

th {
	background-color: green;
	color: white;
}

#btn1 {
	width: 140px;
	line-height: 28px;
	text-align: center;
	font-weight: bold;
	color: #000;
	border-radius: 5px;
	margin: 0 0 0 0;
	overflow: hidden;
}
</style>

<title>计算器</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
</head>
<body>
	<form>
		<table>
			<tr>
				<td>本金合计：</td>
				<td><input type="text" id="feiyong" value="8000" /></td>
			</tr>
			<tr>
				<td>月利率：</td>
				<td><input type="text" id="lilv" value="0.02" /></td>
			</tr>
			<tr>
				<td>首付：</td>
				<td><input type="text" id="shoufu" value="0" /></td>
			</tr>
			<tr>
				<td>月供:</td>
				<td><input type="text" id="money" value="500" /></td>
			</tr>
			<tr>
				<td>延迟缴费时间(月):</td>
				<td><input type="text" id="delayMonth" value="0" /></td>
			</tr>
			<tr>
				<td>实交合计：</td>
				<td><input type="text" id="total" readonly /></td>
			</tr>
			<tr>
				<td>利息合计：</td>
				<td><input type="text" id="lixi" readonly /></td>
			</tr>
			<tr>
				<td colspan="2" align="center" valign="middle"><input
					type="button" id="btn1" value="显示还款详单" /></td>
			</tr>
			<tr>
				<td>备注：</td>
				<td><div id="msg"></div></td>
			</tr>
		</table>
	</form>
	<div id="info"></div>
	<div>
		<table id="infotb">
		</table>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#btn1")
					.click(
							function() {
								$("#info").html("");
								$("#infotb").html("");

								//首付
								if ($("#shoufu").val() == "") {
									var sf = 0;
								} else {
									var sf = Number($("#shoufu").val());
								}
								var month = 1;
								//利率
								var lilv = Number($("#lilv").val());
								var y = lilv + 1;
								//费用
								var feiyong = Number($("#feiyong").val());
								//首付后剩余金额
								var x = feiyong - sf;
								//每月支付金额
								var monthPay = Number($("#money").val());
								//延迟还款时间
								var delayMonth = Number($("#delayMonth").val());

								var total = sf;
								var lixi = 0;
								var benjin = 0;
								$("#info").append("首付款：" + sf + "元");
								$("#infotb")
										.append(
												"<tr><td>月份</td><td>本月还款金额</td><td>还款金额中的利息</td><td>还款金额中的本金</td><td>剩余本息合计</td><td>提前还款</td></tr>");
								for (month; month < 1000; month++) {
									if (month > 888) {
										$("#infotb").empty();
										alert("还款计划不合理！");
										break;
									}
									//延迟delayMonth个月后缴费
									if (month <= delayMonth) {
										money = 0;
									} else {
										money = monthPay;
									}

									if (x * y > money) {
										total = total + money;
										lixi = x * lilv;
										benjin = money - lixi;
										x = (x * y - money);

										if (month <= delayMonth) {
											$("#infotb")
													.append(
															"<tr><td>"
																	+ month
																	+ "</td><td>"
																	+ changeTwoDecimal_f(0)
																	+ "</td><td>"
																	+ changeTwoDecimal_f(0)
																	+ "</td><td>"
																	+ changeTwoDecimal_f(0)
																	+ "</td><td>"
																	+ changeTwoDecimal_f(x)
																	+ "</td><td><a onclick='getList("
																	+ month
																	+ ")' href='javascript:void(0)'>提前还款</a></td></tr>");
										} else {
											$("#infotb")
													.append(
															"<tr><td>"
																	+ month
																	+ "</td><td>"
																	+ changeTwoDecimal_f(money)
																	+ "</td><td>"
																	+ changeTwoDecimal_f(lixi)
																	+ "</td><td>"
																	+ changeTwoDecimal_f(benjin)
																	+ "</td><td>"
																	+ changeTwoDecimal_f(x)
																	+ "</td><td><a onclick='getList("
																	+ month
																	+ ")' href='javascript:void(0)'>提前还款</a></td></tr>");
										}
									} else {
										lixi = x * lilv;
										total = total + x + lixi;
										total = total + "";
										benjin = x * y - lixi;
										$("#infotb")
												.append(
														"<tr><td>"
																+ month
																+ "</td><td>"
																+ changeTwoDecimal_f(x
																		+ lixi)
																+ "</td><td>"
																+ changeTwoDecimal_f(lixi)
																+ "</td><td>"
																+ changeTwoDecimal_f(benjin)
																+ "</td><td>0</td><td></td></tr>");
										$("#msg")
												.html(
														"总共需要还："
																+ month
																+ "月！"
																+ "<br />"
																+ "总共需要还："
																+ changeTwoDecimal_f(total)
																+ "元钱！");
										break;
									}
								}
								;
								$("#total").val(changeTwoDecimal_f(total));
								$("#lixi").val(
										changeTwoDecimal_f(total - feiyong));
							});
		});

		function getList(month) {
			$("#info").html("");
			$("#infotb").html("");

			var month = Number(month);
			//首付
			var sf = $("#shoufu").val();

			//每月还款金额
			var money = Number($("#money").val());
			//费用
			var feiyong = Number($("#feiyong").val());
			//利率
			var lilv = Number($("#lilv").val());
			var y = lilv + 1;
			var x = feiyong - sf;
			//提前还款利息总数
			var tlixi = 0;
			//利息总数
			var alllixi = $("#lixi").val();
			$("#infotb")
					.append(
							"<tr><td>月份</td><td>还款金额</td><td>还款金额中的利息</td><td>还款金额中的本金</td></td><td>剩余本息合计</td></tr>");
			for (var i = 1; i <= month; i++) {
				//还款金额中的利息
				lixi = x * lilv;

				tlixi = tlixi + lixi;
				//本息合计
				x = x * y;
				//还款金额中的本金
				benjin = x - lixi;
				//还款

				if (month != i) {
					$("#infotb").append(
							"<tr><td>" + i + "</td><td>"
									+ changeTwoDecimal_f(money) + "</td><td>"
									+ changeTwoDecimal_f(lixi) + "</td><td>"
									+ changeTwoDecimal_f(money - lixi)
									+ "</td><td>"
									+ changeTwoDecimal_f(x - money)
									+ "</td></tr>");
					x = x - money;
					continue;

				}
				if (month == i) {
					$("#infotb").append(
							"<tr><td>" + i + "</td><td>"
									+ changeTwoDecimal_f(x) + "</td><td>"
									+ changeTwoDecimal_f(lixi) + "</td><td>"
									+ changeTwoDecimal_f(benjin) + "</td><td>"
									+ 0 + "</td></tr>");
				}
			}
			;
			$("#msg").html(
					"提前还款节省利息：" + changeTwoDecimal_f(alllixi - tlixi) + "元！");
		};

		function changeTwoDecimal_f(x) {
			var f_x = parseFloat(x);
			if (isNaN(f_x)) {
				alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x * 100) / 100;
			var s_x = f_x.toString();
			var pos_decimal = s_x.indexOf('.');
			if (pos_decimal < 0) {
				pos_decimal = s_x.length;
				s_x += '.';
			}
			while (s_x.length <= pos_decimal + 2) {
				s_x += '0';
			}
			return s_x;
		}
	</script>
</body>
</html>