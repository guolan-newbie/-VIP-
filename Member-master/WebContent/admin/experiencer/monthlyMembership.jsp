<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户审核-Java互助学习VIP群业务运行系统</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<link 
	href="${pageContext.request.contextPath}/css/jquery.monthpicker.css" 
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery.monthpicker.js" ></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
$(function(){
	var time = new Date();
	var month=time.getMonth()+1;
	var years=time.getFullYear(); 
	var page = 1;
	$.ajaxSetup({async:false});

	getDate(years,month,page);
	$('#monthpicker').monthpicker({
        years: [2014,2015,2016, 2017, 2018, 2019, 2020],
        topOffset: 6,
        onMonthSelect: function(m, y) {
          //console.log('Month: ' + m + ', year: ' + y);
          month=m+1;
          years=y;
          //alert(month+":"+years);
          getDate(years,month,page);
        }
    });
	
	
	function getDate(years,month,page){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/experience/getMemberByMonth.action",{years:years,month:month,page:page},function(data){
			drawTable(data.data);
			$("#paging").html(showpage(data.page, data.count));
			btnPage();
			//selectByTime();
		})
	}
	
	/* 翻页*/
	function btnPage() {
		$(".nav-btn").click(function() {
			getDate(years,month,this.lang);
		});
	}
	 
	function drawTable(data){
		if(data.length == 0) {
			layer.msg("没有数据", {
				icon : 0
			});
			$("#tbody").html("");
			return ;
		}
		var line = "";
		//alert(data.length);
		for(i=0;i<data.length;i++){
			var student="在职"
			if(data[i].school!=null){
				student=data[i].school;
			}
			var aname="";
			if(data[i].admin!=null){
				aname=data[i].admin.realname;
			}
			var membernum="";
			if(data[i].user!=null){
				membernum=data[i].user.name;
			}
			var amount="暂无";
			var restAmount="暂无";
			if(data[i].period!=null){
				amount=data[i].period.amount;
				restAmount=data[i].period.restAmount;
			}
			var joinTime="";
			if(data[i].time!=null){
				joinTime=data[i].time;
			}
			line += "<tr class='rows'>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td>" + membernum + "</td>";
			line=line + "<td class='einfo' lang='" + data[i].id + "'>" + data[i].name + "</td>";
			//line += "<td><span style='text-decoration:underline'><a href='tencent://message/?uin="+data[i].qq+"&Site=&Menu=yes'>" +isBlank(data[i].qq) + "</a></span></td>";
			line=line+"<td>"+data[i].sex+"</td>";
			line=line + "<td>" + student +  "</td>";	
			line=line + "<td>" + datePattern(joinTime) + "</td>";
			line=line + "<td>" + aname + "</td>";
			line=line + "<td>" + amount + "</td>";
			line=line + "<td>" + restAmount + "</td>";
			line=line + "</tr>";
		}
		$("#tbody").html(line);
	}
})
</script>
</head>
<body>
<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
</c:if>		
	<div >
		<div ></div>
		<div ></div>
	</div>
	<div align="center" >
	<h3>月入会员</h3>
	<p>年月份选择：<a href="#monthpicker" id="monthpicker"></a></p>
	</div>
	<div class="panel-primary">
		<table class="table table-border table-bg table-bordered radius">
			<thead class="text-c">
				<tr>
					<th>序号</th>
					<th>会员编号</th>
					<th>真实姓名</th>
					<th>性别</th>
					<th>学校</th>
					<th>加入时间</th>
					<th>助教</th>
					<th>首付</th>
					<td>月供</td>
				</tr>
			</thead>
			<tbody id="tbody" class='text-c'></tbody>
		</table>
	</div>
	<div class="page-nav" style="float: right; margin-top: 10px;" id="paging"></div>
</body>
</html>