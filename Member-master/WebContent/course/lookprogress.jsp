<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zzsc.css"> -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

<title>查看进度</title>
<script>
$(function(){
	var id=$("#id").val();
	var identityType=$("#identityType").val();
	var caid=$("#caid").val();
	//设置类别
	$.post("${pageContext.request.contextPath}/course/getCategoryByMeid.action",{id:id,identityType:identityType},function(data){		
		//如果有传上来的caid的话
		if(caid!=""){
			var num=0;
			for(var i=0;i<data.length;i++){
				if(caid==data[i].id){
					num=i;
					break;
				}
			}
			showdata(data);
			$(".category").eq(num).addClass('active');
			getcachapter(caid);
		}else
		if(data.length>0){
			showdata(data);
			$(".category").eq(0).addClass('active');
			caid=data[0].id;
			getcachapter(caid);
		}
		else{
			$("#category").html("该学员没有进度数据");
		}
		categoryclick();
	});
	function getcachapter(id){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:caid},function(data){								
			showchapter(data);		
		});
	}
	function categoryclick(){
		$(".category").click(function(){
				caid=this.lang;	
				$(".category").siblings().removeClass('active'); // 删除其他兄弟元素的样式
				$(this).addClass('active'); // 添加当前元素的样式
				getcachapter(caid);
		});
	}
	function showdata(data){
		var line="";
		for(i=0;i<data.length;i++){
			if(i!=data.length-1)
			{
				line=line + "<a herf='#' style='text-decoration:none;cursor:pointer' class='category' lang='"+data[i].id+"'>"+data[i].title+"</a>&nbsp;|&nbsp;";
			}
			else
			{
				line=line + "<a herf='#' style='text-decoration:none;cursor:pointer' class='category' lang='"+data[i].id+"'>"+data[i].title+"</a>";
			}
		}
		$("#category").html(line);
	}
	
	function showchapter(data){
		var chorder=0;
		var corder=0;
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/courseandpro/existsByMemAndExp.action",{caid:caid,id:id,identityType:identityType},function(pro){
			if(pro!=""&& pro!=null){
				chorder=pro.chorder;
				corder=pro.corder;
				$("#proportion").html("已完成"+pro.proportion+"%");
			}		
		});
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
				if(data[i].courseAndCategory.order<chorder||(data[i].courseAndCategory.order==chorder&&data2.length==corder)){
					chaptitle = chaptitle + "<img src='${pageContext.request.contextPath}/images/ok-green.png' style='padding-left:30px;'>";				
				}	
				line = line + "<h4 >"+chaptitle+"</h4>";
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
.active{color:red}
</style>
</head>
<body>
<input type="hidden" value="${param.id }" id="id">
<input type="hidden" value="${param.identityType }" id="identityType">
<input type="hidden" value="${param.caid }" id="caid">
<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<table class="table table-hover">
				<tr>
					<th id="category" colspan="3"></th>
				</tr>
				<tr>
					<td colspan="3">
						<span id="proportion"></span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<div class="main content">
						    <div class="left-sider">
						      <div class="operate">
						        <ul id="J_navlist">                                  
						        </ul>
						      </div>
						    </div>
						</div>
					</td>
				</tr>			
			</table>
		</div>
	</div>

</div>
</body>
</html>