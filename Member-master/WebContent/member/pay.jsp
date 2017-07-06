<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>

<link href="${pageContext.request.contextPath}/resources/uikit-2.25.0/css/uikit.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/uikit-2.25.0/js/uikit.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>

<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
<style type="text/css">
#fee, #feesum, #interest {
	display: inline;
}

#pay, #date {
	width: 100px;
}

#none {
	padding-left: 30px;
	font-size: 16px;
	font-weight: bold;
}
.photo{
	max-height: 100%;
	max-width: 100%;
	width: auto;
	height:500px;
}
</style>
<script type="text/javascript">
	function showData() {
		if ($("#isFee").val() == "true") {
			return;
		} else {
			$.post("${pageContext.request.contextPath}/member/getdata.action", {id : $("#mid").val(), date : $("#date").val()}, function(data) {
				infos = data.split("!");
				$("#fee").html(infos[0]);
				$("#interest").html(infos[1]);
				$("#feesum").html(infos[2]);
			});
		}
	}
	var type = "1px*1px";
	function getSize(img) {
		var image = new Image();
		image.src = img.src;
		var ratio = 0;
		var height= 0;
		var width= 0;
		if(image.height >= image.width) {
			ratio = image.height/400;
		} else {
			ratio = image.width/500;
		}
		height = image.height/ratio;
		width = image.width/ratio;
		type = height + "px*" +width + "px";
		//layer.msg(type);
	}
	var fileflag = 0;
	function photo(file,id) {
		var filename = file.value;
		var mime = file.value.toLowerCase().substr(file.value.lastIndexOf("."));
		if (mime == ".jpg" || mime == ".png" || mime == ".gif" || mime == ".jpeg") {
			if (file.files[0].size / (1024 * 1024) > 1) {
				layer.msg("请上传小于1MB的图片!!!");
				return;
			}
			var prevDiv = document.getElementById(id);
			if (file.files && file.files[0]) {
				var reader = new FileReader();
				reader.onload = function(evt) {
					if(id == "photo") {
						prevDiv.innerHTML = '<div style="width:400px;height:200px"><img src="' + evt.target.result + '" class="photo" onload="getSize(this);"/></div>';
					} else {
						var image = new Image();
						image.src = evt.target.result;
						var ratio = 0;
						var height= 0;
						var width= 0;
						if(image.height >= image.width) {
							ratio = image.height/400;
						} else {
							ratio = image.width/500;
						}
						height = image.height/ratio;
						width = image.width/ratio;
						type = height + "px*" +width + "px";
						prevDiv.innerHTML = '<img src="' + evt.target.result + '"style="height:' + height + 'px;width:' + width + 'px;" />';
					}
				}
				reader.readAsDataURL(file.files[0]);
				fileflag = 1;
			}
		} else {
			fileflag = 0;
			layer.msg("请选择图片格式的文件上传(jpg,png,gif,jpeg)");
		}
	}
	$(function() {
		showData();
		$("#preview").click(function() {
			showData();
		});
		$("#important").click(function() {
			var index = layer.open({
				type : 2,
				title : '信息显示',
				area : [ '600px', '505px' ],
				skin : 'layui-layer-rim',
				shift : 5,
				maxmin : true,
				content : '${pageContext.request.contextPath}/member/important.jsp'
			});
		});
		$("#go").click(function() {
			var s = $.trim($("#pay").val());
			var r = /\d+(\.\d+)?$/;
			if (s == "" || !r.test(s)) {
				$("#infoshow").html("您的输入有误!");
				return;
			}
			if (parseFloat($("#pay").val()) > parseFloat($("#feesum").html())) {
				$("#infoshow").html("输入金额超过了应交费用总金额!");
				return;
			}
			
			var msgstr = "你确定缴费的时间为【" + new Date($("#date").val()).pattern("yyyy-MM-dd") + "】";
			if(!confirm(msgstr)) {
				return ;
			}
			
			var flag = 0;
			$.ajax({
				url : '${pageContext.request.contextPath}/member/checkdate.action',
				type : 'POST',
				data : {date:$("#date").val()},
				async : false,
				success : function(data) {
					if(data != "100") {
						if(data == "202") {
							layer.msg("<strong style='color:red;'>非法操作</strong>", {icon: 2});
							flag = 1;
						}
						var srt = data.split("&");
						if(srt[0] == "101") {
							layer.msg("时间应该在[<strong style='color:red;'>" + srt[1] + "</strong>]之后！", {icon: 0});
							$("#date").focus();
							flag = 1;
						}
					} else {
						var fd = new FormData();
						if (fileflag == 1) {
							fd.append("file",$("#file")[0].files[0]);
							fd.append("type",type);
						}
						fd.append("date",$("#date").val());
						fd.append("fileflag",fileflag);
						fd.append("pay", $("#pay").val());
						$.ajax({
							url : '${pageContext.request.contextPath}/member/paying.action',
							type : 'POST',
							data : fd,
							async : false,
							cache : false,
							contentType : false,
							processData : false,
							success : function(data) {
								if(data == "202") {
									layer.msg("<strong style='color:red;'>非法提交!</strong>", {icon: 2});
								} else {
									layer.msg('提交成功，请等待管理员审核', {icon: 1});
								}
							},
							error : function() {
								layer.msg("<strong style='color:red;'>出错了!!!</strong>", {icon: 2});
							}
						});
					}
				},
				error : function() {
					layer.msg("<strong style='color:red;'>出错了!!!</strong>", {icon: 2});
				}
			});
			
			if(flag == 1)
				return ;
			
			$(".wrap").load("${pageContext.request.contextPath}/member/pay.jsp");

			/* $.post("${pageContext.request.contextPath}/member/paying.action", {
				pay : $("#pay").val(),
				date : $("#date").val()
			}, function(data) {
				$("#infoshow").html(data);
				$("#go").removeClass("btn btn-primary radius");
				$("#go").addClass("btn disabled radius");
				$("#go").attr("disabled", true);
				$("#file").attr("disabled", true);
				setTimeout("$('#file').attr('disabled', false);$('#infoshow').html('如果上传凭证,管理员审核会更快呦');", 1000 * 60);
			}); */
		});
		$.post("${pageContext.request.contextPath}/member/getByMidAndFlag.action",{mid : $("#mid").val()},function(data) {
			var dataObj = eval("("+data+")");
			var lists = dataObj.returnMap.list;
			var lines = "";
			if(lists.length==0) {
				lines += "<center><h2 style='color:red;'>没有未审核的缴费</h2></center>";
			} else {
				lines += "<caption><center><h3>未审核的缴费</h3></center></caption>";
				lines += "<thead  class='text-c'><tr>";
				lines += "<th>序号</th>";
				lines += "<th>交费日期</th>";
				lines += "<th>交费金额</th>";
				lines += "<th>操作</th>";
				lines += "</tr></thead>";
				for(i = (lists.length - 1); i >= 0; i--){
					lines += "<tr  class='text-c'>";
					lines += "<td>" + (lists.length - i) + "</td>";			
					lines += "<td>" + lists[i].formatDate + "</td>";
					lines += "<td>" + lists[i].amount + "</td>";
					var date = lists[i].formatDate.split(" ");
					var str = lists[i].id + "," + lists[i].member.id + "," + lists[i].amount + "," + date[0] + "&nbsp;" + date[1] + "," + lists[i].fileflag + "," + lists[i].upflag + "," + lists[i].type;
					lines += "<td><input type='button' value='修改' class='btn btn-primary modify' lang=" + str + ">\t<input type='button' value='删除' class='btn btn-danger del' lang=" + str + "></td>";
					//lines += "<td>" + "<input class='btn radius btn-warning' type='button' value='修改' id='modify' lang = " + lists[i].id + ">" + "</td>";
					lines += "</tr>";
				}
			}
			$("#period").html(lines);
		});
		$(".modify").click(function() {
			var str = this.lang.split(",");
			var s1 = "<div style='white-space: nowrap'>缴费金额：<input type='text' name='amount' id='paymod' value='" + str[2] + "'>";
			s1 += "缴费日期：<input type='text' id='datemod' placeholder='缴费日期' value='" + str[3] + "'>"
			var s2 = "<input id='filemod' type='file' onchange=\"photo(this,'photomod')\" style='display: none'>";
			s2 += "<a class='btn btn-primary radius' onclick=\"$('#filemod').click();\"><i class='Hui-iconfont'>&#xe642;</i>上传图片</a></div>";
			if (str[4] == "1") {
				var ratio = str[6].split("*");
				s2 += "<div id='photomod'><img src='${pageContext.request.contextPath}/member/getPhoto.action?accountLogId=" + str[0] + "&random=" + Math.random() + "' style='height:" + ratio[0] + ";width:" + ratio[1] + ";'></div>";
			} else {
				s2 += "<div id='photomod'></div>"
			}
			layer.confirm(s1 + s2, {
				btn : [ '确定', '放弃' ],
				area : '550px'
			}, function() {
				$.ajax({
					url : '${pageContext.request.contextPath}/member/checkdate.action',
					type : 'POST',
					data : {date:$("#datemod").val()},
					async : false,
					success : function(data) {
						if(data != "100") {
							if(data == "202") {
								layer.msg("<strong style='color:red;'>非法操作</strong>", {icon: 2});
							}
							var srt = data.split("&");
							if(srt[0] == "101") {
								layer.msg("时间应该在[<strong style='color:red;'>" + srt[1] + "</strong>]之后！", {icon: 0});
							}
						} else {
							var fd = new FormData();
							if (fileflag == 1) {
								fd.append("file",$("#filemod")[0].files[0]);
								fd.append("type",type);
							}
							fd.append("date",$("#datemod").val());
							fd.append("fileflag",fileflag);
							fd.append("pay", $("#paymod").val());
							fd.append("upflag",str[5]);
							fd.append("accountlogID",str[0]);
							//alert($("#datemod").val() + ":" + fileflag + ":" + $("#paymod").val() + ":" + str[5] + ":" + str[0]);
							$.ajax({
								url : '${pageContext.request.contextPath}/member/modifypay.action',
								type : 'POST',
								data : fd,
								async : false,
								cache : false,
								contentType : false,
								processData : false,
								success : function(data) {
									if(data != "100") {
										if(data == "202") {
											layer.msg("<strong style='color:red;'>非法提交!</strong>", {icon: 2});
										} else {
											layer.msg("<strong style='color:red;'>操作失败,数据不是最新的或者被删除!</strong>", {icon: 2});
											$(".wrap").load("${pageContext.request.contextPath}/member/pay.jsp");
										}
									} else {
										layer.msg('提交成功，请等待管理员审核', {icon: 1});
										$(".wrap").load("${pageContext.request.contextPath}/member/pay.jsp");
									}
								},
								error : function() {
									layer.msg('出错了!!!', {icon: 2});
								}
							});
						}
					},
					error : function() {
						layer.msg("<strong style='color:red;'>出错了!!!</strong>", {icon: 2});
					}
				});
			});
		});
		$(".del").click(function() {
			var str = this.lang.split(",");
			var s1 = "你确定要<b style='color:red;'>删除</b>在【" + str[3] + "】时，金额为【<b style='color:red;'>" + str[2] + "</b>】的缴费?";
			var s2 = "";
			if (str[4] == "1") {
				var ratio = str[6].split("*");
				s2 += "<img src='${pageContext.request.contextPath}/member/getPhoto.action?accountLogId=" + str[0] + "&random=" + Math.random() + "' style='height:" + ratio[0] + ";width:" + ratio[1] + ";'>";
			}
			layer.confirm(s1 + s2,{
				btn : [ '确定', '放弃' ],
				area : [ '500px' ]
			},function() {
				$.post("${pageContext.request.contextPath}/member/deleteLog.action",{id : str[1], accountlogID : str[0], upflag : str[5]}, function(data) {
					layer.closeAll();
					if(data == "1") {
						layer.msg("<strong style='color:red;'>操作失败,数据已被删除</strong>", {icon: 2});
					} else if(data == "2") {
						layer.msg("<strong>数据不是最新的，请等待刷新后再审核</strong>", {icon: 0});
					}
					$(".wrap").load("${pageContext.request.contextPath}/member/pay.jsp");
				});
			});
		});
	});
</script>
</head>
<body>

	<input type="hidden" id="mid" value="${myuser.member.id}">
	<%-- <input type="hidden" value="0" id="status">
    <input type="hidden" value="${myuser.member.alog}" id="al og"> --%>
	<input type="hidden" value="${myuser.member.fee}" id="isFee">
	<table style="width: 800px;height:300px">
		<tr>
			<td align="center"><h3>费用信息</h3></td>
			<td align="center"><h3>凭证预览</h3></td>
		</tr>
		<tr>
			<td align="left" valign="top">
				<c:choose>
					<c:when test="${myuser.member.fee && myuser.member.restInterest>0}">
						<div id="none">您已经结清了所有费用！！！当前剩余利息：${myuser.member.restInterest}</div>
						<br />
					</c:when>
					<c:otherwise>
						每月协议交费日期：<b><mark> <fmt:formatDate value="${myuser.member.time}" pattern="dd日" /> <br /></mark></b>
				  		截止今日应缴本金：<div id="fee"></div>
				 		已交费用累积利息：
				 		<div id="interest">
							<c:if test="${myuser.member.fee}">${myuser.member.restInterest}</c:if>
						</div>
						<br />
				  		 结清所有费用总额：
						<div id="feesum"></div>
							<c:if test="${myuser.member.fee}">${-myuser.member.restInterest}</c:if>
						<br />
				    	缴费金额：
				    	<input type="text" name="amount" id="pay">
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="time" />
				    	缴费日期：
				    	<input type="text" id="date" placeholder="缴费日期" value="${time}">
						<br />
						<input type="button" id="important" value="重要提示" class="btn btn-danger radius">
						<input type="button" value="缴费预览" id="preview" class="btn btn-secondary radius">
						<input type="button" value="确认缴费" id="go" class="btn btn-primary radius">
						<div id="infoshow" style="color: red;">如果上传凭证,管理员审核会更快呦。</div>
					 	备注：利息在所有本金交清后结算，后面的费用比约定早交可以抵消利息！！！！
					</c:otherwise>
				</c:choose>
			</td>
			<td align="left" valign="top" style="width: 400px">
				<input id="file" type="file" onchange="photo(this,'photo')" class="form-control" style="display: none">
				<a class="btn btn-primary radius" onclick="$('#file').click();"><i class="Hui-iconfont">&#xe642;</i>上传图片</a>
				<div id="photo"></div>
			</td>
		</tr>
	</table>
	<div class="uk-overflow-container">
		<table id="period" class="table table-border table-bordered table-bg table-hover table-sort"></table>
	</div>
	
</body>
</html>