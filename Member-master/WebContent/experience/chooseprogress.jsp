<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>进度选择-Java互助学习VIP群业务运行系统</title>

<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/jslib/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function() {
	var id;
		//获取专业
	$.post("${pageContext.request.contextPath}/course/getcategory.action",function(data){
		showdata(data);
		if(data.length>0){
			id=data[0].id;
			getcachapter(id);
		}
		categoryclick();
		imgclck();
	});
	function getcachapter(id){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:id},function(data){								
			showchapter(data);		
		});
		imgclck();
	}
	function categoryclick(){
		$(".category").click(function(){
				id=this.lang;	
				getcachapter(id);
		});
	}
	//图标点击事件 确认学到了哪里
	function imgclck(){
		$(".pflag").dblclick(function(){
			var arr=this.lang.split(",");
			var caid=id;
			var chorder=arr[0];
			var corder=arr[1];
			var title=arr[2];
			layer.confirm('您确定已经学到【'+title+'】这里来了吗？',{btn:['是','否']},//按钮一的回调函数
					function(){					
						$.ajaxSetup({async:false});
						$.post("${pageContext.request.contextPath}/courseandpro/add.action",{caid:caid,chorder:chorder,corder:corder},function(data){						
							layer.closeAll('dialog');
							getcachapter(id);
						});
			});
		});
	}
	
	function showdata(data){
		var line="";
		for(i=0;i<data.length;i++){
			if(i!=data.length-1)
			{
				line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>&nbsp;|&nbsp;";
			}
			else
			{
				line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>";
			}
		}
		$(".l").append(line);
	}
	
	function showchapter(data){
		var chorder=0;
		var corder=0;
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/courseandpro/exists.action",{caid:id},function(pro){
			if(pro!=""&& pro!=null){
				chorder=pro.chorder;
				corder=pro.corder;
				$("#proportion").html(pro.proportion);
			}		
		});
		var img="";
		var line="";
		for(i=0;i<data.length;i++){			
			line = line + "<li >";
			line = line + "<h4 >"+data[i].title+"</h4>";
			$.post("${pageContext.request.contextPath}/course/getLessons.action",{chid:data[i].id},function(data2){	
				line=line+"<div class='list-item none'>";
				for(j=0;j<data2.length;j++){
					if(data[i].courseAndCategory.order<chorder){
						img="<img src='${pageContext.request.contextPath}/images/ok-green.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
					}else if(data[i].courseAndCategory.order==chorder){
						if(data2[j].order<=corder){
							img="<img src='${pageContext.request.contextPath}/images/ok-green.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
						}else{
							img="<img src='${pageContext.request.contextPath}/images/x-red.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
						}
					}else{
						img="<img src='${pageContext.request.contextPath}/images/x-red.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
					}
					line=line+"<p ><a herf='#' style='text-decoration:none' target='_self'>"+data2[j].title+ img +"</a></p>";	
					}
				line=line+"</div>";
				line = line + "</li>";				
			});			
		}
		//alert(line);
		$("#J_navlist").html(line);
		navList(1);

	}
	
	$("#query").click(function() {
		/* 防止没有数据导致页码为空的情况 */
		if($("b").text()) {
			query($("b").text());
		}
		else {
			query(1);
		}
	});
	
	//列表下拉
	function navList(id) {
	    var $obj = $("#J_navlist"), $item = $("#J_nav_" + id);
	    $item.addClass("on").parent().removeClass("none").parent().addClass("selected");
	    $obj.find("h4").hover(function () {
	        $(this).addClass("hover");
	    }, function () {
	        $(this).removeClass("hover");
	    });
	    $obj.find("p").hover(function () {
	        if ($(this).hasClass("on")) { return; }
	        $(this).addClass("hover");
	    }, function () {
	        if ($(this).hasClass("on")) { return; }
	        $(this).removeClass("hover");
	    });
	    $obj.find("h4").click(function () {
	        var $div = $(this).siblings(".list-item");
	        if ($(this).parent().hasClass("selected")) {
	            $div.slideUp(600);
	            $(this).parent().removeClass("selected");
	        }
	        if ($div.is(":hidden")) {
	            $("#J_navlist li").find(".list-item").slideUp(600);
	            $("#J_navlist li").removeClass("selected");
	            $(this).parent().addClass("selected");
	            $div.slideDown(600);

	        } else {
	            $div.slideUp(600);
	        }
	    });
	}
		
});

function query(data) {	
	var page2 = data;	
	getData(page2);
	$("#courses").html("");
}




</script>
 <style type="text/css">
/*定位*/
.none { display:none }

/*通用*/

.main { margin:20px auto 0 auto;  overflow:hidden; zoom:1 }
.main .left-sider { float:left; width:90%; }
.operate h3 { font-family: "Microsoft YaHei",微软雅黑; font-size:16px; background:#f7f7f7; height:43px; line-height:43px; padding-left:12px; }
.operate ul li { display:inline; }
.operate ul li a { background:url(../images/bg1.png) no-repeat 270px 18px; padding-left:30px; text-decoration:none; font-size:16px; color:#555; display:block;  height:43px;  line-height:43px; border-bottom:1px dotted #d2d2d2; }
.operate ul li a.noline { border-bottom:none; }
.operate ul li a:hover{ color:#8caf00; }
.operate ul li a.selected:hover { color:#fff; }
.operate ul li .selected { background-color:#8caf00;  background-position:270px -9px; color:#fff; }
.operate ul li h4 { cursor:pointer; background:url(../images/bg3.png) no-repeat 90% 18px; padding-left:30px; text-decoration:none; font-size:16px; color:#555; display:block;  line-height:43px; font-weight:normal; }
.operate ul li.noline { border-bottom:none; }
.operate ul li h4:hover { color:#8caf00; text-decoration:underline; }
.operate ul li.selected h4 { background-position:90% -37px; border-bottom:1px dotted #d2d2d2; }
.operate ul li a { }
.operate ul li .on a { color:#8caf00; font-weight:bold; }
.operate ul li a:hover { color:#8caf00; text-decoration:underline; }
.bg-color { background-color:#8caf00; }
.operate li .list-item { padding:5px 0; position:relative; zoom:1 }
.operate li .list-item p { padding-left:8px; background:url(../images/ico_li.png) no-repeat 270px center; }
.operate li .list-item a { background:none;  border:none; color: #333333; display:block; height:32px; line-height: 32px; margin: 0 -1px 0 1px; padding-left: 60px;  position: relative; text-decoration: none; font-size:14px; }
.left-sider .ser-online a { background:url(../images/bg_ser_online.jpg) no-repeat 0 0; margin-top:10px; height:75px; border:1px solid #eaeaea; display:block; }
.pflag{float:right; margin-right:10%;}
</style>
</head>
<body>
	<h1 style="text-align:center">进度选择</h1>
	<div class="pd-20">
		<div class="text-c"> 	
        	<input type="text" name="title" id="" placeholder="课程名称" style="width:250px" class="input-text">		
			<button name="" id="query" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i>课程查询</button>
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="l" style="font-size:20px">			
			</span> 
			<span class="r">已完成：<strong id="proportion"></strong> %</span> 
		</div>	
	</div>
<div style="margin-left:20px;font-size:16px;color:green">双击&nbsp;&nbsp;&nbsp;<img src='${pageContext.request.contextPath}/images/ok-green.png'>&nbsp;&nbsp;&nbsp;<img src='${pageContext.request.contextPath}/images/x-red.png'>&nbsp;&nbsp;&nbsp;图标选择当前学习进度</div>
<div>
  <div class="main content">
    <div class="left-sider">
      <div class="operate">
        <ul id="J_navlist">                                  
        </ul>
      </div>
    </div>
</div>
</div>
<div style="text-align:center;clear:both">
</div>

	
</body>
</html>