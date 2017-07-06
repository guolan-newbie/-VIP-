<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="utf-8">
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.css"
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
		var page2 = 1;
		getData(page2);
		$(".choices").click(function() {
			var type = this.lang;
			$(".choices").removeClass("active");
			$(this).addClass("active");
			if(type==6){
				getData(page2);
			}else{
				getData2(type,page2);
			}
		});
	});
	function getData(page2) {
		$.ajaxSetup({
			async : false
		});
		$.post("${pageContext.request.contextPath}/user/getUserByPage.action", {type : 6,page2 : page2}, function(data) {
			var dataObj = eval("(" + data + ")");
			var navbar = dataObj.returnMap.navbar;
			var list = dataObj.returnMap.list; 
			drawTable(list);
			$(".page-nav").html(navbar);
			btnpage();
		})
	}
	 function getData2(type,page2) {
		$.ajaxSetup({
			async : false
		});        
		 $.post("${pageContext.request.contextPath}/member/getAccountLogLast.action", {type : 1,page2 : page2}, function(data) {
			showTable(data.data);
			$("#paging").html(showpage(data.page, 10));
			btnpage2();
		}) 
		
	} 
	 function showTable(data){
		var line = "";
		line=line+"<tr>"+
		"<th>会员号</th>"+
		"<th>姓名</th>" +
		"<th>校名</th>" +
		"<th>电话</th>" +
		"<th>金额</th>" +
		"<th>缴费日期</th>" +
		"<th>审核人</th>" +
		"</tr>";					 
		for(var i=0;i<data.length;i++){
			
			var row = "";
			row += "<tr>"					
 			row += "<td>" + data[i].user.name + "</td>";
			row += "<td>" + data[i].member.name + "</td>";
			if(data[i].member.school==null){
				row += "<td></td>";
			}
			else{
 				row += "<td>" + data[i].member.school + "</td>";
			};
 			row += "<td>" + data[i].member.mobile + "</td>";
			row += "<td>" + data[i].amount + "</td>";
			row += "<td>" + new Date(data[i].date).pattern("yyyy年MM月dd日")  + "</td>";
			if(data[i].admin==null){
					row += "<td></td>";
				}
				else{
					row += "<td>" + data[i].admin.realname + "</td>";
				};
					row += "</tr>";
			
			line =line+row;	
		}
			$("#tbody").html(line);
		
	} 
	function drawTable(data) {
		var line = "";
		line=line+"<tr>"+
		"<th>会员号</th>"+
		"<th>姓名</th>" +
		"<th>校名</th>" +
		"<th>电话</th>" +
		"<th>金额</th>" +
		"<th>日期</th>" +
		"<th>小助手</th>" +
		"<th>操作</th>" +
		"</tr>";
		for (i = 0; i < data.length; i++) {
			var row = "";
			row += "<tr>"
			row += "<td>" + data[i].name + "</td>";
			row += "<td>" + data[i].member.name + "</td>";
			row += "<td>" + data[i].member.school + "</td>";
			row += "<td>" + data[i].member.mobile + "</td>";
			alert(data[i].member.alog>0);
			if(data[i].member.alog >0) {
				$.post("${pageContext.request.contextPath}/member/getByMidAndFlag.action",{mid : data[i].member.id},function(data2) {
					var dataObj = eval("("+data2+")");
					alert(dataObj.toString());
					var lists = dataObj.returnMap.list;
					for(j = 0; j <lists.length; j++) {
						line = line + row + "<td style='color:red;'>" + lists[j].amount + "</td>";
						line = line + "<td>" + lists[j].formatDate + "</td>";
						if (data[i].admin != null) {
							line = line + "<td>" + data[i].admin.realname + "</td>";
						} else {
							line = line + "<td></td>";
						}
						line = line + "<td>";
						var date = lists[j].formatDate.split(" ");
						var str = data[i].member.id + "," + lists[j].id + "," + data[i].member.name + "," + date[0] + "&nbsp;" + date[1] + "," + lists[j].amount + "," + lists[j].fileflag + "," + lists[j].upflag + "," + lists[j].type;
						var disabled = "";
						var css = "";
						if(j != 0) {
							disabled = "disabled='disabled'";
							css = "disabled";
						}
						line = line + "&nbsp;&nbsp;<input type='button' value='审核' class='btn btn-danger radius auditing " + css + "'" + disabled +"lang=" + str + ">";
						line = line + "&nbsp;&nbsp;<input type='button' value='删除' class='btn btn-warning radius del " + css + "'" + disabled +"lang=" + str + ">";
						line = line + "</td></tr>";
					}
				});
			} else {
				if(data[i].accountLog!=null){
					line = line + row + "<td style='color:red;'>" + data[i].accountLog.amount + "</td>";
					line = line + "<td>" + data[i].accountLog.formatDate + "</td>";
				}else{
					line = line + row + "<td>" +data[0].amount + "</td>";
					line = line + "<td>" + "123" + "</td>";
				}
				if (data[i].admin != null) {
					
					line = line + "<td>" + data[i].admin.realname + "</td>";
				} else {
					line = line + "<td>" + "" + "</td>";
				}
				line = line + "<td>";
				//不知道为什么用SimpleDateFormat("yyyy-MM-dd HH:mm:ss")格式化完成后中间的空格会被识别成换行符
				if(data[i].accountLog!=null){	
				var date = data[i].accountLog.formatDate.split(" ");
				var str = data[i].member.id + "," + data[i].accountLog.id + "," + data[i].member.name + "," + date[0] + "&nbsp;" + date[1] + "," + data[i].accountLog.amount + "," + data[i].accountLog.fileflag + "," + data[i].accountLog.upflag + "," + data[i].accountLog.type;
				line = line + "&nbsp;&nbsp;<input type='button' value='审核' class='btn btn-danger radius auditing' lang=" + str + ">";
				line = line + "&nbsp;&nbsp;<input type='button' value='删除' class='btn btn-warning radius del' lang=" + str + ">";
				line = line + "</td></tr>";
				}else{
					alert("data数据为空");
				}
			}
		}
		$("#tbody").html(line);
		
		$(".auditing").click(function() {
			var str = this.lang.split(",");
			var s1 = "您确定要<b style='color:red;'>通过</b>【" + str[2] + "】在【" + str[3] + "】时，金额为【<b style='color:red;'>" + str[4] + "</b>】的缴费?<br />";
			$.post("${pageContext.request.contextPath}/member/auditing.action",{mid : str[0]}, function(data) {
				if(data != "") {
					var str1 = data.split(",");
					s1 += "上一次的缴费时间是【<b style='color:red;'>" + str1[0] + "</b>】，金额为【<b style='color:red;'>" + str1[1] + "</b>】！";
				} else {
					s1 += "本次是第一次缴费！";
				}
			});
			s1 += "<br />";
			var s2 = "";
			if (str[5] == "1") {
				var ratio = str[7].split("*");
				s2 = "<img src='${pageContext.request.contextPath}/member/getPhoto.action?accountLogId=" + str[1] + "&random=" + Math.random() + "' style='height:" + ratio[0] + ";width:" + ratio[1] + ";'>";
			}
			layer.confirm(s1 + s2, {
				btn : [ '确定', '放弃' ],
				area : [ '570px']
			}, function() {
				$.post("${pageContext.request.contextPath}/member/checkLog.action",{id : str[0], accountlogID : str[1], upflag : str[6]}, function(data) {
					layer.closeAll();
					if(data == "1") {
						layer.msg("<strong style='color:red;'>操作失败,数据已被删除</strong>", {icon: 2});
					} else if(data == "2") {
						layer.msg("<strong>数据不是最新的，请等待刷新后再审核</strong>", {icon: 0});
					}
					getData($("b").text());
				});
			});
		});
		$(".del").click(function() {
			var str = this.lang.split(",");
			var s1 = "您确定要<b style='color:red;'>删除</b>【" + str[2] + "】在【" + str[3] + "】时，金额为【<b style='color:red;'>" + str[4] + "</b>】的缴费?<br />";
			$.post("${pageContext.request.contextPath}/member/auditing.action",{mid : str[0]}, function(data) {
				if(data != "") {
					var str1 = data.split(",");
					s1 += "上一次的缴费时间是【<b style='color:red;'>" + str1[0] + "</b>】，金额为【<b style='color:red;'>" + str1[1] + "</b>】！";
				} else {
					s1 += "本次是第一次缴费！";
				}
			});
			s1 += "<br />";
			var s2 = "";
			if (str[5] == "1") {
				var ratio = str[7].split("*");
				s2 = "<img src='${pageContext.request.contextPath}/member/getPhoto.action?accountLogId=" + str[1] + "&random=" + Math.random() + "' style='height:" + ratio[0] + ";width:" + ratio[1] + ";'>";
			}
			layer.confirm(s1 + s2,{
				btn : [ '确定', '放弃' ],
				area : [ '570px' ]
			},function() {
				$.post("${pageContext.request.contextPath}/member/deleteLog.action",{id : str[0], accountlogID : str[1], upflag : str[6]}, function(data) {
					layer.closeAll();
					if(data == "1") {
						layer.msg("<strong style='color:red;'>操作失败,数据已被删除</strong>", {icon: 2});
					} else if(data == "2") {
						layer.msg("<strong>数据不是最新的，请等待刷新后再审核</strong>", {icon: 0});
					}
					getData($("b").text());
				});
			});
		});
	}
	function btnpage() {
		$(".nav-btn").click(function() {
			getData(this.lang);
		});
		
	}
	function btnpage2() {
		$(".nav-btn").click(function() {
			var page2 = this.lang;
			getData2(1 ,page2);
		});
	}
</script>
</head>
<body>
	<c:if test="${ADMIN==null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<h1 class="text-c">VIP会员缴费审核</h1>
	<div class="mt-20">
		<table
			class="table table-border table-bg table-bordered radius" id="period">
		</table>
	</div>
	<div class="panel panel-secondary">
		<!-- <div class="panel-header"></div> -->
		<div class="panel-header cl">
			<div class="btn-group f-l">
				<span class="btn btn-primary radius active choices" lang="6">未审核信息</span>
				<span class="btn btn-primary radius choices" lang="1">已审核信息</span>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;" id="paging"></div>
</body>
</html>