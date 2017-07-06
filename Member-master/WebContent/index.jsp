<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT精英会员俱乐部-为我们的事业保驾护航!</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chocolat.css" type="text/css" media="screen" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Expire Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<script src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/flexslider.css" type="text/css" media="screen" />
<!--scrolling-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/move-top.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/easing.js"></script>
 <script type="text/javascript">
		jQuery(document).ready(function($) {
			$(".scroll").click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top},1200);
			});
		});
		function open(){
		if(session.getAttribute("myuser")==null) {	
		alert("请输入用户名！"); document.form_name.username.focus(); return false;
		}else document.form_name.action="aaa.htm";
		};
	</script>
<!--scrolling-->
</head>
<body>	
<!--top-header-->
<div id="home" class="top-header">
	 <div class="container">
		 <div class="logo">

 <c:if test="${sessionScope.TURE!=null}" >
				<h1><a href="${pageContext.request.contextPath}/user/jumps.jsp">Join</a></h1>
				</c:if>
 <c:if test="${sessionScope.TURE==null}" >
 				<h1><a href="${pageContext.request.contextPath}/user/login.jsp">Join</a></h1>
 </c:if>
		 </div>
		 <div class="top-menu">
			 <span class="menu"><img src="images/nav-icon.png" alt=""/></span>
			 <ul>
				<li><a class="scroll" href="#home">首页</a></li>
				<li><a href="user/benifit.jsp">服务</a></li>
				<li><a class="scroll" href="#service">课程</a></li>
				<li><a href="user/questions.jsp">问题</a></li>
				<li><a href="user/about.jsp">关于</a></li>
				<li><a class="scroll" href="#contact">联系</a></li>
			 </ul>
		     <!-- script-for-menu -->
				 <script>					
							$("span.menu").click(function(){
								$(".top-menu ul").slideToggle("slow" , function(){
								});
							});
				 </script>
		     <!-- script-for-menu -->
		  </div>
	 </div>
</div>	
<!--header-->
<div class="header">
		<div class="container">
			 <div class="banner-info">
				 <h2>IT精英会员俱乐部,为你的事业保驾护航!</h2>
				 <p>不论性别,学历,年龄,肤色,只要你和我们一样对IT技术领域充满浓厚兴趣,并愿意为她矢志不渝,不管路有多长,我们愿意陪着你,一路的走下去！！</p>
				 <a href="user/benifit.jsp">Click</a>
			 </div>
			 <div class="clearfix"></div>
		</div>
</div>
<!--Service-->
<div id="service" class="service">
	 <div class="container">
		 <h3>免费服务</h3>	
		 <div class="service-grids">
		 <div class="icon-grids">
			 <div class="col-md-6 futr-grid futr1">
				 <div class="icon-pic">
						<div class="icon text-center">
						 <span class="glyphicon glyphicon-phone" aria-hidden="true"></span>
						 </div>
				  </div>
				 <div class="icon-info">
						 <h4><a href="#">免费评估</a></h4>							
						 <p>不要相信任何人都可以学会软件开发的鬼话！通过你的年龄，学历，过往学习和工作经历，给你一个综合评分，根据评分结果对你是否适合学，多久可以学会，学完以后在职场上的预期待遇进行评估。</p>
				 </div>
				 <div class="clearfix"></div>
			 </div>
			 <div class="col-md-6 futr-grid">
				  <div class="icon-pic">
							<div class="icon text-center">
							<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
						 </div>
				  </div>
				  <div class="icon-info">
						<h4><a href="#">免费课程</a></h4>						 
						<p>我们有丰富的免费体验课程，这些课程已经有上百万的点击量，获得学习者无数好评！我们的课程特点是：通俗易懂，注重实际，学习周期短。只要把我们的课程内容弄懂，就可以胜任企业中最复杂的项目开发任务。</p>
				  </div>
				  <div class="clearfix"></div>
			 </div>
			 <div class="clearfix"></div>
		 </div>
		 <div class="icon-grids grids2">
			 <div class="col-md-6 futr-grid futr1">
				 <div class="icon-pic">
						<div class="icon text-center">
						 <span class="glyphicon glyphicon-picture" aria-hidden="true"></span>
						 </div>
				  </div>
				 <div class="icon-info">
						 <h4><a href="#">免费指导</a></h4>							
						 <p>学习中遇到问题怎么办？如果有名师随时在你身边，为你提供学习帮助，效率是否会事半功倍？强哥领导的技术服务团队，随时在线，通过电话，网络，远程控制等多种方式，解决你的所有疑难问题。</p>
				 </div>
				 <div class="clearfix"></div>
			 </div>
			 <div class="col-md-6 futr-grid">
				  <div class="icon-pic">
							<div class="icon text-center">
							 <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						 </div>
				  </div>
				  <div class="icon-info">
						<h4><a href="#">免费测试</a></h4>						 
						<p>勿在浮沙筑高楼!如果你感觉学起来很痛苦，总有一些问题连接不起来，那是因为你的基础没有打好。学完强哥的基础课程后，找强哥做一个基础测试，然后再接着往后学，你会感觉很多问题都豁然开朗。</p>
				  </div>
				  <div class="clearfix"></div>
			 </div>
			 <div class="clearfix"></div>
		 </div>
		 </div>
	 </div>
</div>
<div class="footer">
	 <div class="container">
		 <p>Copyright &copy; 2004 - 2016.IT精英会员俱乐部.All Rights Reserved.<a target="_blank" href="http://www.xinqushi.net"></a></p>
		 <div class="social">							
				<a href="#"><i class="facebook"></i></a>
				<a href="#"><i class="twitter"></i></a>
				<a href="#"><i class="dribble"></i></a>	
				<a href="#"><i class="google"></i></a>	
				<a href="#"><i class="youtube"></i></a>	
		 </div>
		 <div class="arrow">
			 <a class="scroll" href="#home"><img src="images/top.png" alt=""></a>
		 </div>
	 </div>
</div>
<!---->
<script type="text/javascript">
		$(document).ready(function() {
				/*
				var defaults = {
				containerID: 'toTop', // fading element id
				containerHoverID: 'toTopHover', // fading element hover id
				scrollSpeed: 1200,
				easingType: 'linear' 
				};
				*/
		$().UItoTop({ easingType: 'easeOutQuart' });
});
</script>
<a href="#to-top" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>
<!----> 


</body>
</html>