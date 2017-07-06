<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>专享福利-专注建立IT精英圈子</title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".para").css('display', 'none');
		$(".title").click(function() {
			$(".para").css('display', 'none');
			$(this).next().slideDown(2000);
		})
	})
</script>
</head>

<body>
	<div id="main">
		<jsp:include page="nav.jsp"></jsp:include>
		<div id="site_content">
			<div id="sidebar_container">
				<div class="sidebar">
					<div class="sidebar_top"></div>
					<div class="sidebar_item">
						<!-- insert your sidebar items here -->
						<h3>最新消息</h3>
						<h4>入职信息</h4>
						<h5>2015-12-24</h5>
						<p>
							恭喜本周010号会员入职中石化企业参与CRM项目组开发.....&nbsp;<a href="#">read more</a>
						</p>
					</div>
					<div class="sidebar_base"></div>
				</div>
				<div class="sidebar"></div>
			</div>
			<div id="content">
				<h4 class="title">1.学习完《Java基础入门》，即听强哥说Java之《J2SE轻松入门-第一季》，且通过基础测试考核后，即可获得试学体验资格。</h4>
				<h4 class="title">2.体检者加入“Java互助学习VIP二群”(495815877)和“IT技术互助学习交流群”(344837006)。体验者进去需按“所在省份-真实姓名”修改群名片。并在两个群中简要介绍一下自己所在的学校专业/从事的行业，增进了解，便于后续的交流。Android专业前期课程和Java
					Web专业前期课程相同，体验也加入这两个群。</h4>
				<h4 class="title">3.“Java互助学习VIP二群”为IT精英会员部终身会员群。“IT技术互助学习交流群”是一个更大的圈子，包括所有VIP会员，行业专家，Java初学者等。两个群都是实名交流群。</h4>
				<h4 class="title">4.体验学习周期为两周，可以提前学完，但不允许延长。学习两周后，如果觉得非常好，可以报名参加VIP课程的学习。觉得不好或者因为个人其他原因不想加入VIP，可以自行退出VIP群，不需要说明任何理由。</h4>
				<h4 class="title">5.体验期间学习内容为《J2SE轻松入门》第二季和第三季的内容。第二季共有12个视频，第三季共有15个视频。每个视频时长大约25分钟。课程比较精炼，这三季课程学完后，就已经掌握了Java项目开发所需的所有基础知识。</h4>
				<h4 class="title">6.体验期间，学习中遇到问题随时联系技术团队老师答疑解惑，务必做到对每个知识点深入理解，达到能够背着做出每个案例，且能根据所学知识，结合查资料解决同类问题的程度。我们技术支持团队随时都在，你随时可以获取帮助。</h4>
				<h4 class="title">7.体验期间安排学习小助手和体验者保持交流，了解学习情况和学习进度，解决与学习相关的一些困惑。</h4>
				<h4 class="title">8.体验者必须合理安排时间，按规定课程学习，积极提问，与其他VIP会员交流，体验期间不按体验课程学习者，我们有权随时终止体验资格。</h4>
				<h4 class="title">9.体验者每周周日晚上12:00之前需要使用用户名888，密码888登录http://xinqushi.net，提交一周的学习内容，学习感悟，遇到的问题，解决的办法。多个体验者同时体验时，所有体验者的周报都通过以上账户登录提交，并注明体验者的姓名。</h4>
				<h4 class="title">10.体验期间，强哥团队所有工作人员的工作内容是帮助体验者了解我们的课程，收费标准，就业政策，选择我们的优势，任何工作人员不得带有倾向性的向体验者兜售我们的VIP课程。有违反规定者请向强哥举报。</h4>
				<h4 class="title">11.第二季下载地址：http://pan.baidu.com/s/1bpDfI9p
					密码：j1c7，第三季下载地址：链接：http://pan.baidu.com/s/1csjbY2 密码：l8hs。</h4>
				<h4 class="title">12.体验学习需要下载最新版鹏保宝软件，鹏保宝软件可以在电脑或者手机上运行。http://www.pyc.com.cn/Application/download.aspx，下载时，请选择“我是买家”。</h4>
				<h4 class="title">13.申请体验学习需缴纳10元管理费，通过支付宝转账到“听强哥说Java”，账号：wizeman@126.com。</h4>
				<h4 class="title">14.相关工作人员联系方式</h4>
				<table>
					<tr>
						<td>序号</td>
						<td>姓名</td>
						<td>分工</td>
						<td>QQ</td>
						<td>联系电话</td>
					</tr>
					<tr>
						<td>1</td>
						<td>张中强</td>
						<td>技术支持</td>
						<td>7123043</td>
						<td>010-68778788-8001</td>
					</tr>
					<tr>
						<td>2</td>
						<td>王波</td>
						<td>技术支持</td>
						<td>1750214342</td>
						<td>010-68778788-8002</td>
					</tr>
					<tr>
						<td>3</td>
						<td>胡X</td>
						<td>课程督导</td>
						<td>596895050</td>
						<td>010-68778788-8003</td>
					</tr>
					<tr>
						<td>4</td>
						<td>冷XX</td>
						<td>课程督导</td>
						<td>2465627215</td>
						<td>010-68778788-8004</td>
					</tr>
					<tr>
						<td>5</td>
						<td>陶XX</td>
						<td>课程督导</td>
						<td>1023010216</td>
						<td>010-68778788-8005</td>
					</tr>
					<tr>
						<td>6</td>
						<td>蒋XX</td>
						<td>课程督导</td>
						<td>1054381720</td>
						<td>010-68778788-8006</td>
					</tr>
					<tr>
						<td>7</td>
						<td>许XX</td>
						<td>课程督导</td>
						<td>1239035729</td>
						<td>010-68778788-8007</td>
					</tr>
					<tr>
						<td>8</td>
						<td>张X</td>
						<td>课程督导</td>
						<td>1390827318</td>
						<td>010-68778788-8008</td>
					</tr>
				</table>
			</div>
		</div>
		<jsp:include page="footer.jsp" />
		<p>&nbsp;</p>
	</div>
</body>
</html>
