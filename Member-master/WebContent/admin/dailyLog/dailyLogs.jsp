<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>工作日志</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/plugin/jeDate/css/jedate.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/jeDate/jedate/jquery.jedate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		$("#date").jeDate({
			isinitVal : true,
			festival : true,
			ishmsVal : false,
			festival : false,
			isClear :false,
			format : "YYYY-MM-DD",
			zIndex : 3000,
			choosefun : function() {
				dateclick();
		    },
		    okfun:function() {
		    	dateclick();
		    }
		});
		
		/* 页面一加载获取数据  */
		$("#time").html((new Date()).pattern("yyyy-MM-dd EEE"));
		getdata($("#aname").val(), new Date($("#date").val()), 1);
		
		/* 点击对应的人获取数据  */
		$("#aname").change(function() {
			getdata($("#aname").val(), new Date($("#date").val()), 1);
		});
		
		/* 选择时间获取数据 */
		function dateclick() {
	        $("#time").html((new Date($("#date").val())).pattern("yyyy-MM-dd EEE"));
	        getdata($("#aname").val(), new Date($("#date").val()), 1);
		}
		
		/* 分页查询  */
		function btnpage() {
			$(".nav-btn").click(function() {
				var page = this.lang;
				$("#pageValue").val(page);
				getdata($("#aname").val(), new Date($("#date").val()), page);
			});
		}
		
		/* 统一的查询方法  */
		function getdata(name, time, page) {
			$.post("${pageContext.request.contextPath}/dailylog/getDailyLog.action",{name : name, time : time, page : page}, function(data) {
				showData(data.data);
				$("#paging").html(showpage(data.page, data.count));
				clickRows();
				btnpage();
			});
		}
		
		/* 展示数据 */
		function showData(data) {
			var line = "";
			for (i = 0; i < data.length; i++) {
				line += "<tr class='rows'>";
				line += "<td>" + (i + 1) + "</td>";
				line += "<td>" + data[i].name + "</td>";
				line += "<td>" + new Date(data[i].time).pattern("yyyy年MM月dd日") + "</td>";
				line += "<td>" + new Date(data[i].created).pattern("yyyy年MM月dd日") + "</td>";
				line += "<td  lang='" + data[i].id +"'><a href='javascript:void(0)' class='dailylog' lang='" + data[i].id +"'>查看</a>"
				line += " | <a href='javascript:void(0)' class='modifyDailylog' lang='" + data[i].id +"!"+ data[i].name +"'>修改</a>";
				line += " | <a href='javascript:void(0)' class='deleteDailylog' lang='" + data[i].id +"!"+ data[i].name +"'><i class='Hui-iconfont'>&#xe609;</i></a></td>";
				line += "</tr>";
			}
			$("#tbody").html(line);
			show();
			modify();
			deleteDailylog();
		}
		
		/* 编写工作日志 */
		$("#write").click(function() {
			layer.open({
				type : 2,
				title : '编写工作日志',
				area : [ '780px', '550px' ],
				shift : 1,
				shade : 0.5, //开启遮罩关闭
				content : '${pageContext.request.contextPath}/admin/dailyLog/dailyLogWrite.jsp',
				end : function() {
					getdata($("#aname").val(), new Date($("#date").val()), 1);
				}
			});
		});
		/* 查看某一条的工作日志 */
		function show() {
			$(".dailylog").click(function() {
				$(".dailylog").removeClass("info");
				$(this).addClass("info");
				$("#name").html(name);
				var id = this.lang;
				layer.open({
					type : 2,
					title : '查看工作日志',
					area : [ '780px', '550px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/admin/dailyLog/dailyLog.jsp?id=' + id,
				});
			});
		}
		
		/* 修改工作日志 */
		function modify() {
			$(".modifyDailylog").click(function() {
				$.ajax({ 
					async : false
				});
				$(".modifyDailylog").removeClass("info");
				$(this).addClass("info");
				$("#name").html(name);
				var url= this.lang;
				var id_name=url.split("!");
				var name=id_name[1];
				$.post("${pageContext.request.contextPath}/dailylog/checkAuthority.action",{name :name},function(data){
					if (isDataStatus(data)) {
							url=encodeURI(url); 
							url=encodeURI(url);
							layer.open({
								type : 2,
								title : '修改工作日志',
								area : [ '780px', '550px' ],
								shift : 1,
								shade : 0.5, //开启遮罩关闭
								content : '${pageContext.request.contextPath}/admin/dailyLog/modifyDailyLog.jsp?id_name='+url,
								end : function() {
									getdata($(".active").html(), new Date($("#date").val()), $("#pageValue").val());
								}
							});
						} else {
							layer.msg("<strong style='color:red;'>"+data.msg+"</strong>",{icon : 2});
						}
				});
			});
		}
			
		/* 删除工作日志 */
		function deleteDailylog() {
			$(".deleteDailylog").click(function(){
				var url= this.lang;
				var id_name=url.split("!");
				var id=id_name[0];
				var name=id_name[1];
				$.post("${pageContext.request.contextPath}/dailylog/checkAuthority.action",{name :name},function(data){
					if (data.status == 100||data.status==205) {
						if(confirm("您确定删除此条工作日志？"))
						{
							$.post("${pageContext.request.contextPath}/dailylog/deleteDailyLog.action",
								{id: id,name :name},function(data) {
								if (data.status == 100) {
									getdata($(".active").html(), new Date($("#date").val()), $("#pageValue").val());
								}
							});
						}
					} else if(data.status == 201){
						layer.msg("<strong style='color:red;'>你不是管理员没有权限修改！</strong>",{icon : 2});
					} else if (data.status == 204){
						layer.msg("<strong style='color:red;'>你的权限不足,不能修改他人的工作日志！</strong>",{icon : 2});
					} else {
						layer.msg("<strong style='color:red;'>发生了错误，请重试！</strong>",{icon : 2});
					}
				});
			});
		}
	});
</script>
</head>
<body>
	<div class="panel panel-secondary">
		<div class="panel-header">
			<span class="select-box radius" style="width: 100px;background : white;">
				<select class="select" id="aname">
					<option value="所有人">所有人</option>
					<option value="王炜强">王炜强</option>
					<option value="曾小晨">曾小晨</option>
					<option value="闽光磊">闽光磊</option>
					<option value="刘文启">刘文启</option>
					<option value="陈家豪">陈家豪</option>
					<option value="张晓敏">张晓敏</option>
					<option value="邵雨鑫">邵雨鑫</option>
					<option value="王俞然">王俞然</option>
					<option value="赵年">赵年</option>
					<option value="吴国春">吴国春</option>
					<option value="王鑫">王鑫</option>
					<option value="胡志诚">胡志诚</option>
				</select>
			</span>
			<span id="time"></span> 工作日志
			<span class="btn btn-primary radius" id="write">编写工作日志</span>
			<div style="float: right">
				时间选择：
				<input class="input-text radius" id="date" type="text" style="width:120px;" readonly>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>序号</th>
						<th>姓名</th>
						<th>日志时间</th>
						<th>创建时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody class='text-c' id='tbody'></tbody>
			</table>
		</div>
	</div>
	<div class="page-nav" style="float: right; margin-top: 10px;" id="paging"></div>
	<input type="hidden" id="pageValue" value="1"/> 
</body>
</html>