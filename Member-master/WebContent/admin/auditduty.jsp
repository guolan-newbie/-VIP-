<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>会员值班批量审核</title>
<link
	href="${pageContext.request.contextPath}/resources/uikit-2.25.0/css/uikit.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/uikit-2.25.0/js/uikit.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>

<script type="text/javascript">
	$(function() {
		$.post("${pageContext.request.contextPath}/onduty/getAllMemberByFlag.action",function(data) {
			var returnMap = eval("(" + data + ")").returnMap;
			var statusCode = returnMap.statusCode;
			if(statusCode.errNum != 100) {
				layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
				return ;
			}
			var members = returnMap.members;
			var line = "";
			var length = members.length;
			if (length > 0) {
				line += "<option value='0'>请选择</option>";
				for (var i = 0; i < length; i++) {
					line += "<option value='" + members[i].id + "'>" + members[i].name + "</option>";
				}
			} else {
				line += "<option value='0'>无</option>";
			}
			$("#select").html(line);
			select();
			button();
		});
	});
	function drawTable(data, dates, starts, ends) {
		var line = "<thead>";
		line += "<tr class='info'>";
		line += "<td>序号</td>";
		line += "<td>值班日期</td>";
		line += "<td>开始时间</td>";
		line += "<td>结束时间</td>";
		line += "<td>日志</td>";
		line += "<td width='120px'><input id='checkall' type='checkbox' lang='0'/></td>";
		line += "</tr>";
		line += "</thead>";
		line += "<tbody>";
		for (i = 0; i < data.length; i++) {
			line += "<tr>";
			line += "<td>" + (i + 1) + "</td>";
			line += "<td>" + dates[i] + "</td>";
			line += "<td>" + starts[i] + "</td>";
			line += "<td>" + ends[i] + "</td>";
			line += "<td><a class='glyphicon glyphicon-list-alt' title='查看值班记录' lang='" + data[i].id + "'></a></td>";
			line += "<td><input class='checke' type='checkbox' lang='" + data[i].id + "'></td>";
			line += "</tr>";
		}
		line += "</tbody>";
		$("#table").html(line);
		$("#button").html("<button type='button' class='btn btn-info btn-lg' id='checkall'>审核</button>");
	}
	function checkall() {
		$("#checkall").click(function() {
			var checked = this.checked;
			$("input[type='checkbox']").each(function() {
				this.checked = checked;
			});
		});
	}
	//改变全选按钮的状态
	function clicking() {
		$(".checke").click(function(){
			var checked = this.checked;
			var i = 0;
			$(".checke").each(function() {
				if(!this.checked) {
					i++;
				}
			});
			if(i == 0) {
				$("#checkall").prop("checked",true);
			} else {
				$("#checkall").prop("checked",false);
			}
		});
	}
	function look() {
		$(".glyphicon-list-alt").click(function() {
			parent.layer.open({
				type : 2,
				title : '查看值班日志',
				area : [ '800px', '500px' ],
				shift : 1,
				maxmin : true,
				shade : 0.5, //开启遮罩关闭
				content : "${pageContext.request.contextPath}/onduty/showlogs.jsp?oid=" + this.lang + "&type=admin",
			});
		});
	}
	function select() {
		$("#select").change(function() {
			var mid = this.value;
			if (mid != 0) {
				$.post("${pageContext.request.contextPath}/onduty/getOndutyByMidAndFlag.action",{mid : mid},function(data) {
					var returnMap = eval("(" + data + ")").returnMap;
					var statusCode = returnMap.statusCode;
					if(statusCode.errNum != 100) {
						layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
						return ;
					}
					var ondutys = returnMap.ondutys;
					var dates = returnMap.dates;
					var starts = returnMap.starts;
					var ends = returnMap.ends;
					$("#mid").val(mid);
					drawTable(ondutys, dates,starts, ends);
					checkall();
					clicking();
					look();
				});
			} else {
				$("#table").html("");
				$("#button").html("");
			}
		});
	}
	function button() {
		$("#button").click(function() {
			var i = 0;
			var str = "";
			$(".checke").each(function() {
				if(this.checked) {
					i++;
					str += this.lang + ",";
				}
			});
			if(i == 0) {
				layer.msg("你未选中任何一条记录!", {icon : 0});
				return ;
			}
			layer.confirm("你确定要通过这<b style='color:red'>" + i + "</b>条值班记录", {
				btn: ["确定","取消"] //按钮
				}, function(){
					$.post("${pageContext.request.contextPath}/onduty/auditing.action", {string : str, mid : $("#mid").val()}, function(data) {
						var returnMap = eval("(" + data + ")").returnMap;
						var statusCode = returnMap.statusCode;
						if(statusCode.errNum != 100) {
							layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
							return ;
						}
						location.reload();
					});
				});
		});
	}
</script>
</head>
<body>
	<div class="container">
		<p>
			选择会员: 
			<select id="select">
				<option value="0">加载中</option>
			</select>
		</p>

		<table id="table" class="table table-striped table-bordered table-hover text-center"></table>
		<div id="button"></div>
		<br>
		<input type="hidden" id="mid" value="0" />
	</div>

</body>
</html>