<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>交费信息-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">

$(function(){
	var pageNo=1;
	getData($("#mid").val(),pageNo);
	function getData(mid,pageNo){
		$.post("${pageContext.request.contextPath}/member/getMyAccount.action",{mid:mid,pageNo:pageNo},function(data){
			$.ajaxSetup({async:false});
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			var dates=dataObj.returnMap.dates;
			var totalAmount=dataObj.returnMap.totalAmount;
			$(".page-nav").html(navbar);
			$("#account").html("合计缴费：" + totalAmount);
			btnclick();
			drawTable(list,dates);
		},"json");
	}
	
	function drawTable(data,dates){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th width='60'>序号</th>";
		line=line + "<th width='120'>交费日期</th>";
		line=line + "<th width='60'>交费金额</th>";	
		line=line + "<th width='60'>状态</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		var account = 0;
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			if(data[i].flag){
				line=line + "<tr class='text-c'>";	
			}
			else{
				line=line + "<tr class='text-c'>";
			}
			line=line + "<td>" + (i+1) + "</td>";
			
			//var d=	new Date(data[i].date);
			//d.setTime(data[i].date);
			//var s=d.format('yyyy-MM-dd');
			//line=line + "<td>" + dates[i] + "</td>"
			line=line + "<td>" + new Date(data[i].date).pattern("yyyy-MM-dd") + "</td>"
			//line=line + "<td>" + new Date(data[i].p_duetime).pattern("yyyy-MM-dd") + "</td>";
			line=line + "<td>" + data[i].amount + "</td>";
			
			if(data[i].flag){
				line=line + "<td class='td-status'> <span class='label label-success radius'>" + "已审核" + "</span> </td>";
			}
			else{
				line=line + "<td class='td-status'> <span class='label label-danger radius'>" + "未审核" + "</span> </td>";
			}
			line=line + "</tr>";	
			account += data[i].amount;
		}
		line=line + "</tbody>";
		$("#period").html(line);
		//$("#account").html($("#account").html()+account);
		//$("#period").append(line);
	}
	//获取点击按钮(当前页数)
	function btnclick(){
		$(".nav-btn").click(function(){
			page1=this.lang;
			getData($("#mid").val(),page1);
		})
	}	
});

$(function(){
	var mid=$("#mid").val();
	var pageNo=1;
	getData(mid,pageNo);
	function getData(mid,pageNo){
		$.post("${pageContext.request.contextPath}/member/getMyPeriod.action",{mid:mid,pageNo:pageNo},function(data){
			$.ajaxSetup({async:false});
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			var totalAmount=dataObj.returnMap.totalAmount;
			$(".page-nav2").html(navbar);
			$("#account1").html("合计费用：" + totalAmount);
			btnclick();
			drawTable(list);
		},"json");
	}
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th>序号</th>";
		line=line + "<th>交费日期</th>";
		line=line + "<th>交费金额</th>";	
		line=line + "<th>剩余交费金额</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		var account = 0;
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			line=line + "<tr class='text-c'>";			
			line=line + "<td>" + (i+1) + "</td>";
			//var d=new Date(data[i].duetime + " GMT+8");
			//alert(data[i].duetime)
			//d.setTime(data[i].duetime);
			//var s=d.format('yyyy-MM-dd');
			//alert(s)
			
			line=line + "<td>" + new Date(data[i].duetime).pattern("yyyy-MM-dd") + "</td>";
			line=line + "<td>" + data[i].amount + "</td>";
			line=line + "<td>" + data[i].restAmount + "</td>";
			line=line + "</tr>";	
			account += data[i].amount;
		}
		line=line + "</tbody>";
		$("#period1").html(line);
		//$("#account1").html($("#account1").html()+account);
	}
	//获取点击按钮(当前页数)
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData($("#mid").val(),page2);
		})
	}	
});

$(function(){
	var pageNo=1;
	var mid=$("#mid").val();
	getData(mid,pageNo);
	function getData(mid,pageNo){
		$.post("${pageContext.request.contextPath}/member/getMyInterest.action",{mid:mid,pageNo:pageNo},function(data){
			$.ajaxSetup({async:false});
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			var totalAmount=dataObj.returnMap.totalAmount;
			$(".page-nav3").html(navbar);
			$("#account2").html("合计利息：" + changeTwoDecimal_f(totalAmount));
			btnclick();
			drawTable(list);
		},"json");
	}
	function drawTable(data){
		var line="";
		line=line + "<tr>";
		line=line + "<td>序号</td>";
		line=line + "<td>分期日期</td>";
		line=line + "<td>分期金额</td>";	
		line=line + "<td>缴费日期</td>";
		line=line + "<td>本次交费</td>";	
		line=line + "<td>本期冲抵</td>";
		line=line + "<td>利息金额</td>";
		line=line + "</tr>";
		var account = 0;
		for(i=0;i<data.length;i++){
			line=line + "<tr>";			
			line=line + "<td>" + (i+1) + "</td>";
			//alert(data[i].p_duetime);
			//var d1=	new Date(data[i].p_duetime + " GMT+8");
			//d1.setTime(data[i].p_duetime);
			//var s1=d1.format('yyyy-MM-dd');
			//alert(data[i].p_duetimee);
			line=line + "<td>" + new Date(data[i].p_duetime).pattern("yyyy-MM-dd") + "</td>";
			line=line + "<td>" + data[i].p_amount + "</td>";
			
			//var d2=	new Date(data[i].a_date + " GMT+8");
			//d2.setTime(data[i].a_date);
			//var s2=d2.format('yyyy-MM-dd');
			
			line=line + "<td>" + new Date(data[i].a_date).pattern("yyyy-MM-dd") + "</td>";
			line=line + "<td>" + data[i].a_amount + "</td>";
			line=line + "<td>" + data[i].i_money + "</td>";
			line=line + "<td>" + data[i].i_amount + "</td>";
			line=line + "</tr>";	
			account += data[i].i_amount;
		}
		$("#period2").html(line);
		//$("#account2").html($("#account2").html()+account.toFixed(2));
	}
	//获取点击按钮(当前页数)
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData($("#mid").val(),page2);
		})
	}	
	
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
});	

$(function(){
	$('#tab-title span').click(function(){
		$(this).addClass("selected").siblings().removeClass();//removeClass就是删除当前其他类；只有当前对象有addClass("selected")；siblings()意思就是当前对象的同级元素，removeClass就是删除；
		$("#tab-content > ul").hide().eq($('#tab-title span').index(this)).show();
		});
	});
</script>
 <style type="text/css">
	#account{margin-left:20px;display:inline;font-weight:bold}
	#account1{margin-left:20px;display:inline;font-weight:bold}
	#account2{margin-left:20px;display:inline;font-weight:bold}
	#sidebar-tab{border:1px solid #ccf;margin-bottom:1.5em;overflow:hidden;}
	#tab-title h3{color:#666;font-size:15px;font-weight:400;}
	#tab-title .selected{color:#356aa0;border-bottom:0px;} /*标题被选中时的样式*/
	#tab-title span{padding:5px 9px 5px 10px;border:1px solid #ccf;border-right:0px;margin-left:-1px;cursor:pointer;}
	#tab-content .hide{display:none;} /*默认让第一块内容显示，其余隐藏*/
	#tab-content ul{padding-bottom:500px;}
 	#tab-content ul li{padding-left:30px;padding-right:30px;height:20px;} 
</style>  
</head>
<body>
<br/>
<div id="sidebar-tab" style="height:800px">
<div id="tab-title">
<h4><span class="selected">交费信息</span><span>分期信息</span><span>利息信息</span></h4>
</div>
<div id="tab-content">
<ul><li><br/>
<div id="account" style="font-size:16px">合计缴费：</div>
		<p><table id="period" class="table table-border table-bordered table-bg table-hover table-sort">
		</table><div class='page-nav' style="margin-right:4%;"></div></p>
</li></ul>
<ul style="display:none;"><li><br/>
<div id="account1" style="font-size:16px">合计费用：</div>
		<p><table id="period1" class="table table-border table-bordered table-bg table-hover table-sort">
		</table><div class='page-nav2' style="margin-right:4%;"></div></p>
</li></ul>
<ul style="display:none;"><li>
<br/>
<div id="account2" style="font-size:16px">合计利息：</div>
	<p><table id="period2" class="table table-border table-bordered table-bg table-hover table-sort">
	</table><div class='page-nav3' style="margin-right:4%;"></div></p>
</li></ul>
</div>
</div>

<br/>
<br/>
	<%-- <input type="hidden" value="${myuser.member.id}" id="mid"> --%>
	<c:choose>
		<c:when test="${sessionScope.myuserinfo!=null}">
			<input type="hidden" value="${myuserinfo.member.id}" id="mid">
		</c:when>
		<c:otherwise> 
			<input type="hidden" value="${myuser.member.id}" id="mid">
		</c:otherwise>
	</c:choose>
<br/>


</body>
</html>