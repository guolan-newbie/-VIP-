<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/images/icon/H~ui_ICON_1.0.8/iconfont.css"
	rel="stylesheet" type="text/css" />
<title>计算器</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<!-- 部分浏览器不支持JSON.stringify 需导入json2.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/json2.js"></script>
<!-- My97DatePicker日期插件js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/datePicker/WdatePicker.js"></script>
</head>
<body>
	<table
		class="table table-border table-bg table-bordered radius">
		<tr>
			<td>开始时间：</td>
			<td><input type="text" id="time"
				onFocus="WdatePicker({lang:'zh-cn'})" readonly></td>
		</tr>
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
			<td colspan="2"><input type="button" id="btn1" value="显示还款详单"
				class="btn btn-default radius" /></td>
		</tr>
		<tr>
			<td>备注：</td>
			<td><div id="msg"></div></td>
		</tr>
	</table>
	<table id="infotb"
		class="table table-border table-bg table-bordered radius">
	</table>

	<div id="abcd"></div>
	<script type="text/javascript">
		$(function() {
			//开始时间默认显示当前时间
			var d = new Date();
			var s = d.getFullYear()+ "-" + addZero(d.getMonth() + 1) + "-" + addZero(d.getDate());
			$("#time").val(s);
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
								//开始时间
								var time = $("#time").val();
								if (time.length == 0) {
									layer.open({
										  type: 1,
										  area: ['300px', '180px'], //宽高
										  shadeClose: true, //点击遮罩关闭
										  content: '\<\div style="padding:20px;">请选择开始时间!\<\/div>'
										});
									return false;
								}
								//利率
								var lilv = Number($("#lilv").val());
								var y = lilv + 1;
								//费用
								var feiyong = Number($("#feiyong").val());
								//金额
								var x = feiyong;
								//每月支付金额
								var monthPay = Number($("#money").val());
								//延迟还款时间
								var delayMonth = Number($("#delayMonth").val());

								var total = 0;
								var lixi = 0;
								var benjin = 0;

								var money = 0;

								//自定义变量判断价格是否合理
								var flag = false;
								//判断是否有首付
								var hassf = false;
								$("#infotb")
										.append(
												"<tr><td>月份</td><td>时间</td><td>本月还款金额</td><td>还款金额中的利息</td><td>还款金额中的本金</td><td>剩余本息合计</td><td>提前还款</td></tr>");
								for (month; month < 1000; month++) {
									if (month > 888) {
										$("#infotb").empty();
										layer.open({
											  type: 1,
											  area: ['300px', '180px'], //宽高
											  shadeClose: true, //点击遮罩关闭
											  content: '\<\div style="padding:20px;">还款计划不合理!\<\/div>'
											});
										flag = true;
										break;
									}
									//延迟delayMonth个月后缴费
									if (month <= delayMonth) {
										money = 0;
									} else {
										money = monthPay;
									}
									if (x * y > money) {
										if (month <= delayMonth) {
											total = total + money;
											lixi = x * lilv;
											benjin = money - lixi;
											x = (x * y - money);
										} else {
											//如果首付不为0
											if (sf != 0) {
												hassf = true;
												money = sf;
												total = total + money;
												lixi = 0;
												benjin = sf - lixi;
												x = x - money;
											} else {
												total = total + money;
												lixi = x * lilv;
												benjin = money - lixi;
												x = (x * y - money);
											}
										}
										if (month <= delayMonth) {
											$("#infotb")
													.append(
															"<tr><td>"
																	+ month
																	+ "</td><td>"
																	+ getDate(
																			month - 1,
																			time)
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
																	+ getDate(
																			month - 1,
																			time)
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
																+ getDate(
																		month - 1,
																		time)
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
									//如果已经写出首付则首付置0
									if (hassf) {
										sf = 0;
									}
								}
								$("#total").val(changeTwoDecimal_f(total));
								$("#lixi").val(
										changeTwoDecimal_f(total - feiyong));

								//table不为空弹出
								if (!flag) {
									if ($("#excel").length == 0) {
										//点击后生成excel按钮，值得注意的是，多次点击必须只生成一个按钮
										$("#abcd")
												.append(
														"<input type=\"button\" id = \"excel\" value=\"导出excel\" class=\"btn btn-default radius\">")
									}
								} else {
									$("#excel").remove();
								}
							});
			//给按钮绑定click事件
			$("#abcd").on('click',"#excel",
							function() {
								//ajax后台交互url

								//设计缴费信息提交url
								var src = "${pageContext.request.contextPath}/transferValue.action";

								//下载excel url
								var excelUrl = "${pageContext.request.contextPath}/download.action";

								var trArr = $("#infotb").find("tr");

								//以json数组的方式传递table数据
								var tableJson = []
								trArr.each(function(i, e) {
									//添加table每一行作为对象添加到数组中
									tableJson.push({
										"month" : $(this).find("td").eq(0)
												.text(),
										"time" : $(this).find("td").eq(1)
												.text(),
										"mpay" : $(this).find("td").eq(2)
												.text(),
										"interest" : $(this).find("td").eq(3)
												.text(),
										"capital" : $(this).find("td").eq(4)
												.text(),
										"numInterest" : $(this).find("td")
												.eq(5).text()
									});
								})
								var jsonData = JSON.stringify(tableJson);
								$.ajax({
									type : "POST",
									async : false,
									url : src,
									data : {
										tableJson : jsonData
									}
								})
								window.open(excelUrl);
							});
		});

		function getList(month) {
			$("#info").html("");
			$("#infotb").html("");

			var time = $("#time").val();
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
							"<tr><td>月份</td><td>时间</td><td>还款金额</td><td>还款金额中的利息</td><td>还款金额中的本金</td></td><td>剩余本息合计</td></tr>");
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
							"<tr><td>" + i + "</td><td>" + getDate(i - 1, time)
									+ "</td><td>" + changeTwoDecimal_f(money)
									+ "</td><td>" + changeTwoDecimal_f(lixi)
									+ "</td><td>"
									+ changeTwoDecimal_f(money - lixi)
									+ "</td><td>"
									+ changeTwoDecimal_f(x - money)
									+ "</td></tr>");
					x = x - money;
					continue;
				}
				if (month == i) {
					$("#infotb").append(
							"<tr><td>" + i + "</td><td>" + getDate(i - 1, time)
									+ "</td><td>" + changeTwoDecimal_f(x)
									+ "</td><td>" + changeTwoDecimal_f(lixi)
									+ "</td><td>" + changeTwoDecimal_f(benjin)
									+ "</td><td>" + 0 + "</td></tr>");
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
		//num 加减月份数 time yyyy-MM-dd格式数据
		function getDate(num, time) {
			var timeArr = time.split("-");
			var day = Number(timeArr[2]);
			var mo = Number(timeArr[1]);
			var year = Number(timeArr[0]);
			year += parseInt((num + mo - 1) / 12);
			mo = mo + num % 12;
			if (mo > 12) {
				mo = mo - 12;
			}

			//小月
			if (mo == 4 || mo == 6 || mo == 9 || mo == 11) {
				if (day > 30) {
					day = 30
				}
			}
			//2月
			else if (mo == 2) {
				if (isLeapYear(year)) {
					if (day > 29) {
						day = 29
					} else {
						day = 28
					}
				}
				if (day > 28) {
					day = 28
				}
			}
			//大月
			else {
				if (day > 31) {
					day = 31
				}
			}
			mo = addZero(mo);
			day = addZero(day);
			//var date = new Date(("year+"-"+mo+"-"+day").replace(/-/g,"/"));
			//var returnValue = date.format("yyyyMMdd");
			retureValue = year + "-" + mo + "-" + day;
			return retureValue;
		}

		//JS判断闰年代码
		function isLeapYear(Year) {
			if (((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
				return (true);
			} else {
				return (false);
			}
		}
		//配合yyyyMMdd格式
		function addZero(v){
			if(v < 10){
				return '0'+v;
			}
			return v.toString();
		}
	</script>
</body>
</html>