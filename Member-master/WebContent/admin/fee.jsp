<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>费用管理-Java互助学习VIP群业务运行系统</title>
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
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/user/getUserByPage.action",{type:4,page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
			clickRows();
			getlastacountdate();
			apishow();
			dldoc();
			initInstalment();
		})
		
	}	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	//提取每个会员的最后缴费日期
	function getlastacountdate(){
		$(".lastacountdate").each(function(){
			//通过juery动态写的表格获取不到this到底是哪个标签，所以$(this).html不好使，只能通过序号来确定
			var data=this.lang.split(",");
			var mid=data[0];
			var spanid=data[1];
			$.post("${pageContext.request.contextPath}/member/getLastAmountDateByMid.action",{mid:mid},function(date){
				if(date!=null){
					$("#span"+spanid).html(date);
				}
			});
			
		})
	}
	//显示API信息
	function apishow(){
		$(".show").click(function(){
			var langs=this.lang.split(",");
			var index=layer.open({
			    type: 2,
			    title:langs[1] + '  详细费用信息',
			    area: ['800px', '500px'],
			    skin: 'layui-layer-rim',
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath}/member/show.action?id=' + langs[0]
			});	
		});
	}
	function dldoc(){
		$(".dlDOC").click(function(){
			$.post("${pageContext.request.contextPath}/user/dlWord.action",{"id":this.lang},function(url){
				if(url!=null){
					location.href=url;
				}
			});
		});
	}
	function initInstalment() {
		$(".initInstalment").click(function(){
			var parm = this.lang.split("&");
			var str = "<span style='color:red'>你确定要将【<strong>" + parm[1] + "</strong>】的分期信息重置？</span>"
			layer.confirm(str, {
				  btn: ['确定','取消'] //按钮
				}, function(){
					layer.closeAll();
					layer.open({
						type: 2,
						title: '付费方式',
						area: ['700px', '500px'],
						shift: 1,
						shade: 0.5, //开启遮罩关闭
						content: '${pageContext.request.contextPath}/admin/periodchoice.jsp?id=' + parm[0],
						end: function(){
							getData(page2);
						}
					});
				});
		});
	}
	
	function drawTable(data){
		var line="";
		for(i=0;i<data.length;i++){
				//有未审核的费用
				if(data[i].member.alog>0){
					line += "<tr class='rows success'>";
				}else
				//已缴清本金且剩余利息大于等于0
				if(data[i].member.fee==1 && data[i].member.restInterest>=0){
					line += "<tr class='rows active'>";
				}else
				//已缴清本金且剩余利息小于0
				if(data[i].member.fee==1 && data[i].member.restInterest<0){
					line += "<tr class='rows warning'>";
				}
				else{
					line += "<tr class='rows'>"
				}
				line += "<td>" + data[i].name+ "</td>";
				line += "<td class='nowrap'>" + data[i].member.name + "</td>";
				line += "<td>" + data[i].member.school + "</td>";
				line += "<td class='nowrap'>" + data[i].member.mobile + "</td>";
				line +=  "<td>" + data[i].member.restAmount + "</td>";
				line +=  "<td>" + data[i].member.restInterest + "</td>";	
				line +=  "<td class='lastacountdate' lang='"+data[i].member.id+","+(i+1)+"'>" +"<span id='span"+(i+1)+"'></span>"+ "</td>";
				if(data[i].admin!=null){
					line += "<td>" + data[i].admin.realname + "</td>";
				}else{
					line += "<td></td>";
				}
				line=line + "<td><a href='javascript:void(0)' class='show' lang=" + data[i].id + "," + data[i].member.name + ">API</a></td>"
				line=line + "<td><a href='${pageContext.request.contextPath}/admin/feedetail.jsp?id="+data[i].member.id+"' target='_blank'>审核</a></td>";
				line=line + "<td><a href='javascript:void(0)' class='dlDOC' lang=" + data[i].id + ">下载</a></td>";
				line=line + "<td><a href='javascript:void(0)' class='initInstalment' lang='" + data[i].member.id + "&" + data[i].member.name +"'>初始化</a></td>";
				line=line + "</tr>";
		}
		$("#tbody").html(line);
	}	
});

</script>

</head>
<body>
	<c:if test="${ADMIN==null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<h1 class="text-c">VIP会员费用管理</h1>
	<div class="mt-20">
		<table class="table table-border table-bg table-bordered radius" id="period">
			
		</table>	
	</div>
	<br>
	<div class="panel panel-secondary">
		<!-- <div class="panel-header"></div> -->
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>编号</th>
						<th>姓名</th>
						<th>校名</th>
						<th>电话</th>
						<th>剩余本金</th>
						<th>剩余利息</th>
						<th>最后缴费</th>
						<th>小助手</th>
						<th>信息</th>
						<th>交费</th>
						<th>协议</th>
						<th>初始化</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>