<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>体验者详细信息</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/H-ui_v3.0/js/H-ui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		/* 页面加载显示字母和提示  */
		$("#tag").show();
		$("#tag").removeClass();
		$("#tag").addClass("hui-fadeinL");

		/* 选择字母  */
		$(".letter").click(function() {
			$(".letter").css("color", "gray");
			$(this).css("color", "black");
			if ($("#choose").html().length >= 3) {
				$("#choose").html($("#choose").html()[1] + $("#choose").html()[2]);
			}
			$("#choose").append($(this).html());
			$.post("${pageContext.request.contextPath}/experience/getExperienceByPinyin.action", {
				pinyin : $("#choose").html()
			}, function(data) {
				if (data.status != 100) {
					layer.msg("对不起，发生了错误！", {icon: 2});
				} else {
					showNames(data.data);
				}
			});
		});

		/* 清除选择  */
		$("#emptied").click(function() {
			$("#choose").html("");
			$("#names").hide();
			$("#tab_demo").hide();
		});
	});

	/* 显示姓名  */
	function showNames(data) {
		var names = "";
		if (data.length > 0) {
			for (i = 0; i < data.length; i++) {
				names += "<input class='btn btn-success radius name' type='button' value='"
						+ data[i].name + "' lang='" + data[i].id + "'> ";
			}
		} else {
			names = "<h4><small>没有名字首字母为</small> " + $("#choose").html()
					+ " <small>的人！！！</small> </h4>";
		}
		$("#names").html(names);
		$("#names").show();
		$("#tab_demo").hide();
		$("#names").removeClass();
		$("#names").addClass("Huialert Huialert-success hui-fadeinL");
		showInfo();
	}

	/* 显示信息  */
	function showInfo() {
		$(".name").click(function() {
			$(".name").removeClass("active");
			$(this).addClass("active");
			$.Huitab("#tab_demo .tabBar span", "#tab_demo .tabCon",
					"current", "click", "0");
			$("#tab_demo").show();
			$("#tab_demo").removeClass();
			$("#tab_demo").addClass("hui-fadeinL");
			$("#info").load("${pageContext.request.contextPath}/admin/experiencer/personalInformation.jsp?eid=" + this.lang +"");
			$('#communication').load('${pageContext.request.contextPath}/experience/lookcommunication.jsp?id=' + this.lang +'&name=' + $(this).val() +'');
			$("#summary").load("${pageContext.request.contextPath}/admin/experiencer/experiencersummarys.jsp?name=" +"\""+ $(this).val() +"\"");
		});
	}
</script>
</head>
<body>
	<div id="tag" hidden>
		<div style="letter-spacing: 2px">
			<a class="letter f-24" style="color: black;">A</a>
			<a class="letter f-24" style="color: black;">B</a>
			<a class="letter f-24" style="color: black;">C</a>
			<a class="letter f-24" style="color: black;">D</a>
			<a class="letter f-24" style="color: black;">E</a>
			<a class="letter f-24" style="color: black;">F</a>
			<a class="letter f-24" style="color: black;">G</a>
			<a class="letter f-24" style="color: black;">H</a>
			<a class="letter f-24" style="color: black;">I</a>
			<a class="letter f-24" style="color: black;">J</a>
			<a class="letter f-24" style="color: black;">K</a>
			<a class="letter f-24" style="color: black;">L</a>
			<a class="letter f-24" style="color: black;">M</a>
			<a class="letter f-24" style="color: black;">N</a>
			<a class="letter f-24" style="color: black;">O</a>
			<a class="letter f-24" style="color: black;">P</a>
			<a class="letter f-24" style="color: black;">Q</a>
			<a class="letter f-24" style="color: black;">R</a>
			<a class="letter f-24" style="color: black;">S</a>
			<a class="letter f-24" style="color: black;">T</a>
			<a class="letter f-24" style="color: black;">U</a>
			<a class="letter f-24" style="color: black;">V</a>
			<a class="letter f-24" style="color: black;">W</a>
			<a class="letter f-24" style="color: black;">X</a>
			<a class="letter f-24" style="color: black;">Y</a>
			<a class="letter f-24" style="color: black;">Z</a>
		</div>
		<div>
			<h4>
				<input class="btn radius btn-warning" id="emptied" value="清空选择" type="button"> 
				您的选择:<strong id="choose" style="letter-spacing: 8px"></strong>
			</h4>
		</div>
	</div>
	<div id="names" class="Huialert Huialert-success" hidden></div>
	<div id="tab_demo" hidden>
		<div class="tabBar clearfix">
			<span>基本信息</span><span>周报信息</span><span>沟通信息</span>
		</div>
		<div class="tabCon" id="info">内容一</div>
		<div class="tabCon" id="summary">暂无此功能</div>
		<div class="tabCon" id="communication">内容三</div>
	</div>
</body>
</html>