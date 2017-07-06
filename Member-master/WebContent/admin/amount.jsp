<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>费用详情-Java互助学习VIP群业务运行系统</title>	
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/datePicker/WdatePicker.js"></script>   
<style type="text/css">
.divshow{
  height:500px;
  width:90%;
  overflow-y:auto;
  margin-top:10px;
  }
</style>
<script type="text/javascript">

function createWdatePicker(){
	var type = $("#type").val();
	if (type == 1){
		WdatePicker({
			dateFmt:'yyyy-MM-dd',
			isShowClear:true,
		})
	}
	else if (type==2){
		WdatePicker({
			dateFmt:'yyyy-MM',
			isShowClear:true,
		})
	}
}
$(function(){
	function dayChange(date,days){
		var t =  new Date(Date.parse(date.replace(/-/g, "/")));
		var yesterday_milliseconds=t.getTime()+days*1000*60*60*24;
		var yesterday = new Date();
		yesterday.setTime(yesterday_milliseconds);
		var strYear = yesterday.getFullYear();
		var strDay = yesterday.getDate();
		var strMonth = yesterday.getMonth()+1;
		if(strMonth<10)
		{strMonth="0"+strMonth;}
		if(strDay<10)
		{strDay="0"+strDay}
		datastr = strYear+"-"+strMonth+"-"+strDay;
		return datastr;
	}
	function monthChange(date,months){
		var arr = date.split('-');  
        var year = arr[0]; //获取当前日期的年份  
        var month = arr[1]; //获取当前日期的月份  
        var day = 1; //获取当前日期的日  
        var days = new Date(year, month, 0);  
        days = days.getDate(); //获取当前日期中月的天数  
        var year2 = year;  
        var month2 = parseInt(month) + months;  
        if (month2 == 0) {  
            year2 = parseInt(year2) - 1;  
            month2 = 12;  
        }  
        if (month2 == 13) {  
            year2 = parseInt(year2) + 1;  
            month2 = 1;  
        }  
        var day2 = day;  
        var days2 = new Date(year2, month2, 0);  
        days2 = days2.getDate();  
        if (day2 > days2) {  
            day2 = days2;  
        }  
        if (month2 < 10) {  
            month2 = '0' + month2;  
        }  
        var t2 = year2 + '-' + month2;  
        return t2;
	}
	$("#prev").click(function(){
		var time = $.trim($("#time").val());
		var type = $.trim($("#type").val());
		if (time == ""){
			alert("请选择输入的日期或月份");
			return false;
		}
		if (type == 1){
			time = dayChange(time,-1);
			$("#time").val(time);
		}
		else if (type == 2){
			time = monthChange(time,-1);
			$("#time").val(time);
		}
	});
	$("#next").click(function(){
		var time = $.trim($("#time").val());
		var type = $.trim($("#type").val());
		if (type == 1){
			time = dayChange(time,1);
			$("#time").val(time);
		}
		else if (type == 2){
			time = monthChange(time,1);
			$("#time").val(time);
		}
	});
	$("#query").click(function(){
		var time = $.trim($("#time").val());
		var type = $.trim($("#type").val());
		var starttime = time;
		var endtime = time;
		if (type == 1){
			starttime += " 00:00:00";
			endtime += " 23:59:59";
		}
		else if (type == 2){
			starttime += "-01 00:00:00";
			endtime += "-31 23:59:59";
		}
		alert(starttime);
		alert(endtime);
		$.post("../member/getAmountDetail.action",{starttime:starttime,endtime:endtime,type:type},function(data){
			drawTable(data);
		});
	});
	function drawTable(data){
		var info_html="";
		info_html=info_html + "<tr>";
		info_html=info_html + "<td>序号</td>";
		info_html=info_html + "<td>会员编号</td>";
		info_html=info_html + "<td>会员姓名</td>";	
		info_html=info_html + "<td>应交金额</td>";	
		info_html=info_html + "<td>实交金额</td>";	
		info_html=info_html + "<td>协议日期</td>";	
		info_html=info_html + "<td>早交天数</td>";
		info_html=info_html + "</tr>";
		var account = 0;
		for (var i=0;i<data.Rows.length;i++){
			account += data.Rows[i].amount;
			var days = data.Rows[i].days;
			if (days > 0){
				info_html=info_html + "<tr class='early'>";	
			}
			else if (days < 0){
				info_html=info_html + "<tr class='late'>";	
			}
			else{
				info_html=info_html + "<tr>";		
			}	
			info_html=info_html + "<td>" + (i+1) + "</td>";
			info_html += "<td>"+data.Rows[i].uname+"</td><td>"+data.Rows[i].name+"</td>";
			 
			var d2=	new Date();
			if (data.Rows[i].days != null){
				d2.setTime(data.Rows[i].days);
				var s2=d2.format('yyyy-MM-dd');
			}
			
			 info_html += "<td>"+data.Rows[i].restAmount+"</td><td>"+data.Rows[i].amount+"</td><td>"+data.Rows[i].time+"</td><td>"+data.Rows[i].days+"</td></tr>";
			
		}
		$("#detail").html(info_html);
		$("#account").html("合计金额："+account+"元");
	}
});

</script>

</head>
<body>	
<div class="text-c">	
	查询类型:

			<select id="type">
				<option value="1">按日期</option>
				<option value="2">按月份</option>
			</select>

	选择时间:
			<input type='button' id='prev' value='<<'/>
			<input type="text" style="color:gray" name="time" id="time"  onfocus="createWdatePicker();">
			<input type='button' id='next' value='>>' />
			<input class="op" type="button" id="query" value="查询"/>
</div>	
<div class="divshow">
<div id="account" style="padding-left:150px"></div>
	<table id="detail" class="table table-border table-bg table-bordered radius"></table>
</div>
</body>
</html>