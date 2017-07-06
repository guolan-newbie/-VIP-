<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>会员进度-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<script type="text/javascript">
$(function() {
	var page2=1;
	var school=$("#school").val();
	getData(page2,school);
	function getData(page2,school) {
		var list;
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/picture/getAllUserCoverInThisSchoolByPage.action",{page2:page2,school:school},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var tatolCount = dataObj.returnMap.totalCount;
			list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			$("#num").html(tatolCount);
			drawTable(list);
			btnclick();
		});
	}
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2,school);
		})
	}
	function drawTable(data) {	
		$(".big_div").html("");		
		var img="";
		var photoObj;
		for(i = 0;i < data.length;i++) {
			var line="";
			line=line + "<div class='content'>";
			if(data[i].picture==null){
				if(data[i].member.sex=="男"){
					img="<img src='${pageContext.request.contextPath}/images/user_male.png' class='photo' lang=0>";
				}else{
					img="<img src='${pageContext.request.contextPath}/images/user_female.png' class='photo' lang=0>";
				}
			} else{
				/* $.ajaxSetup({async:false});
				$.post("${pageContext.request.contextPath}/picture/getPictureByid.action",{id:data[i].picture.id},function(data1){
					img="<img src='data: image/jpeg;base64,"+ data1.photo+"' class='photo'>";
				}); */
				//alert(data[i].picture);
				if(data[i].member.sex=="男"){
					img="<img src='${pageContext.request.contextPath}/images/user_male.png' class='photo' lang=" + data[i].picture.id +">";
				}else{
					img="<img src='${pageContext.request.contextPath}/images/user_female.png' class='photo' lang=" + data[i].picture.id +">";
				}
			}
				line=line + img;
				line=line + "<div class='text'>"+data[i].name+"</div>";
				line=line + "<div class='text'>"+data[i].member.name+"</div>";			
				line=line + "<div class='text'>"+"所在地："+data[i].member.provname+"</div>";
				line=line + "<div class='text'>"+"出生地："+data[i].member.seat_provname+"</div>";
				line=line + "</div>";
				$(".big_div").append(line);
		}
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
<style type="text/css">
.big_div{

}
.content{
width:180px;
height:280px;
border:1px solid silver;
float:left;
margin-left:15px;
margin-top:15px;
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
</head>
<body>
<input id="school" type="hidden" value="${param.school }">
	<h1 style="text-align:center">校友信息</h1>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="r">共有数据：<strong id="num"></strong> 条</span> 
		</div>
		<div class="mt-20">
			<div class='big_div'></div>
		</div>
	</div>
	<div style="clear:both"></div>
	<div class='page-nav' style="margin-top:20px;padding-right:120px"></div>
	
</body>
</html>