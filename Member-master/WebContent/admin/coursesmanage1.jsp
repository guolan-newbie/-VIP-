<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="utf-8">
<title>课程管理-Java互助学习VIP群业务运行系统</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript">
$(function() {
	var id;
	var chid;
	var cateId=7;
	getData();
	
	//添加章节点击事件
	$("#addchapter").click(function() {
		layer.open({
		    type: 2,
		    title:'添加章节',
		    area: ['380px', '380px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/addchapter.jsp',
		    end: function() {    	
		    	getData();
		    }
		});				
	});
	//添加课程点击事件
	$("#addlession").click(function() {
		layer.open({
		    type: 2,
		    title:'添加课程',
		    area: ['380px', '380px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/addlesson.jsp',
		    end: function() {    	
		  		 getData();
		    }
		});				
	});

	$("#sortlessions").click(function() {
		layer.open({
		    type: 2,
		    title:'课程排序',
		    area: ['450px', '600px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/sortlessons.jsp',
		    end: function() {    	
		    	getData();
		    }
		});				
	});

	$("#setcategory").click(function() {
		layer.open({
		    type: 2,
		    title:'类别设定',
		    area: ['505px', '600px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/setcategory.jsp',
		    end: function() {    	
		    	getData();
		    }
		});				
	});
	
	$("#lookcategory").click(function() {
		layer.open({
		    type: 2,
		    title:'查看类别',
		    area: ['800px', '600px'],
		    shift:1,
		    shade: 0.5, //开启遮罩关闭
		    content: '${pageContext.request.contextPath}/course/lookcategory.jsp',
		    end: function() {    	
		    	getData();
		    }
		});				
	});
	
	function getData(){
		//设置类别
		$.post("${pageContext.request.contextPath}/course/getcategory.action",function(data){
			showdata(data);
			//默认选择第一个类别
			$(".category").eq(0).addClass('active');
				getcachapter(cateId);
				categoryclick();
		});
	}	
	//表头章节
	function showdata(data){	
		var line="";
		for(i=1;i<data.length;i++){
			if(i!=data.length-1)
			{
				if(data[i].capid==""){
					line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+","+"false"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>&nbsp;|&nbsp;";
				}else{
					line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+","+"true"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>&nbsp;|&nbsp;";
				}
			}
			else
			{
				if(data[i].capid==""){
					line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+","+"false"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>";

				}else{
					line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].id+","+"true"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>";
				}
			}
		}
		line=line + "&nbsp;|&nbsp;<a herf='#' style='text-decoration:none' class='category' lang='"+data[0].id+","+"false"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[0].title+"</a>";
		$("#category").html(line);
	}
	//给选择不同章节绑定按钮
	function categoryclick(){
		$(".category").click(function(){
			var arr=this.lang.split(",");
			id=arr[0];
			flag=arr[1];
			$(".category").siblings().removeClass('active'); // 删除其他兄弟元素的样式
			$(this).addClass('active'); // 添加当前元素的样式
			getcachapter(id);
		});
	}
	//通过类别id获得所有章节
	function getcachapter(id){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:id},function(data){								
			showchapter(data);	
			modifyOrDelete();
		});
	}
	//画章节图
	function showchapter(data){
		var chorder=0;
		var corder=0;
		var img="";
		var chaptitle="";
		var line="";
		for(i=0;i<data.length;i++){			
			$.post("${pageContext.request.contextPath}/course/getLessons.action",{chid:data[i].id},function(data2){
				line = line + "<li >";
				if(data[i].optional_flag==true){
					chaptitle = "<span style='color:#76EE00;'>"+ data[i].title+ "（选修课）</span>";
				}else{
					chaptitle = data[i].title;
				}	
				line = line + "<h4 >"+chaptitle+"</h4>";
				line=line+"<div class='list-item none'>";
				for(j=0;j<data2.length;j++){
					img="<i class='Hui-iconfont pflag' style='padding-left:30px;'>&#xe647;</i>";
					line=line+"<p ><a herf='#' class='modifyOrDelete' lang='"+ data2[j].id +"' style='text-decoration:none' target='_self'>"+data2[j].title + img +"</a></p>";	
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
	
 	function modifyOrDelete(){
		$(".modifyOrDelete").click(function(){
			modifyOrDeleteId=this.lang;
			//询问框
			layer.open({
				  content: '修改/删除/评论此节课',
				  btn:  ['修改','删除','添加评论'] //按钮
				  ,yes: function(index, layero){
					  modifyclick();
				  },btn2: function(index, layero){
					  deleteclick();
				  },
				  btn3: function(index, layero){
					    layer.msg("添加评论");
				  }
			});
		})
	} 
	
	function modifyclick(){
		var url="${pageContext.request.contextPath}/course/modifylesson.jsp?id="+modifyOrDeleteId;
/* 		if(chid==0){
			url="${pageContext.request.contextPath}/course/modifychapter.jsp?id="+id;
		} */ 
		layer.open({
		    type: 2,
		    title:'修改',
		    area: ['380px', '380px'],
		    shift:1,
		    content: url,
		    end: function() {    	
			    getData();
		    }
		});				
	}
	
	function deleteclick(){
		var img="您确定要删除此条课程记录吗？";
		if(chid==0){
			img="您确定要删除此条章节记录吗？此操作会将该章节下的所有课程删除，请谨慎操作！";
		}
		layer.confirm(img,{btn:['是','否']},//按钮一的回调函数
				function(){
					$.post("${pageContext.request.contextPath}/course/delete.action",{id:modifyOrDeleteId,chid:chid},function(data) {
					layer.closeAll('dialog');
						getData();
					});
		});
	}
});

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
.operate li .list-item a { background:none;  border:none; color: #333333; display:block; height:32px; line-height: 32px; margin: 0 -1px 0 1px; padding-left: 60px;  position: relative; text-decoration: none; font-size:14px; }
.left-sider .ser-online a { background:url(../images/bg_ser_online.jpg) no-repeat 0 0; margin-top:10px; height:75px; border:1px solid #eaeaea; display:block; }
.pflag{float:right; margin-right:10%;}
.active{color:red}
</style>
</head>
<body>
	<h1 style="text-align: center">课程管理</h1>
	<div class="pd-20">
<!-- 		<div class="text-c">
			<input type="text" name="title" id="" placeholder="课程名称"
				style="width: 250px" class="input-text">
			<button name="" id="query" class="btn btn-success" type="submit">
				<i class="Hui-iconfont">&#xe665;</i>课程查询
			</button>
		</div> -->
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"> <a class="btn btn-primary radius"
				href="javascript:;" id="addchapter"><i class="Hui-iconfont">&#xe600;</i>
					添加章节</a> <a class="btn btn-primary radius" href="javascript:;"
				id="addlession"><i class="Hui-iconfont">&#xe600;</i> 添加课程</a> <a
				class="btn btn-default radius" href="javascript:;" id="sortlessions"><i
					class="Hui-iconfont">&#xe647;</i> 课程排序</a> <a
				class="btn btn-default radius" href="javascript:;" id="setcategory"><i
					class="Hui-iconfont">&#xe647;</i> 设置新类别</a> <a
				class="btn btn-default radius" href="javascript:;" id="lookcategory"><i
					class="Hui-iconfont">&#xe647;</i> 设定章节类别</a></span>
			
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span id="category" style="font-size: 20px"> </span>
		</div>
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
		<div style="text-align: center; clear: both"></div>
	</div>

</body>
</html>