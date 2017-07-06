<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>会员进度-Java互助学习VIP群业务运行系统</title>
<link
	href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<style>
div .show {
	position: absolute;
	margin-left: 60px
}

div .delete {
	position: absolute;
	margin-left: 6px
}
</style>
<script type="text/javascript">
	$(function() {
		var page2 = 1;
		getData(page2);
		var list;
		var flag = false;
		function getData(page2) {
			$.ajaxSetup({
				async : false
			});
			$
					.post(
							"${pageContext.request.contextPath}/picture/getAllFlagUserCoverByPage.action",
							{
								page2 : page2
							}, function(data) {
								//alert(data);
								var dataObj = eval("(" + data + ")");
								var navbar = dataObj.returnMap.navbar;
								var tatolCount = dataObj.returnMap.totalCount;
								list = dataObj.returnMap.list;
								$(".page-nav").html(navbar);
								$("#num").html(tatolCount);
								//drawTable(list);
								btnclick();
							});
			drawTable(list);
		}
		//分页按钮点击事件
		function btnclick() {
			$(".nav-btn").click(function() {
				page2 = this.lang;
				getData(page2);
			})
		}
		function drawTable(data) {
			$(".big_div").html("");
			var img = "";
			var photoObj;
			for (i = 0; i < data.length; i++) {
				var line = "";
				line = line + "<div class='content'>";
				if (data[i].member.sex == "男") {
					img = "<img src='${pageContext.request.contextPath}/images/user_male.png' class='photo' lang=" + data[i].id +">";
				} else {
					img = "<img src='${pageContext.request.contextPath}/images/user_female.png' class='photo' lang=" + data[i].id +">";
				}
				line = line + img;
				line = line + "<div class='text'>" + data[i].user.name
						+ "</div>";
				line = line + "<div class='text'>" + data[i].member.name
						+ "</div>";
				line = line
						+ "<div align='center'><a href='javascript:void(0)'  class='show' lang="
						+ data[i].id + "@" + data[i].member.name + ">审核</a>";
				line = line
						+ "<a href='javascript:void(0)' class='delete' lang="
						+ data[i].id + "@" + data[i].member.name
						+ ">删除</a></div>";
				line = line + "</div>";
				$(".big_div").append(line);
			}
			$(".photo")
					.each(
							function() {
								var src = "";
								if ($(this).attr("lang") != 0
										|| $(this).attr("lang") != "0") {
									src = "${pageContext.request.contextPath}/picture/getPictureByid.action?id="
											+ $(this).attr("lang");
									$(this).attr("src", src);
								}
							});
		}
		$(".show")
				.click(
						function() {
							var str = this.lang.split("@");
							var del = $(this);
							layer
									.confirm(
											'您确定要审核通过【 ' + str[1] + ' 】的这张图片吗？',
											{
												btn : [ '是', '否' ]
											},//按钮一的回调函数
											function() {
												$.ajaxSetup({
													async : false
												});
												$
														.post(
																"${pageContext.request.contextPath}/picture/flag.action",
																{
																	id : str[0]
																},
																function() {
																	layer
																			.msg(
																					'审核成功',
																					{
																						icon : 1,
																						time : 1000
																					},
																					function() {
																					});
																	$(".wrap")
																			.load(
																					"${pageContext.request.contextPath}/admin/checkimage1.jsp");
																	//del.parent().parent().hide();
																	/*$.each(list,function(index,item){ 
																		 if(item.id==str[0]){
																				 list.splice(index,1);
																				 drawTable(list);										 
																		}
																	});*/
																})
											});
						});
		$(".delete")
				.click(
						function() {
							var str = this.lang.split("@");
							var del = $(this);
							layer
									.confirm(
											'您确定要删除【 ' + str[1] + ' 】的这张图片吗？',
											{
												btn : [ '是', '否' ]
											},//按钮一的回调函数
											function() {
												$
														.post(
																"${pageContext.request.contextPath}/picture/delete.action",
																{
																	id : str[0]
																},
																function(data) {
																	layer
																			.msg(
																					'删除成功',
																					{
																						icon : 1,
																						time : 1000
																					},
																					function() {
																					});
																});
												/*	layer.closeAll('dialog');
													var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
													parent.layer.close(index);
													}); */
												$(".wrap")
														.load(
																"${pageContext.request.contextPath}/admin/checkimage1.jsp");
												//del.parent().parent().hide();
												/*$.each(list,function(index,item){ 
													 if(item.id==str[0]){
															 list.splice(index,1);
															 drawTable(list);
													}
												}); */
											});
						});
	});
</script>
<style type="text/css">
.big_div {
	
}

.content {
	width: 180px;
	height: 280px;
	border: 1px solid silver;
	float: left;
	margin-left: 15px;
	margin-top: 15px;
}

.photo {
	width: 150px;
	height: 150px;
	border-radius: 100px;
	margin-left: 15px;
	margin-top: 15px;
}

.text {
	margin-top: 5px;
	text-align: center;
	color: #666666;
}
</style>
</head>
<body>
	<h1 style="text-align: center">会员照片审核</h1>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="r">共有数据：<strong id="num"></strong> 条
			</span>
		</div>
		<div class="mt-20">
			<div class='big_div'></div>
		</div>
	</div>
	<div style="clear: both"></div>
	<div class='page-nav' style="margin-top: 20px; padding-right: 120px"></div>

</body>
</html>