<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>会员进度-Java互助学习VIP群业务运行系统</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 	
<style type="text/css">

.white {
	color: #606060;
	border: solid 1px #b7b7b7;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top,  #fff,  #ededed);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}
.white:hover {
	background: #ededed;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#dcdcdc));
	background: -moz-linear-gradient(top,  #fff,  #dcdcdc);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#dcdcdc');
}

.white:active {
	color: #999;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#fff));
	background: -moz-linear-gradient(top,  #ededed,  #fff);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#ffffff');
}
.button {
	display: inline-block;
	zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
	*display: inline;
	vertical-align: baseline;
	margin: 0 2px;
	outline: none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	font: 14px/100% Arial, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	-webkit-border-radius: .5em; 
	-moz-border-radius: .5em;
	border-radius: .5em;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	box-shadow: 0 1px 2px rgba(0,0,0,.2);
}
.button:hover {
	text-decoration: none;
}
.button:active {
	position: relative;
	top: 1px;
}

.bigrounded {
	-webkit-border-radius: 2em;
	-moz-border-radius: 2em;
	border-radius: 2em;
}
.medium {
	font-size: 12px;
	padding: .4em 1.5em .42em;
}
.small {
	font-size: 11px;
	padding: .2em 1em .275em;
}
.big_div{

}
.content{
width:180px;
height:280px;
border:1px solid silver;
float:left;
margin-left:15px;
margin-top:15px;
z-index:1;
}
.photo{
width:150px;
height:150px;
border-radius:100px;
margin-left:15px;
margin-top:15px;
}
.text{
margin-top:5px;
text-align:center;
color:#666666;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;

	$.post("${pageContext.request.contextPath}/Social/getCondition.action",function(data){
		var returnMap = eval("(" + data + ")").returnMap;
		var statusCode = returnMap.statusCode;
		if(statusCode.errNum != 100) {
			layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
			return ;
		}
		var list = returnMap.conditionList;
		var optionstring="";
		for(var item in list){
			optionstring += "<option value=\""+ list[item] +"\" >"+ list[item] +"</option>";
		}
		$("#sel").html(optionstring);
	})
	
	
	$("#select").click(function(){

		getData(1);
	});
	$('select').searchableSelect();
	function getData(page2) {
		var list;
		var condition="";
		condition = $(":selected","#sel").val();
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/Social/getSocial.action",{page2:page2,condition:condition},function(data){
			var returnMap = eval("(" + data + ")").returnMap;
			var statusCode = returnMap.statusCode;
			if(statusCode.errNum != 100) {
				layer.msg("<strong style='color:red;'>" + statusCode.errMsg + "</strong>", {icon : 2});
				return ;
			}

			var navbar=returnMap.navbar;
			list=returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			if(list.length>0){
				drawTable(list);
			}
			else{
				$("#list").html("*暂无数据...");
			}
		});
		drawTable(list);
	}
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	function drawTable(data) {	
		$(".big_div").html("");		
		var img="";
		var photoObj;
		for(i = 0;i < data.length;i++) {
			var line="";
			line=line + "<div class='content'>";
			if(data[i].pid==null){
				if(data[i].sex=="男"){
					img="<img src='${pageContext.request.contextPath}/images/user_male.png' class='photo' lang=0>";
				}else{
					img="<img src='${pageContext.request.contextPath}/images/user_female.png' class='photo' lang=0>";
				}
			} else{
				if(data[i].sex=="男"){
					img="<img src='${pageContext.request.contextPath}/images/user_male.png' class='photo' lang=" + data[i].pid +">";
				}else{
					img="<img src='${pageContext.request.contextPath}/images/user_female.png' class='photo' lang=" + data[i].pid +">";
				}
			}
				
			
				line=line + img;
				line=line + "<div class='text'>"+data[i].realname+"</div>";			
				line=line + "<div class='text'>"+"所在地："+data[i].pname+"</div>";
				line=line + "<div class='text'>"+"<a href='javascript:void(0)' class='information' lang="+i+">详细信息</a>"+"</div>";
				line=line + "</div>";
				$(".big_div").append(line);
		}
		$(".information").click(function(){
				var i=$(this).attr("lang");
				var table ="<table class='text-c'>";
				table +="<tr><td>会员姓名</td>";   
				table +="<td>";
				table +=data[i].realname;
				table +="</td></tr><tr><td>性别</td><td>";
				table +=data[i].sex;
				table +="</td></tr><tr><td>年龄</td><td>";
				if(data[i].age==null || data[i].age==0){
					table +="无";
				}else{
					table +=data[i].age;
				}
				table +="</td></tr><tr><td>学校</td><td>";				
				table +=data[i].school;
				table +="</td></tr><tr><td>手机号</td><td>";
				table +=data[i].phone;
				table +="</td></tr><tr><td>qq</td><td>";
				table +=data[i].qq;
				table +="</td></tr><tr><td>类型</td><td>";
				if(data[i].student==1){
					table +="学生";
				}else{
					table +="在职";
				}
				table +="</td></tr><tr><td>毕业时间</td><td>";
				var JsonDateValue = new Date(data[i].graduateDate);
				table +=JsonDateValue.pattern("yyyy-MM-dd");
				table +="</td></tr><tr><td>所在城市</td><td>";
				table +=data[i].pname;
				table +="</td></tr><tr><td>出生地</td><td>";
				if(data[i].psname==null){
					table +="无";
				}else{
					table +=data[i].psname;
				}
				table += "</td></tr>";
				table += "</table>";
				layer.open({
					  type: 1,
					  skin: 'layui-layer-rim', //加上边框
					  area: ['390px', '320px'], //宽高
					  content: table
					});
		})
		$(".photo").each(function(){
			var src = "";
			if($(this).attr("lang") != 0 || $(this).attr("lang") != "0") {
				src = "${pageContext.request.contextPath}/picture/getPictureByid.action?id=" + $(this).attr("lang");
				$(this).attr("src",src);
			}
		});
	}
});
</script>

</head>
<body>
	<h1 style="text-align:center">会员信息查询</h1>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<select id="sel"></select>
	        <a id="select" class="button white bigrounded">查询</a> 
		</div>
		
	<div class="pd-20">
		<div class="mt-20">
			<div class='big_div'></div>
		</div>
	</div>
	<div style="clear:both"></div>
	<div class='page-nav' style="margin-top:20px;padding-right:120px"></div>
	
</body>
</html>