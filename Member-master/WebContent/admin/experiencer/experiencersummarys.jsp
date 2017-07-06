<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看周报</title>
<link  href="${pageContext.request.contextPath}/resources/images/Icon.ico"
	   rel="shortcut icon" />
<link  href="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/css/bootstrap.css"
       rel="stylesheet" type="text/css">
<link  href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.css"
	   rel="stylesheet" type="text/css"/>
<link  href="${pageContext.request.contextPath}/resources/images/icon/H~ui_ICON_1.0.8/iconfont.css"
	   rel="stylesheet" type="text/css"/>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript" 
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>   
<script type="text/javascript">
	$(function() {
	
		var page;
		var name = ${param.name};
	
		getData(page, name);
		function getData(page, name) {
			$.ajaxSetup({
				async : false
			});
			$
					.post(
							"${pageContext.request.contextPath}/summary/getExperienceSummary.action",
							{
								
								page : page,
								name : name
							}, function(data) {
								 if(data.status!=100){
									layer.msg(data.msg);
									return;
								} 
								var dataObj = eval("(" + data.data + ")");
								var navbar = dataObj.returnMap.navbar;
								var tatolCount = dataObj.returnMap.totalCount;
								var list = dataObj.returnMap.list;	
								$(".page-nav").html(navbar);
								btnclick();
								$("#TATOLCOUNT").html(tatolCount);							
								drawTable(list);	
								trclick();
								titclick();
							})

		}
		
		function btnclick() {
			$(".nav-btn").click(function() {
				page = this.lang;
				getData(page, name);
			})
		}
		//查看周报	
		function showSum(sid) {
			//location.href="${pageContext.request.contextPath}/summary/membersumcomment1.jsp?page="+page+"&ownerType="+ownerType+"&checkType="+checkType+"&weekType="+weekType+"&title="+title+"&id="+id;
			//window.open("${pageContext.request.contextPath}/summary/membersumcomment1.jsp?id="+id);
			layer
					.open({
						type : 2,
						title : '查看周报',
						area : [ '800px', '500px' ],
						// closeBtn: 0, //不显示关闭按钮
						shift : 1,
						shade : 0.5, //开启遮罩关闭
						content : '${pageContext.request.contextPath}/summary/membersumcomment1.jsp?id='
								+ sid,
						end : function() {
							getData(
									page, name);
						}
					});
		}

		function titclick() {
			$(".tit").click(function() {
				var id = this.lang;
				showSum(id);
			})
		}

		function trclick() {
			//火狐对last不支持，在不该被点的td里面机上noclick的class
			//$("tr td:not(':first,:last')").click(function(){
			$("tr td:not(.noclick)").click(function() {
				var id = this.parentNode.lang;
				showSum(id);
			})
		}
		
		function drawTable(data) {
			var line = "<thead>";
			line += "<tr class='info'>";
			line += "<th width='25'><input type='checkbox' name='' value=''></th>";	
			line += "<th width='80'>序号</th>";
			line += "<th width='80'>姓名</th>";
			line += "<th width='180'>周报</th>";
			line += "<th width='150'>提交时间</th>";
			line += "<th width='150'>身份</th>";
			line += "<th width='80'>小助手</th>";
			line += "<th width='60'>状态</th>";
			line += "<th width='150'>操作</th>";
			line += "</tr>";
			line += "</thead>";
			line += "<tbody>";
			for (i = 0; i < data.length; i++) {
				line += "<tr class='text-c tr' lang='"+data[i].sid+"'>";
				line += "<td class='noclick'>"
						+ "<input type='checkbox' name='' value=''>" + "</td>";
				line += "<td>" + (i + 1) + "</td>";
				line += "<td>" + data[i].name + "</td>";
				line += "<td>" + data[i].title + "</td>";
				line += "<td>" + data[i].time + "</td>";
				if(data[i].identityType=='1')
				{
					line += "<td>会员</td>";	
				}
				else
				{
					line += "<td>体验者</td>";	
				}
				line += "<td>" + data[i].arealname+ "</td>";
				line += "<td class='td-status'>";
				if (data[i].ischeckval == '0') {
					line +=  "<span class='label label-danger radius'>未审核</span>";		
				} else {
					line += "<span class='label label-success radius'>已审核</span>";						
				}
				line += "</td>";
				line += "<td class='noclick'><a href='#' class='tit' lang='"+data[i].sid+"'>查看</a></td>";
				line += "</tr>";

			}
			line = line + "</tbody>";
			$("#period").html(line);
		}

	});
</script>
</head>
<body>

	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title">
		<span
			class="r">共有数据：<strong id="TATOLCOUNT"></strong> 条
		</span>
	</div>
	<div class="mt-20">
		<table
			class="table table-border table-bordered table-bg table-hover table-sort"
			id="period">
		</table>
	</div>
	<br>
	<div class='page-nav' style="margin-right: 4%;"></div>
	

</body>
</html>