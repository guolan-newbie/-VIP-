<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>会员统计-专注建立IT精英圈子</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/fusioncharts/FusionCharts.js"  charset="UTF-8"></script>

    
<style type="text/css">
#chartdiv_01,#chartdiv_02,#chartdiv_03{display:inline;}
#account{margin-bottom:20px;font-weight:bold;font-color:red}
#content{margin-top:30px;}
</style>   
<script type="text/javascript">

$(function(){
	$.post("${pageContext.request.contextPath}/member/getCount.action",function(data){
		$("#account").html($("#account").html()+data);
	});
	$("#title").html("性别比例：");
	$.ajax({  
    	type:'post',  
   		url:'../member/getSex.action',  
    	data:'',  
    	success:function(msg){  
			var chart=new FusionCharts("../fusioncharts/swf/Pie2D.swf","chartId1","400","300","0","1");
			chart.setDataXML(msg);
        	chart.render(chartdiv);  
   		 },  
    	error:function(){  
        	alert("加载失败，请重新加载...");  
    	}  
	});
	$("#page1").click(function(){
		$("li").siblings().removeClass('active'); // 删除其他兄弟元素的样式
		$(this).addClass('active'); // 添加当前元素的样式
		$("#title").html("性别比例：");
		$.ajax({  
	    	type:'post',  
	   		url:'../member/getSex.action',  
	    	data:'',  
	    	success:function(msg){  
				var chart=new FusionCharts("../fusioncharts/swf/Pie2D.swf","chartId1","400","300","0","1");
				chart.setDataXML(msg);
	        	chart.render(chartdiv);  
	   		 },  
	    	error:function(){  
	        	alert("加载失败，请重新加载...");  
	    	}  
		});
	})
	$("#page2").click(function(){
		$("li").siblings().removeClass('active'); // 删除其他兄弟元素的样式
		$(this).addClass('active'); // 添加当前元素的样式
		
		$("#title").html("学生比例：");
		$.post("${pageContext.request.contextPath}/member/getStudent.action",function(data){
			var myChart = new FusionCharts("../fusioncharts/swf/Pie2D.swf", "myChartId_02", "400", "300");  
			myChart.setDataXML(data);
			myChart.render(chartdiv);
		});
	})
	$("#page3").click(function(){
		$("li").siblings().removeClass('active'); // 删除其他兄弟元素的样式
		$(this).addClass('active'); // 添加当前元素的样式
		$("#title").html("年龄比例：");
		$.ajax({  
	    	type:'post',  
	   		url:'../member/getAge.action',  
	    	data:'',  
	    	success:function(msg){  
				var chart=new FusionCharts("../fusioncharts/swf/Pie2D.swf","chartId3","400","300","0","1");
				chart.setDataXML(msg);
	       		chart.render(chartdiv);  
	   		 },  
	    	error:function(){  
	        	alert("加载失败，请重新加载...");  
	    	}  
		});  
	})
	$("#page4").click(function(){
		$("li").siblings().removeClass('active'); // 删除其他兄弟元素的样式
		$(this).addClass('active'); // 添加当前元素的样式
		$("#title").html("当前所在地分布：");
		$.ajax({  
	    	type:'post',  
	   		url:'../member/getProvince.action',  
	    	data:'',  
	    	success:function(msg){  
				var chart=new FusionCharts("../fusioncharts/swf/Column2D.swf","chartId4","1208","400","0","1");
				chart.setDataXML(msg);
	       		chart.render(chartdiv);  
	   		 },  
	    	error:function(){  
	        	alert("加载失败，请重新加载...");  
	    	}  
		});
	})
	$("#page5").click(function(){
		$("li").siblings().removeClass('active'); // 删除其他兄弟元素的样式
		$(this).addClass('active'); // 添加当前元素的样式
		$("#title").html("出生地分布：");
		$.ajax({  
	    	type:'post',  
	   		url:'../member/getBornProvince.action',  
	    	data:'',  
	    	success:function(msg){  
				var chart=new FusionCharts("../fusioncharts/swf/Column2D.swf","chartId4","1208","400","0","1");
				chart.setDataXML(msg);
	       		chart.render(chartdiv);  
	   		 },  
	    	error:function(){  
	        	alert("加载失败，请重新加载...");  
	    	}  
		});
	})
   

 
   
});	

</script>

</head>
<body>
<div id="content">
<br/>
<br>
<div id="account">当前会员总数：</div>
<div id="title"></div>
<div id="chartdiv"></div> 
<!-- 
<div id="chartdiv_01"></div>  
<div id="chartdiv_02"></div>  
<div id="chartdiv_03"></div> 
<div id="chartdiv_04"></div>  
-->
<ul class="pagination">
    <li id="page1" class="active"><a href="javascript:;">1</a></li>
    <li id="page2"><a href="javascript:;">2</a></li>
    <li id="page3"><a href="javascript:;">3</a></li>
    <li id="page4"><a href="javascript:;">4</a></li>
    <li id="page5"><a href="javascript:;">5</a></li>
</ul>

<br/>
<br/>
</div>
</body>
</html>