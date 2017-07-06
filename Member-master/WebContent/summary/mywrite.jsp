<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我的周报-专注建立IT精英圈子</title>
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
		<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
		<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mywrite.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
		<style type="text/css">
		#menu>li>a {background:#3c3c46;font-weight: 700; display: block;height:45px;border-top:solid 1px #444; color:#fff; font-family: "Helvetica Neue","Hiragino Sans GB","Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;}
		</style>
<script type="text/javascript">
$(function(){
				var pageVal=$("#page").val();
				$.post("${pageContext.request.contextPath}/member/getSumAll.action",{page:pageVal},function(data){
					$.each(data,function(i){
						var condiv=$("<div>").addClass("condiv").appendTo($("#contentdiv"));
						var title=$("<a>").attr({href:"javascript:;",style:"text-decoration: none",lang:data[i].id}).addClass("tit").appendTo(condiv);
						$("<span>"+data[i].member.name+":"+data[i].title+"学习周报"+"</span>").addClass("condivtil").appendTo(title);
						var iconspan=$("<span>").addClass("condivicon").appendTo(condiv);
						var iconspaniner=$("<span>").attr({style:"color: #BBBBBB; font-size: 14px;"}).addClass("glyphicon glyphicon-time").appendTo(iconspan);
						$("<span>"+data[i].time+"</span>").addClass("icon1iner").appendTo(iconspaniner)
						$("<hr>").attr({color:"#DDDDDD"}).appendTo(condiv);
					});					
				});
				$(document).on('click','.tit',function(){
					var idval=this.lang;
					$.ajaxSetup({async:false});
					$.post("${pageContext.request.contextPath}/summary/getSumById.action",{id:idval,page:pageVal},function(){
					location.href="${pageContext.request.contextPath}/ueditor/membersumcomment.jsp?page="+pageVal;
					});
				});
});

</script>

</head>
<body leftmargin="30px">
	<jsp:include page="/member/navbar1.jsp"></jsp:include>
	<c:if test="${myuser.member==null }">
	<c:redirect url="/user/login.jsp" />
	</c:if>
		<div class="content-wrap" style="padding-left:300px;" >
		<div class="mywridiv" style="width:800px;">
			<span class="mywridivspan">我的周报</span>
		</div>
		<div id="contentdiv" style="margin-top: -23px;width:800px;">
			<hr color="#00CCFF" style="height: 3px;" />
		</div>
<c:choose>
	<c:when test="${param.page==''}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.page==null}">
		<input type="hidden" id="page" value="1"> 
	</c:when>
	<c:when test="${param.page!=null}">
		<input type="hidden" id="page" value="${param.page}"> 
	</c:when>
</c:choose>
		<div class="paging" style="width:800px;">
			<div class="paingdivinner" >
				<span id="back">
					<a href="${pageContext.request.contextPath}/ueditor/memberlooksum.jsp">会员周报</a>&nbsp;&nbsp;
					<a href="${pageContext.request.contextPath}/member/infoshow.jsp">返回主页</a>
				</span>
				<a href="${pageContext.request.contextPath}/ueditor/mywrite.jsp?page=1">首页</a>&nbsp;&nbsp;
<c:choose>
	<c:when test="${param.page==1||param.pages==null}">
		<span>上一页</span>&nbsp;&nbsp;	
	</c:when>
	<c:when test="${param.page>1}">
		<a href="${pageContext.request.contextPath}/ueditor/mywrite.jsp?page=${param.page-1}">上一页</a>&nbsp;&nbsp;	
	</c:when>
</c:choose>	
<c:choose>
	<c:when test="${param.page>=pageCount||param.pages==null}">
		<span>下一页</span>&nbsp;&nbsp;
	</c:when>
	<c:when test="${param.page<pageCount}">
		<a href="${pageContext.request.contextPath}/ueditor/mywrite.jsp?page=${param.page+1}">下一页</a>&nbsp;&nbsp;
	</c:when>
</c:choose>	
				<a href="${pageContext.request.contextPath}/ueditor/mywrite.jsp?page=${pageCount}">尾页</a>&nbsp;&nbsp;
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