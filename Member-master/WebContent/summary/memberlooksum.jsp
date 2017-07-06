<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>学员周报-专注建立IT精英圈子</title>
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
		<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
		<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mywrite.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>

    
<style type="text/css">
#chartdiv_01,#chartdiv_02,#chartdiv_03{display:inline;}
#account{margin-left:20px;margin-bottom:20px;font-weight:bold;font-color:red}
#content{margin-left:30px;margin-top:30px;}
/*left-菜单*/
.left-menu{
    position:absolute;
    float: left;
    min-height: 100%;
    box-shadow: 0 0 10px #BDBDBD;
    width: 180px;
    background: #32323a;
}

#menu>li>a {background:#3c3c46;font-weight: 700; display: block;height:45px;border-top:solid 1px #444; color:#fff; font-family: "Helvetica Neue","Hiragino Sans GB","Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;}
</style>   
<script type="text/javascript">

$(function(){

	$("#lookSum").click(function(){
		$.post("${pageContext.request.contextPath}/summary/savePageC.action",function(){
			location.href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages="+1;
		});
	});	
				var pageVal=$("#page").val();
				printCss(pageVal);		
				function printCss(pageVal){
					$.post("${pageContext.request.contextPath}/summary/getSummaryAll.action",{pages:pageVal},function(data){
							$.post("${pageContext.request.contextPath}/summary/preparePageNumber.action",function(page){
									$("#pageSum").html(page);
								});						
						$.each(data,function(i){
							var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
							var title=$("<a>").attr({href:"javascript:;",style:"text-decoration: none",lang:data[i].id}).addClass("tit").appendTo(condiv);
							$("<span>"+data[i].member.name+":"+data[i].title+"学习周报"+"</span>").addClass("condivtil").appendTo(title);
							var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
							var iconspaniner=$("<span>").attr({style:"color: #BBBBBB; font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
							$("<span>"+data[i].time+"</span>").addClass("icon1iner").appendTo(iconspaniner);
							if(data[i].ischeck == "1"){
								$("<span>").addClass("glyphicon glyphicon-eye-open").attr({style:"font-size:18px;color:red;margin-left:6px"}).appendTo(iconspaniner);
							}
							var iconspan2=$("<span>").addClass("condivicon2").appendTo(condiv);		
							$("<hr>").attr({color:"#DDDDDD"}).appendTo(condiv);
						});
					});
				}
				$("#prevweek").click(function(){
					$.post("${pageContext.request.contextPath}/summary/checkPreWeekIsValid.action",function(check){
						if(check == 1)
						{	
							$("#page").val(1);
							var pageVal=$("#page").val();
							$.post("${pageContext.request.contextPath}/summary/getSummaryByPreWeek.action",{pages:pageVal},function(data){
								if(data.length == 0)
								{
									layer.msg('亲，不要再点了哦~', {
									    icon: 2,
									    time: 1000
									});			
									return ;
								}
								$.post("${pageContext.request.contextPath}/summary/preparePageNumber.action",function(pageSum){
									$("#pageSum").html(pageSum);
									$("#currentPageNum").html(1);
								});
								$(".condiv").remove();
								$.each(data,function(i){
									var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
									var title=$("<a>").attr({href:"javascript:;",style:"text-decoration: none",lang:data[i].id}).addClass("tit").appendTo(condiv);
									$("<span>"+data[i].member.name+":"+data[i].title+"学习周报"+"</span>").addClass("condivtil").appendTo(title);
									var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
									var iconspaniner=$("<span>").attr({style:"color: #BBBBBB; font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
									$("<span>"+data[i].time+"</span>").addClass("icon1iner").appendTo(iconspaniner);
									if(data[i].ischeck == "1"){
										$("<span>").addClass("glyphicon glyphicon-eye-open").attr({style:"font-size:18px;color:red;margin-left:6px"}).appendTo(iconspaniner);
									}
									var iconspan2=$("<span>").addClass("condivicon2").appendTo(condiv);		
									$("<hr>").attr({color:"#DDDDDD"}).appendTo(condiv);
								});
								location.href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages="+1;
						});		
						}
						else{
							layer.msg('亲，不要再点了哦~', {
							    icon: 2,
							    time: 1000
							});				
						}
					});			
				});
				$("#currentweek").click(function(){	
					$(".condiv").remove();
					$("#page").val(1);
					var pageV=$("#page").val();
					$.post("${pageContext.request.contextPath}/summary/getSummaryByCurrentWeek.action",{pages:pageV},function(data){
							$.post("${pageContext.request.contextPath}/summary/preparePageNumber.action",function(page){
									$("#pageSum").html(page);
									$("#currentPageNum").html(1);
								});					
						$.each(data,function(i){
							var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
							var title=$("<a>").attr({href:"javascript:;",style:"text-decoration: none",lang:data[i].id}).addClass("tit").appendTo(condiv);
							$("<span>"+data[i].member.name+":"+data[i].title+"学习周报"+"</span>").addClass("condivtil").appendTo(title);
							var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
							var iconspaniner=$("<span>").attr({style:"color: #BBBBBB; font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
							$("<span>"+data[i].time+"</span>").addClass("icon1iner").appendTo(iconspaniner);
							if(data[i].ischeck == "1"){
								$("<span>").addClass("glyphicon glyphicon-eye-open").attr({style:"font-size:18px;color:red;margin-left:6px"}).appendTo(iconspaniner);
							}
							var iconspan2=$("<span>").addClass("condivicon2").appendTo(condiv);		
							$("<hr>").attr({color:"#DDDDDD"}).appendTo(condiv);
						});
					});
					location.href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages="+1;
				});
				$("#nextweek").click(function(){	
					$.post("${pageContext.request.contextPath}/summary/checkNextWeekIsValid.action",function(check){
						if(check == 1)
						{
							$("#page").val(1);
							var pageVal=$("#page").val();
							$.post("${pageContext.request.contextPath}/summary/getSummaryByNextWeek.action",{pages:pageVal},function(data){
								if(data.length == 0)
								{
									layer.msg('亲，已经是最后一周咯~', {
									    icon: 2,
									    time: 1000
									});
									return ;
								}
								$.post("${pageContext.request.contextPath}/summary/preparePageNumber.action",function(pageSum){
									$("#pageSum").html(pageSum);
									$("#currentPageNum").html(1);
								});
								$(".condiv").remove();
								$.each(data,function(i){
									var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
									var title=$("<a>").attr({href:"javascript:;",style:"text-decoration: none",lang:data[i].id}).addClass("tit").appendTo(condiv);
									$("<span>"+data[i].member.name+":"+data[i].title+"学习周报"+"</span>").addClass("condivtil").appendTo(title);
									var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
									var iconspaniner=$("<span>").attr({style:"color: #BBBBBB; font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
									$("<span>"+data[i].time+"</span>").addClass("icon1iner").appendTo(iconspaniner);
									if(data[i].ischeck == "1"){
										$("<span>").addClass("glyphicon glyphicon-eye-open").attr({style:"font-size:18px;color:red;margin-left:6px"}).appendTo(iconspaniner);
									}
									var iconspan2=$("<span>").addClass("condivicon2").appendTo(condiv);		
									$("<hr>").attr({color:"#DDDDDD"}).appendTo(condiv);
								});
								location.href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages="+1;
						});				
						}
						else{
							layer.msg('亲,已经是最后一周咯~', {
							    icon: 2,
							    time: 1000
							});						
						}
					});
					
				});
				$(document).on('click','.tit',function(){
					var idval=this.lang;
					var pageVal=$("#page").val();
					$.ajaxSetup({async:false});
					$.post("${pageContext.request.contextPath}/summary/getSummary.action",{id:idval,page:pageVal},function(){
						location.href="${pageContext.request.contextPath}/ueditor/membersumcomment.jsp";
					});
				});
});

</script>

</head>
<body>
	<c:choose>
		<c:when test="${myuser.member!=null&&admin==null}">
			<jsp:include page="/member/navbar1.jsp"></jsp:include>
		</c:when>
		<c:when test="${myuser.member==null&&admin!=null}">
			<jsp:include page="/admin/navbar1.jsp"></jsp:include>
		</c:when>
	</c:choose>
	<c:if test="${myuser.member==null&&admin==null}">
	<c:redirect url="/user/login.jsp" />
	</c:if>
            <!-- 正文 -->
	<div class="content-wrap" style="padding-left:300px">
			
		<div class="mywridiv" style="width:800px;">
		  <span class="mywridivspan">会员的周报</span>
			<span class="mywridivspan2" id="prevweek">向前一周</span>
			<span class="mywridivspan3" id="currentweek">回到本周</span>	
			<span class="mywridivspan4" id="nextweek">向后一周</span>
		</div>
		<div id="contentdiv" style="margin-top: -23px;width:800px;">
			<hr color="#00CCFF" style="height: 3px;" />
		</div>
<c:choose>
	<c:when test="${param.pages==''}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pages==null}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.pages!=null}">
		<input type="hidden" id="page" value="${param.pages}"> 
	</c:when>
</c:choose>
		<div class="paging" style="width:800px;">
			<div class="paingdivinner">
				<span id="back">
					<c:if test="${myuser.member!=null}">
					<a href="${pageContext.request.contextPath}/ueditor/mywrite.jsp">我的周报</a>&nbsp;&nbsp;
					</c:if>
					<c:choose>
					<c:when test="${myuser.member!=null&&admin==null}">
					<a href="${pageContext.request.contextPath}/member/infoshow.jsp">返回主页</a>
					</c:when>
					<c:when test="${admin!=null}">
					<a href="${pageContext.request.contextPath}/admin/check.jsp">返回主页</a>
					</c:when>
					</c:choose>
				</span>
				<a href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages=1">首页</a>&nbsp;&nbsp;
<c:choose>
	<c:when test="${param.pages==1||param.pages==null}">
		<span>上一页</span>&nbsp;&nbsp;	
	</c:when>
	<c:when test="${param.pages>1}">
		<a href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages=${param.pages-1}">上一页</a>&nbsp;&nbsp;	
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${param.pages>=AllPageCounts||param.pages==null}">
		<span>下一页</span>&nbsp;&nbsp;
	</c:when>
	<c:when test="${param.pages<AllPageCounts}">
		<a href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages=${param.pages+1}">下一页</a>&nbsp;&nbsp;
	</c:when>
</c:choose>	
				<a href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp?pages=${AllPageCounts}">尾页</a>&nbsp;&nbsp;
				<span>第<span id="currentPageNum">
					<c:if test="${param.pages!=null}">${param.pages}</c:if>
					<c:if test="${param.pages==null}">1</c:if>
				</span>页</span>
				&nbsp;/&nbsp;
				<span>共<span id="pageSum">${AllPageCounts}</span>页</span>
			</div>
		</div>	
			</div>
</body>
</html>