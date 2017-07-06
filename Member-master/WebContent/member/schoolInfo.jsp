<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>会员进度-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript">
$(function() {
	var page2=1;
	getData(page2);
	function getData(page2) {
		var list;
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/member/getAllSchoolByPage.action",{page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount = dataObj.returnMap.totalCount;
			list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			$("#num").html(tatolCount);
			drawTable(list);
			btnclick();
			detailclick();
		});
	}
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	//详情点击事件
	function detailclick(){
		$(".detail").click(function(){
			var school=this.lang;
			layer.open({
				  type: 2,
				  title: '查看周报',
				  area: ['800px', '600px'],
				 // closeBtn: 0, //不显示关闭按钮
				  shift: 1,
				  maxmin: true,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/member/schooldetail.jsp?school='+school,
				  end: function(){
					  getData(page2);
				    }
			});
		})
	}
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th class='xh'>序号</th>";
		line=line + "<th class='xh'>学校名称</th>";
		line=line + "<th class='yhm'>会员人数</th>";
		line=line + "<th class='xm'>详情</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){	
			var count;
			$.post("${pageContext.request.contextPath}/member/getSchoolMemberCount.action",{school:data[i]},function(data1){
				count=data1;
			});
			line=line + "<tr class='text-c'>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + data[i] + "</td>";			
			line=line + "<td>" + count + "</td>";
			line=line + "<td>" + "<a class='detail' href='javascript:;' lang='"+data[i]+"'title='详情'>详情</a>" + "</td>";
			line=line + "</tr>";
				
		}
		line=line + "</tbody>";
		$("#school").html(line);
	}
});
</script>
<style type="text/css">
</style>
</head>
<body>
	<h1 style="text-align:center">学校信息</h1>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="r">共有数据：<strong id="num"></strong> 条</span> 
		</div>
		<div class="mt-20">
			<table class="table table-border table-bordered table-bg table-hover table-sort" id="school">
		</table>
		</div>
	</div>
	<div style="clear:both"></div>
	<div class='page-nav' style="margin-top:20px;padding-right:120px"></div>
	
</body>
</html>