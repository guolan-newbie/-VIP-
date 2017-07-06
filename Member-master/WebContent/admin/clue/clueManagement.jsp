<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>跟踪管理-Java互助学习VIP群业务运行系统</title>
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
	var type = -1;
	var aid = 0;
	var qq = "";
	$(function() {
		$.ajaxSetup({async : false});
		
		/* 页面一加载获取数据  */
		getData(type, aid, 1, qq);
		
		/* 由类别查询数据 */
		$(".buttype").click(function() {
			type = this.lang;
			qq = "";
			$(".buttype").removeClass("active");
			$(this).addClass("active");
			getData(type, aid, 1, "");
		});
		
		/* 由小助手查询数据  */
		$("#aid").change(function() {
			qq = "";
			aid = $(this).val();
			if(type == -1) {
				$(".buttype").removeClass("active");
				$(".buttype").eq(0).addClass("active");
			}
			getData(type, aid, 1, "");
		});
		
		/* 由QQ号查询数据  */
		$("#qqsearch").click(function() {
			qq = $.trim($("#qq").val());
			var reg = /^\d{1,10}$/;
			if (qq == "") {
				layer.msg("QQ号的输入不能为空！", {
					icon : 0
				});
			} else if (!reg.test(qq)) {
				layer.msg("请输入正确的qq号!", {
					icon : 0
				});
			} else {
				$(".buttype").removeClass("active");
				$("#aid").val(0);
				type = -1;
				aid = 0;
				getData(type, aid, 1, qq);
			}
		});
		
		/* 添加线索 */
		$("#add").click(function() {
			layer.open({
				type : 2,
				title : '添加线索人物',
				area : [ '380px', '400px' ],
				shift : 1,
				shade : 0.5, //开启遮罩关闭
				content : '${pageContext.request.contextPath}/admin/clue/add.jsp',
				end : function () {
					if($("#flag").val() == "1") {
						$(".buttype").removeClass("active");
						$(".buttype").eq(0).addClass("active");
						getData(0, 0, 1, "");
						$("#flag").val("0");
					}
				}
			});
		});
		
		/* 生成表格  */
		$("#download").click(function() {
			$.post("${pageContext.request.contextPath}/clue/download.action", function(data) {
				if (isDataStatus(data)) {
					$("#dl").attr("href", "${pageContext.request.contextPath}/" + data.data);
					layer.tips('下载表格已准备好!', $("#download"), {
						tips : [1, '#3595CC' ],
						time : 4000
					});
				}
			});
		});
		
		/* 下载表格  */
		$("#dl").click(function() {
			if (isBlank($("#dl").attr('href')) == "") {
				layer.tips('请先生成下载表格!', $("#download"), {
					tips : [ 1, '#3595CC' ],
					time : 4000
				});
			}
		});
		
		/* 分页查询  */
		function btnPage() {
			$(".nav-btn").click(function() {
				getData(type ,aid ,this.lang ,qq);
			});
		}
		
		/* 统一的查询方法  */
		function getData(type, aid, page, qq) {
			$.ajaxSetup({async : false});
			$.post("${pageContext.request.contextPath}/clue/getClues.action", {
				type : type, aid : aid, page : page, qq : qq
			}, function(data) {
				if (isDataStatus(data)) {
					drawTable(data.data);
					$("#paging").html(showpage(data.page, data.count));
					btnPage();
					lookCommunicationclick();
					addCommunicationclick();
					joinClick();
					leftClick();
					resetClick();
					changeAid();
					modifyClick();
					deleteClick();
					clickRows();
					setEmphasis();
				}
			});
		}
		
		/* 显示数据 */
		function drawTable(data) {
			if(data.length == 0) {
				layer.msg("没有数据", {
					icon : 0
				});
				$("#tbody").html("");
				return ;
			}
			var line = "";
			for (i = 0; i < data.length; i++) {
				switch (data[i].flag) {
					case 1 : line += "<tr class='rows success'>";break;
					case 2 : line += "<tr class='rows danger'>";break;
					case 3 : line += "<tr class='rows warning'>";break;
					default : line += "<tr class='rows'>";break;
				}

				line += "<td>" + (i + 1) + "</td>";
				line += "<td lang='" + data[i].id +"'>" + data[i].num + "</td>";
				line += "<td><span style='text-decoration:underline'><a href='tencent://message/?uin="+data[i].qq+"&Site=&Menu=yes'>" + data[i].qq + "</a></span></td>";
				line += "<td>" + data[i].sex + "</td>";
				line += "<td>" + isBlank(data[i].realName) + "</td>";
				line += "<td>" + datePattern(data[i].btime) + "</td>";
				line +="<td>" + isBlank(data[i].counts, 0) + "次</td>";
				line += "<td>" + isBlank(data[i].exnum) + "</td>";
				line += "<td class='aname' lang='"+data[i].id+","+data[i].qq+"'>" + data[i].admin.realname + "</td>";
				line += "<td class='memo' id='memo" + (i + 1) + "'>";
				line += "<a title='添加' style='text-decoration:none' class='addCommunication' lang='" + data[i].id + "," + data[i].flag + "," + data[i].qq +"'>添加" + "</a>|";
				line += "<a title='查看' style='text-decoration:none' class='lookCommunication' lang='" + data[i].id + "," + data[i].qq +"'>查看" + "</a>";
				line += "</td>";
				line += "<td>";
				line += "<a title='加入' style='text-decoration:none' class='join' lang='" + data[i].id + "," + data[i].flag + "," + data[i].qq + "'> 加入 " + "</a>|";
				line += "<a title='退出' style='text-decoration:none' class='left' lang='" + data[i].id + "," + data[i].flag + "," + data[i].qq +"'> 结束 " + "</a>|";
				if(data[i].flag != 1 && data[i].flag != 2) {
					if(data[i].flag == 3) {
						line += "<span class='label label-success radius emphasis' lang=" + data[i].id + "," + data[i].flag + "," + data[i].qq + ">重点</span>|";
					} else {
						line += "<span class='label label-warning radius emphasis' lang=" + data[i].id + "," + data[i].flag + "," + data[i].qq + ">非重点</span>|";
					}
				}
				line += "<a title='修改' style='text-decoration:none' class='modify' lang='" + data[i].id + "," + data[i].flag + "'> 修改 </a>|";
				line += "<a title='重置' style='text-decoration:none' class='reset' lang='" + data[i].id + "," + data[i].flag + "," + data[i].qq + "'> 重置 </a>|";
				line += "<a title='删除' style='text-decoration:none' class='delete' lang='" + data[i].id + "," + data[i].flag + "," + data[i].qq + "'> 删除 </a>";
				line += "</td>";
				line += "</tr>";
			}
			$("#tbody").html(line);
		}
		
		/* 点击行变色 */
		function clickRows() {
			$(".rows").click(function() {
				$(".rows").removeClass("info");
				$(this).addClass("info");
			});
		}
		
		/* 改变小助手 */
		function changeAid() {
			$(".aname").dblclick(function() {
				var str = this.lang.split(",");
				var tb = $(this);
				layer.open({
					type : 2,
					title : '设置小助手',
					area : [ '600px', '361px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/admin/clue/clueChangeAssistantst.jsp?id='
							+ str[0] + '&name=' + str[1],
					end : function() {
						if($("#flag").val() == "1") {
							$.post("${pageContext.request.contextPath}/clue/getClueById.action", {id : str[0]}, function(data) {
								if (isDataStatus(data)) {
									tb.html(data.data.admin.realname);
								}
							});
							$("#flag").val("0");
						}
					}
				});
			});
		}
		
		/* 添加沟通信息 */
		function addCommunicationclick() {
			$(".addCommunication").click(function() {
				var tr_element = $(this).parent().parent().children();
				var str = this.lang.split(",");
				if(str[1] != 0 && str[1] != 3) {
					layer.msg("该线索的跟踪已经结束！不能添加沟通信息！", {
						icon : 0
					});
					return ;
				}
				layer.open({
					type : 2,
					title : '添加沟通信息',
					area : [ '800px', '500px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/admin/clue/addCommunication.jsp?id='
							+ str[0] + '&name=' + str[2],
					end : function() {
						if($("#flag").val() == "1") {
							$(tr_element).eq(6).html((parseInt($(tr_element).eq(6).html()) + 1) + "次");
							$("#flag").val("0");
						}
					}
				});
			});
		}
		
		/* 查看沟通信息 */
		function lookCommunicationclick() {
			$(".lookCommunication").click(function() {
				var tr_element = $(this).parent().parent().children();
				var data = this.lang.split(",");
				var id = data[0];
				var name = data[1];
				layer.open({
					type : 2,
					title : '查看沟通信息',
					area : [ '800px', '500px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/admin/clue/lookCommunication.jsp?id='
							+ id + '&name=' + name,
					end : function() {
						if($("#flag").val() >= 1) {
							$(tr_element).eq(6).html((parseInt($(tr_element).eq(6).html()) - $("#flag").val()) + "次");
							$("#flag").val("0");
						}
					}
				});
			});
		}
		
		
		/* 加入体验 */
		function joinClick() {
			$(".join").click(function() {
				var str = this.lang.split(",");
				if(str[1] == 1 || str[1] == 2) {
					layer.msg("该线索的跟踪已经结束！不能加入体验！", {
						icon : 0
					});
					return ;
				}
				$.post("${pageContext.request.contextPath}/clue/checkAttr.action", {
					id : str[0]
				}, function(data) {
					if (isDataStatus(data)) {
						layer.confirm("确认添加qq为【<b class='c-error'>" + str[2] + "</b>】" + "为体验者吗？", {
							btn : [ '是', '否' ]
						}, function() {
							$.post("${pageContext.request.contextPath}/clue/joinExperience.action", {
								id : str[0]
							}, function(data) {
								if (isDataStatus(data)) {
									layer.closeAll();
									getData(type, aid ,$("#btn-currentpage").parent().attr("lang") , qq);
								}
							});
						});
					}
				});
			});
		}
		
		/* 结束跟踪 */
		function leftClick() {
			$(".left").click(function() {
				var str = this.lang.split(",");
				if(str[1] == 1 || str[1] == 2) {
					layer.msg("该线索的跟踪已经结束！不能二次结束！", {
						icon : 0
					});
					return ;
				}
				layer.confirm("您确定要结束qq为【<b class='c-error'>" + str[2] +"</b>】的跟踪吗？", {
					btn : [ '是', '否' ]
				}, function() {
					$.post("${pageContext.request.contextPath}/clue/finishClue.action", {
						id : str[0]
					}, function(data) {
						if (isDataStatus(data)) {
							layer.closeAll();
							getData(type, aid ,$("#btn-currentpage").parent().attr("lang") , qq);
						}
					});
				});
			});
		}
		
		/* 设置重点 */
		function setEmphasis() {
			$(".emphasis").dblclick(function() {
				var str = this.lang.split(",");
				var emphasis = "";
				if(str[1] == 3) {
					emphasis = "<span class='label label-warning radius'>非重点</span>";
				} else {
					emphasis = "<span class='label label-success radius'>重点</span>";
				}
				layer.confirm("确认将qq为【<b class='c-error'>" + str[2] + "</b>】" + "设置为" + emphasis + "么吗？", {
					btn : [ '是', '否' ]
				}, function() {
					$.post("${pageContext.request.contextPath}/clue/emphasis.action", {
						id : str[0]
					}, function(data) {
						if (isDataStatus(data)) {
							layer.closeAll();
							getData(type, aid ,$("#btn-currentpage").parent().attr("lang") , qq);
						}
					});
				});
			});
		}
		
		/* 修改资料 */
		function modifyClick() {
			$(".modify").click(function() {
				var tr_element = $(this).parent().parent().children();
				var str = this.lang.split(",");
				if(str[1] == 1 || str[1] == 2) {
					layer.msg("该线索的跟踪已经结束！不允许修改！", {
						icon : 0
					});
					return ;
				}
				layer.open({
					type : 2,
					title : '修改线索用户信息',
					area : [ '380px', '500px' ],
					shift : 1,
					shade : 0.5,
					content : '${pageContext.request.contextPath}/admin/clue/modify.jsp?id='
							+ str[0],
					end : function() {
						if($("#flag").val() == "1") {
							$.post("${pageContext.request.contextPath}/clue/getClueById.action", {id : str[0]}, function(data) {
								if (isDataStatus(data)) {
									$(tr_element).eq(3).html(data.data.sex);
									$(tr_element).eq(4).html(isBlank(data.data.realName));
									$(tr_element).eq(5).html(new Date(data.data.btime).pattern("yyyy-MM-dd"));
								}
							});
							$("#flag").val("0");
						}
					}
				});
			});
		}
		
		/* 重置状态 */
		function resetClick() {
			$(".reset").click(function() {
				var str = this.lang.split(",");
				if(str[1] == 1) {
					layer.msg("该线索已经变成体验者，不允许重置！", {
						icon : 0
					});
					return ;
				}
				layer.confirm("您确定要重置qq为【<b class='c-error'>" 
						+ str[2] +"</b>】的线索吗？<br>注意重置不会修改信息，信息需要自行修改！", {
					btn : [ '是', '否' ]
				}, function() {
					$.post("${pageContext.request.contextPath}/clue/reset.action", {
						id : str[0]
					}, function(data) {
						if (isDataStatus(data)) {
							layer.closeAll();
							getData(type, aid ,$("#btn-currentpage").parent().attr("lang") , qq);
						}
					});
				});
			});
		}
		
		/* 删除线索 */
		function deleteClick() {
			$(".delete").unbind().click(function() {
				var str = this.lang.split(",");
				if(str[1] == 1) {
					layer.msg("该线索已经变成体验者，不允许删除！", {
						icon : 0
					});
					return ;
				}
				layer.confirm("您确定要删除qq为【<b class='c-error'>" 
						+ str[2] +"</b>】的线索吗？<br>删除该线索用户时，同时也会删除该线索用户的沟通信息，请谨慎操作！", {
					btn : [ '是', '否' ]
				}, function() {
					$.post("${pageContext.request.contextPath}/clue/deleteById.action", {
						id : str[0]
					}, function(data) {
						if (isDataStatus(data)) {
							layer.closeAll();
							getData(type, aid ,$("#btn-currentpage").parent().attr("lang") , qq);
						}
					});
				});
			});
		}
	});
</script>
</head>
<body>
	<div class="panel panel-secondary">
		<div class="panel-header">
			<div style="float: left;">
				<input type="hidden" id="flag" value="0">
				<button class="btn btn-success" id="add">
					<i class="fa fa-plus" aria-hidden="true"></i> 添加跟踪者
				</button>
			</div>
			<div class="btn-group" style="float: left;">
				<button type="button" class="btn btn-primary radius active buttype"
					lang="-1">所有线索</button>
				<button type="button" class="btn btn-primary radius buttype"
					lang="0">正在跟踪</button>
				<button type="button" class="btn btn-primary radius buttype"
					lang="3">重点线索</button>
				<button type="button" class="btn btn-primary radius buttype"
					lang="1">加入体验</button>
				<button type="button" class="btn btn-primary radius buttype"
					lang="2">停止跟踪</button>
			</div>
			<div class="form-group">
				<span class="select-box radius" style="width: 100px;background : white;">
					<select class="select" id="aid">
						<option value="0">所有人</option>
						<option value="36">王炜强</option>
						<option value="37">曾小晨</option>
						<option value="22">闽光磊</option>
						<option value="32">刘文启</option>
						<option value="54">陈家豪</option>
						<option value="41">张晓敏</option>
					</select>
				</span>
				<input id="qq" type="text" placeholder="QQ号" style="width: 100px"
					class="input-text radius" />
				<button id="qqsearch" class="btn btn-success" type="button">
					<i class="fa fa-search" aria-hidden="true"></i> QQ号模糊查询
				</button>
			</div>
			<div class="btn-group" style="float: right">
				<button type="button" class="btn btn-primary radius" id="download">生成表格</button>
				<a class="btn btn-primary radius" target="_blank" id="dl">点击下载</a>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class="text-c">
					<tr>
						<th>序号</th>
						<th>用户名</th>
						<th>QQ</th>
						<th>性别</th>
						<th>姓名</th>
						<th>开始时间</th>
						<th>沟通次数</th>
						<th>体验编号</th>
						<th>助教</th>
						<th>沟通信息</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class="page-nav" style="float: right; margin-top: 10px;" id="paging"></div>
</body>
</html>