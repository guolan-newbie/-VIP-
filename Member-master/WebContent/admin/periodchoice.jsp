<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>费用分期选择-Java互助学习VIP群业务运行系统</title>
<style type="text/css">
#tabs a:hover, #tabs a.here {
    color: #FFF;
    font-weight: bold;
    background-position: 0px -32px;
}
#tabs a{
    float: left;
    height: 32px;
    margin-right: -1px;
    padding: 0px 16px;
    line-height: 32px;
    font-size: 14px;
    font-weight: normal;
    border: 1px solid #C5C5C5;
    background: url('/Member/images/bg_ch.gif') repeat-x scroll 0% 0% transparent;
}
#tabs a {
    color: #06C;
    text-decoration: none;
}
#title,#tab,#perpiodtb{margin: 10px;float:left;clear:both;}
#main{margin: 10px;}
#btn{margin: 0 0 20px 50px;}
#saveit
{
width: 140px;  
line-height: 28px;  
text-align: center;  
font-weight: bold;  
color: #000;    
border-radius: 5px;  
margin:0 0 0 0; 
overflow: hidden;  
}
</style>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>

<script type="text/javascript">
$(function(){
	tab1click();
	//初始化计算按钮
	$("#calculator").click(function(){
		tab1click();
	});
	var index;
	
	//初始化保存按钮
	$("#saveit").click(function(){
		var id=${param.id};
		var totalamount=$("#totalamount").val();
		var firstamount=$("#firstamount").val();
		var monthpay=$("#monthpay").val();
		var interest=$("#interest").val();
		
		index = layer.load(2);
		
		$.post("${pageContext.request.contextPath}/member/getNewPeriod.action",{id:id,totalamount:totalamount,firstamount:firstamount,monthpay:monthpay,interest:interest,status:true},function(data){
			
			layer.closeAll();
			
			if(data.status==true)
			{
				layer.msg('分期信息保存成功！', {
				    icon: 1,
				    time: 1000
				});
			}
			else{
				layer.confirm('该用户分期信息已经存在，是否对其进行清除？',{btn:['是','否']},function(){
					index = layer.load(2);
					$.post("${pageContext.request.contextPath}/member/deletePeriodById.action",{id:id},function(data){
						layer.closeAll();
						if(data=="OK"){
							layer.msg('分期信息清除成功！', {
							    icon: 1,
							    time: 1000
							});
						}else{
							layer.msg('分期信息清除失败！', {
							    icon: 1,
							    time: 1000
							});
						}
					});
				});
			}
		});
	});
	//初始化分期按钮
	var tObj;
	$("#tabs a").each(function(){
		if($(this).attr("class").indexOf("here") == 0){tObj = $(this)}
		$(this).click(function(){
			var c = $(this).attr("class");
			if(c.indexOf("here") == 0){return;}
			var ref = $(this).attr("ref");
			var ref_t = tObj.attr("ref");
			tObj.attr("class","nor");
			$(this).attr("class","here");
			tObj = $(this);
			if(ref == '#tab1'){
				$("#hide").hide();
				tab1click();
				$("#saveit").unbind('click').click(function(){
					var id=${param.id};
					var totalamount=$("#totalamount").val();
					var firstamount=$("#firstamount").val();
					var monthpay=$("#monthpay").val();
					var interest=$("#interest").val();
					
					index = layer.load(2);
 					$.post("${pageContext.request.contextPath}/member/getNewPeriod.action",{id:id,totalamount:totalamount,firstamount:firstamount,monthpay:monthpay,interest:interest,status:true},function(data){
 						layer.closeAll();
						if(data.status==true)
						{
							layer.msg('分期信息保存成功！', {
							    icon: 1,
							    time: 1000
							});
						}
						else{
							layer.confirm('该用户分期信息已经存在，是否对其进行清除？',{btn:['是','否']},function(){
								index = layer.load(2);
								$.post("${pageContext.request.contextPath}/member/deletePeriodById.action",{id:id},function(data){
									layer.closeAll();
									if(data=="OK"){
										layer.msg('分期信息清除成功！', {
									    icon: 1,
									    time: 1000
										});
										setTimeout("parent.location.reload()", 1000 * 1);
									}else{
										layer.msg('分期信息清除失败！', {
										    icon: 1,
										    time: 1000
										});
									}
								});
							});
						}
					});
				});
			}
			if(ref == '#tab2'){
				var id=${param.id};
				$("#hide").hide();
				tab2click();
				$("#saveit").unbind('click').click(function(){
					index = layer.load(2);
					$.post("${pageContext.request.contextPath}/member/savePeriod.action",{id:id},function(data){
						layer.closeAll();
						if(data=="OK"){
							layer.msg('分期信息保存成功!', {
							    icon: 1,
							    time: 1000
							});
							setTimeout("parent.location.reload()", 1000 * 1);
						}
						else{
							layer.confirm('该用户分期信息已经存在，是否对其进行清除？',{btn:['是','否']},function(){
								index = layer.load(2);
								$.post("${pageContext.request.contextPath}/member/deletePeriodById.action",{id:id},function(data){
									layer.closeAll();
									if(data=="OK"){
										layer.msg('分期信息清除成功！', {
										    icon: 1,
										    time: 1000
										});
										setTimeout("parent.location.reload()", 1000 * 1);
									}else{
										layer.msg('分期信息清除失败！', {
										    icon: 1,
										    time: 1000
										});
									}
								});
							});
						}
					});
				});
			}
			if(ref == '#tab3'){
				var id=${param.id};
				$("#hide").hide();
				tab3click();
				$("#saveit").unbind('click').click(function(){
					index = layer.load(2);
					$.post("${pageContext.request.contextPath}/member/getAllAmountPeriod.action", {id:id});
					$.post("${pageContext.request.contextPath}/member/getAllAmountPeriod.action",{id:id,status:true},function(data){
						layer.closeAll();
						if(data.status==true)
						{
							layer.msg('分期信息保存成功!', {
							    icon: 1,
							    time: 1000
							});
							setTimeout("parent.location.reload()", 1000 * 1);
						}
						else{
							layer.confirm('该用户分期信息已经存在，是否对其进行清除？',{btn:['是','否']},function(){
								index = layer.load(2);
								$.post("${pageContext.request.contextPath}/member/deletePeriodById.action",{id:id},function(data){
									layer.closeAll();
									if(data=="OK"){
										layer.msg('分期信息清除成功！', {
										    icon: 1,
										    time: 1000
										});
									}else{
										layer.msg('分期信息清除失败！', {
										    icon: 1,
										    time: 1000
										});
									}
								});
							});
						}
					});
				});
			}
			if(ref == '#tab4') {
				var id=${param.id};
				$("#perpiodtb").html("");
				$("#period").html("");
				$("#hide").show();
				$("#saveit").unbind('click').click(function(){
					var xmlfile = $("#xmlfile").val();
					if(xmlfile == "" || xmlfile == null) {
						$("#xmlinfo").html("没有选择文件！");
						return ;
					}
					if(xmlfile.substr(xmlfile.indexOf(".")) != ".xls" ) {
						$("#xmlinfo").html("文件格式不正确，必须是.xls结尾");
						return ;
					}
					var fd = new FormData();
					fd.append("file",$("#xmlfile")[0].files[0]);
					fd.append("mid",id);
					index = layer.load(2);
					$.ajax({
						url : '${pageContext.request.contextPath}/member/setcustomPay.action',
						type : 'POST',
						data : fd,
						async : false,
						cache : false,
						contentType : false,
						processData : false,
						success : function() {
							layer.msg("成功通过审核，3秒后将自动刷新页面！", {icon: 1});
							setTimeout("parent.location.reload()", 1000 * 3);
						},
						error : function() {
							layer.msg("<strong style='color:red;'>文件数据有问题！！！请在页面自动刷新后重试</strong>", {icon: 2});
							setTimeout("parent.location.reload()", 1000 * 3);
						}
					});
				});
			}
		});
	});
});
function tab1click(){
	$("#perpiodtb").show();
	
	var id=${param.id};
	var totalamount=$("#totalamount").val();
	var firstamount=$("#firstamount").val();
	var monthpay=$("#monthpay").val();
	var interest=$("#interest").val();
	$.post("${pageContext.request.contextPath}/member/getNewPeriod.action",{id:id,totalamount:totalamount,firstamount:firstamount,monthpay:monthpay,interest:interest,status:false},function(data){
		$("#name").html(data.member.name);
		if(data.member.student=="true"){
			$("#studentType").html("学生");				
		}else{
			$("#studentType").html("工作");	
		}
		$("#registerTime").html(data.member.formatTime);
		drawTable(data.periods);
		$("#amount").val(changeTwoDecimal_f(data.amount));
		$("#interests").val(changeTwoDecimal_f(data.interests));
	});
}

function tab2click(){
	$("#perpiodtb").hide();
	
	var id=${param.id};
	$.post("${pageContext.request.contextPath}/member/getPeriod.action",{id:id},function(data){
		drawTableOld(data);
	},"json");
}

function tab3click(){
	$("#perpiodtb").hide();
	
	var id=${param.id};
	$.post("${pageContext.request.contextPath}/member/getAllAmountPeriod.action",{id:id,status:false},function(data){
		drawTableOld(data.periods);
	});
}

function drawTable(data){
	$("#period").html("");
	var line="";
	line=line + "<tr class='text-c'>";
	line=line + "<td>序号</td>";
	line=line + "<td>交费日期</td>";
	line=line + "<td>交费金额</td>";	
	line=line + "<td>利息</td>";	
	line=line + "<td>本金</td>";	
	line=line + "<td>剩余本息合计</td>";	
	line=line + "</tr>";
	for(i=0;i<data.length;i++){
		line=line + "<tr class='text-c'>";			
		line=line + "<td>" + (i+1) + "</td>";
		
		var d =	new Date();
		d.setTime(data[i].duetime);
		var s=d.format('yyyy-MM-dd');
		
		var mamount=changeTwoDecimal_f(data[i].amount)-changeTwoDecimal_f(data[i].minterest);
		
		line=line + "<td>" + s + "</td>";
		line=line + "<td>" + changeTwoDecimal_f(data[i].amount) + "</td>";
		line=line + "<td>" + changeTwoDecimal_f(data[i].minterest) + "</td>";
		line=line + "<td>" + changeTwoDecimal_f(mamount) + "</td>";
		line=line + "<td>" + changeTwoDecimal_f(data[i].total) + "</td>";
		line=line + "</tr>";		
	}
	$("#period").append(line);
}

function drawTableOld(data){
	$("#period").html("");
	var line="";
	line=line + "<tr class='text-c'>";
	line=line + "<td>序号</td>";
	line=line + "<td>交费日期</td>";
	line=line + "<td>交费金额</td>";	
	line=line + "</tr>";
	for(i=0;i<data.length;i++){
		line=line + "<tr class='text-c'>";			
		line=line + "<td>" + (i+1) + "</td>";
		
		var d=	new Date();
		d.setTime(data[i].duetime);
		var s=d.format('yyyy-MM-dd');
		
		line=line + "<td>" + s + "</td>";
		line=line + "<td>" + data[i].amount + "</td>";
		line=line + "</tr>";		
	}
	$("#period").append(line);
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
</script>
</head>
<body>
<div id="tab"><span id="tabs">
<a href="javascript:void(0);" ref="#tab1" class="here">新分期</a>
<a href="javascript:void(0);" ref="#tab2" class="nor">旧分期</a>
<a href="javascript:void(0);" ref="#tab3" class="nor">全费</a>
<a href="javascript:void(0);" ref="#tab4" class="custom">自定义</a>
</span></div>
<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
</c:if>
<br/>
<div id="title">
姓名：<span id="name"></span>&nbsp;&nbsp;&nbsp;&nbsp;
类型：<span id="studentType"></span>&nbsp;&nbsp;&nbsp;&nbsp;
注册日期:<span id="registerTime"></span>
</div>
<br/>
<div id="perpiodtb">
<table>
<tr>
	<td>本金合计：<input type="text" id="totalamount" value="8000" style="width:60px;"/></td>
	<td>首付：<input type="text" id="firstamount" value="1500" style="width:60px;"/></td>
	<td>月利率：<input type="text" id="interest" value="0.02" style="width:60px;"/></td>
	<td>月供：<input type="text" id="monthpay" value="500" style="width:60px;"/></td>
	<td><input type="button" id="calculator" value="显示还款详单"></td>
</tr>
<tr>
	<td>实交合计：<input type="text" id="amount" readonly style="width:60px;"/></td>
	<td>利息合计：<input type="text" id="interests" readonly style="width:60px;"/></td>
</tr>
</table>
</div>
<div id="main">
<table id="period" class="table table-border table-bordered table-bg table-hover table-sort"></table>
</div>
<div id="hide" hidden="hidden" class="container">
	<input type='file' id='xmlfile' accept='application/vnd.ms-excel'/><br />
	<div id='xmlinfo' style='color: red;'>注意上传文件必须是.xls结尾</div>
</div>
<br />
<br />
<div id="btn"><input type="button" id="saveit" value="通过审核"></div>
</body>
</html>