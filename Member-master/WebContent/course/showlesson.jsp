<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zzsc.css">
<script src="${pageContext.request.contextPath}/jslib/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function() {
	var id=$("#id").val();
	getData();
	$.ajaxSetup({async:false});
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
							getData();
						});
			});
		});
	}
	function getData(){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:id},function(data){	
			showdata(data);
		});
		imgclck();
	}
	function showdata(data){
		var chorder=0;
		var corder=0;
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/courseandpro/exists.action",{caid:id},function(pro){
			if(pro!=""&& pro!=null){
				chorder=pro.chorder;
				corder=pro.corder;
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
		$("#J_navlist").html(line);
		navList(1);

	}
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
</script>
</head>
<body>
<input type="hidden" value="${param.id}" id="id">
<div>
  <div class="main content">
    <div class="left-sider">
      <div class="operate">
        <h3>进度选择</h3>
        <ul id="J_navlist">                                  
       </ul>
        <script type="text/javascript" language="javascript">
			navList(1);
		</script>
      </div>
    </div>
  </div>
</div>
<div style="text-align:center;clear:both">
</div>
</body>
</html>