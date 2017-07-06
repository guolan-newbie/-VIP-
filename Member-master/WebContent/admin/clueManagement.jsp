<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>跟踪管理-Java互助学习VIP群业务运行系统</title>

<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/images/icon/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	var assistant = 0;
	var qq = "";
	$(function() {$.ajaxSetup({async : false});
		//第一次点击进来的默认值
		getData(assistant, 1, "");
	});
	
	function IniEvent() {
		  var tbl = document.getElementById("clue");
		  var trs = tbl.getElementsByTagName("tr");
		  for (var i = 0; i < trs.length; i++) {
		 trs[i].onclick = TrOnClick;
		  }
		}
		function TrOnClick() {
		  var tbl = document.getElementById("clue");
		  var trs = tbl.getElementsByTagName("tr");
		  for (var i = 0; i < trs.length; i++) {
		 if (trs[i] == this) { //判断是不是当前选择的行
		   trs[i].style.background = "yellow";
		 }
		 else {
		   trs[i].style.background = "white";
		 }
		  }
		}
	
	
	/* 统一的查询方法  */
	function getData(aid, page, qq) {
		$.ajaxSetup({async : false});
		$.post("${pageContext.request.contextPath}/clue/getClues.action", {aid:aid, page:page, qq:qq}, function(data) {
			if (data.data.length > 0) {
				drawTable(data.data);
			} else {
				layer.msg("没有数据", {
					icon : 0
				});
			} 
			$("#paging").html(showpage(data.page, data.count));
			btnpage();
			lookCommunicationclick();
			addCommunicationclick();
			joinclick();
			leftclick();
			resetclick();
			addclick();
			dbclick();
			modifyclick();
			deleteclick();
			createdl();
			dlclick();
			showdataByAid();
			showall();
			IniEvent();
			TrOnClick();
		});
	}
	
	/* 分页查询  */
	function btnpage() {
		$(".nav-btn").click(function() {
			var page = this.lang;
			getData(assistant ,page ,qq );
		});
	}

	//显示根据助手查询的数据
	function showdataByAid() {
		$(".butname").unbind("click").click(function() {
			qq = "";
			assistant = this.lang;
			$(".btn").removeClass("active");
			$(this).addClass("active");
			getData(assistant, 1, "");
		});
	}

	//生成表格点击事件
	function createdl() {
		$("#download").click(
			function() {
				$.post("${pageContext.request.contextPath}/clue/download.action?flag=1", function(data) {
					$("#dl").attr("href", "http://www.xinqushi.net" + data);
					layer.tips('主人,下载表格我已经为您准备好!', $("#download"), {
						tips : [1, '#3595CC' ],
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
	function dbclick() {
		$(".aname").dblclick(function() {
			var data = this.lang.split(",");
			var id = data[0];
			var name = data[1];
			//alert(id);
			//alert(name);
			layer.open({
				type : 2,
				title : '设置小助手',
				area : [ '600px', '361px' ],
				// closeBtn: 0, //不显示关闭按钮
				shift : 1,
				shade : 0.5, //开启遮罩关闭
				content : '${pageContext.request.contextPath}/admin/clueexpassistantselect.jsp?id='
						+ id + '&name=' + name,
				end : function() {
					getData(assistant, 1, "");
				}
			});
		});
	}

	//添加点击事件
	function addclick() {
		$("#add").unbind("click").click(function() {
			layer.open({
				type : 2,
				title : '添加线索人物',
				area : [ '380px', '500px' ],
				shift : 1,
				shade : 0.5, //开启遮罩关闭
				content : '${pageContext.request.contextPath}/clue/add.jsp'
			});
		})
	}
	//查看全部
	function showall() {
		$("#search-all").click(function() {
			$(".wrap").load("${pageContext.request.contextPath}/admin/clueManagement.jsp");
		});
	}
	//添加修改事件
	function modifyclick() {
		$(".modify").click(function() {
			var id = this.lang;
			layer.open({
				type : 2,
				title : '修改',
				area : [ '380px', '500px' ],
				shift : 1,
				shade : 0.5,
				content : '${pageContext.request.contextPath}/clue/modify.jsp?id='
						+ id,
				end : function() {
					if (flag != "") {
						getAssistantByAid(flag);
					} else {
						getData(assistant ,1 ,"" );
					}
				}
			});
		});
	}
	//删除点击事件
	function deleteclick() {
		$(".delete").click(function() {
			var id = this.lang;
			layer.confirm('您确定要删除该用户吗?删除该用户时，同时也会删除该用户的基本信息和信用信息，请谨慎操作！', {
				btn : [ '是', '否' ]
			}, function() {
				$.post("${pageContext.request.contextPath}/clue/deleteById.action", {
					id : id
				}, function(data) {
					layer.closeAll('dialog');
					if (flag != "") {
						getAssistantByAid(flag);
					} else {
						getData(assistant ,1 ,"" );
					}
				});
			});
		});
	}
	//备注鼠标悬停事件
	function memoOn() {
		$(".memo").mouseover(function() {
			var id = "#" + this.id;
			layer.tips('只想提示地精准些', id, {
				time : 1000
			});
		});
	}
	//查看沟通信息点击事件
	function lookCommunicationclick() {
		$(".lookCommunication").click(
			function() {
				var data = this.lang.split(",");
				var id = data[0];
				var name = data[1];
				layer.open({
					type : 2,
					title : '查看沟通信息',
					area : [ '780px', '550px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/clue/lookcommunication.jsp?id='
							+ id + '&name=' + name,
					end : function() {
						if (flag != "") {
							getAssistantByAid(flag);
						} else {
							getData(assistant ,1 ,"" );
						}
					}
				});
			});
	}
	//添加沟通信息点击事件
	function addCommunicationclick() {
		$(".addCommunication").click(
			function() {
				var data = this.lang.split(",");
				var id = data[0];
				var name = data[1];
				layer.open({
					type : 2,
					title : '添加沟通信息',
					area : [ '810px', '550px' ],
					shift : 1,
					shade : 0.5, //开启遮罩关闭
					content : '${pageContext.request.contextPath}/clue/addcommunication.jsp?id='
							+ id + '&name=' + name,
					end : function() {
						if (flag != "") {
							getAssistantByAid(flag);
						} else {
							getData(assistant ,1 ,"" );
						}
					}
				});
			});
	}
	//加入体验点击事件
	function joinclick() {
		$(".join").click(function() {
			var data = this.lang.split(",");
			var flag = 0;
			$.post("${pageContext.request.contextPath}/clue/checkattr.action", {
				id : data[0]
			}, function(data) {
				if (data == 0) {
					layer.msg("请完善资料后，再点击加入！", {
						icon : 0
					});
					flag = 1;
				}
			});
			if (flag != 0) {
				return ;
			}
			if ('true' == data[3]) {
				layer.msg("该体验者已经添加过了!", {
					icon : 1
				});
				return ;
			}

			var id = data[0];
			var name = data[1];
			if (!confirm("确认添加【" + data[2] + "】" + "为体验会员吗？")) {
				return ;
			}
			$.post("${pageContext.request.contextPath}/clue/joinExperience.action", {
				id : id
			}, function(data) {
				if (flag != "") {
					getAssistantByAid(flag);
				} else {
					getData(assistant ,1 ,"" );
				}
			});
		});
	}
	//退出点击事件
	function leftclick() {
		$(".left").click(function() {
			var str = this.lang.split(",");
			var id = str[0];
			//alert(str[1]);
			if ('' != str[1]) {
				layer.msg("<b style='color:red;'>该线索已经变成体验者或已经体验过了！</b>", {
					icon : 5
				});
				return ;
			}
			$.post("${pageContext.request.contextPath}/clue/leftVIP.action", {
				id : id
			}, function(data) {
				if (flag != "") {
					getAssistantByAid(flag);
				} else {
					getData(assistant ,1 ,"" );
				}
			});
		});
	}
	//重置点击事件
	function resetclick() {
		$(".reset").click(function() {
			var id = this.lang;
			$.post("${pageContext.request.contextPath}/clue/resetVIPFlag.action", {
				id : id
			}, function(data) {
				getData(assistant ,1 ,"" );
			});
		});
	}

	//详细信息点击事件
	function msgclick() {
		$(".msg").click(function() {
			var x = $(this);
			$.post("${pageContext.request.contextPath}/user/getinfo.action?id=" + this.lang,
			function(data) {
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
	function drawTable(data) {
		
		var line = "<thead>";
		line += "<tr class='info'>";
		line += "<td>序号</td>";
		line += "<td>用户名</td>";
		line += "<td>QQ</td>";
		line += "<td>性别</td>";
		line += "<td>开始时间</td>";
		/* line += "<td>真实姓名</td>";
		line += "<td>毕业学校</td>";
		line += "<td>结束时间</td>";
		line += "<td>毕业时间</td>";
		line += "<td>手机号码</td>"; */
		line +="<td>沟通次数</td>";
		line += "<td>体验编号</td>";
		line += "<td>助教</td>";
		line += "<td>沟通信息</td>";
		line += "<td>操作</td>";
		line += "</tr>";
		line += "</thead>";
		line += "<tbody>";
		for (i = 0; i < data.length; i++) {
			var aname = "";
			if (data[i].admin != null) {
				aname = data[i].admin.realname;
			}
			var num = "";
			if (data[i].exnum != null) {
				num = data[i].exnum;
			}
			var count="0";
			if(data[i].counts!=null){
				count = data[i].counts;
			}
			var etime = "";
			if (data[i].etime != null) {
				etime = new Date(data[i].etime).pattern("yyyy-MM-dd");
				if (data[i].flag) {
					//加入experience，用绿色
					line += "<tr class='success'>";
				} else {
					//退出experience，用红色
					line += "<tr class='danger'>";
				}
			} else {
				line += "<tr>"
			}

			line += "<td>" + (i + 1) + "</td>";
			line += "<td>" + data[i].num + "</td>";
			line += "<td><span style=\"text-decoration:underline\"><a href='tencent://message/?uin="+data[i].qq+"&Site=&Menu=yes'>" + data[i].qq + "</a></span></td>";
			line += "<td>" + data[i].sex + "</td>";
			line += "<td>" + new Date(data[i].btime).pattern("yyyy-MM-dd") + "</td>";
			/* line += "<td class='einfo' lang='" + data[i].id + "'>"
					+ ((!data[i].realName) ? "" : data[i].realName)
					+ "</td>";
			line += "<td style='text-align:left;'>" + ((!data[i].school) ? "" : data[i].school) + "</td>";
			line += "<td>" + etime + "</td>";
			line += "<td>" + ((!data[i].graduateDate) ? "" : new Date(data[i].graduateDate).pattern("yyyy-MM-dd")) + "</td>";
			line += "<td>" + ((!data[i].phone) ? "" : data[i].phone) + "</td>"; */
			line +="<td>"+count+"次"+"</td>";
			line += "<td>" + num + "</td>";
			line += "<td class='aname' lang='"+data[i].id+","+data[i].qq+"'>" + aname + "</td>";
			line += "<td class='memo' id='memo" + (i + 1) + "'>";
			line += "<a herf='#' title='添加' style='text-decoration:none' class='addCommunication' lang='" + data[i].id + "," + data[i].qq +"'>添加" + "</a>|";
			line += "<a herf='#' title='查看' style='text-decoration:none' class='lookCommunication' lang='" + data[i].id + "," + data[i].qq +"'>查看" + "</a>";
			line += "</td>";
			line += "<td>";
			line += "<a herf='#' title='加入' style='text-decoration:none' class='join' lang='"+ data[i].id + "," + data[i].realName + "," + data[i].qq +","+data[i].flag+"'>加入" + "</a>|";
			line += "<a herf='#' title='退出' style='text-decoration:none' class='left' lang='"+ data[i].id + "," + etime +"'>退出" + "</a>|";
			line += "<a herf='#' title='修改' style='text-decoration:none' class='modify' lang='"+data[i].id+"'><i class='fa fa-pencil' aria-hidden='true'></i></a>|";
			line += "<a herf='#' title='删除' style='text-decoration:none' class='delete' lang='"+data[i].id+"'><i class='fa fa-trash-o' aria-hidden='true'></i></a>";
			line += "</td>";
			line += "</tr>";
		}
		line += "</tbody>"; 
		$("#clue").html(line);
	}
	//通过QQ号查询
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
			$(".btn").removeClass("active");
			getData(0, 1, qq);
		}
	}); 
</script>
</head>
<body>
	<div class="panel panel-secondary">
		<div class="panel-header">
			<div style="float: left;">
				<button class="btn btn-success" id="add">
					<i class="fa fa-plus" aria-hidden="true"></i> 添加跟踪者
				</button>
			</div>
			<div class="btn-group" style="float: left">
				<button type="button" class="btn btn-primary radius active butname"
					lang="0">所有人</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="22">闽光磊</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="36">王炜强</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="37">曾小晨</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="32">刘文启</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="54">陈家豪</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="41">张晓敏</button>
			</div>
			<div class="form-group">
				<input id="qq" type="text" placeholder="QQ号" style="width: 100px"
					class="input-text radius" />
				<button id="qqsearch" class="btn btn-success" type="button">
					<i class="fa fa-search" aria-hidden="true"></i> QQ号模糊查询
				</button>
			</div>
			<div class="btn-group" style="float: right">
				<button type="button" class="btn btn-primary radius" id="download">生成表格</button>
				<button type="button" class="btn btn-primary radius" id="dl">点击下载</button>
			</div>
		</div>
		<!-- panel-primary    -->
		<!-- table table-border table-bg table-bordered table-hover radius -->
		<div class="container-fluid">
				<div class="row">
					<table id="clue" class="table table-border table-bg table-bordered radius"></table>
				</div>
		</div>
	</div>
	<div class="page-nav" style="float: right; margin-top: 10px;"
		id="paging"></div>
</body>
</html>