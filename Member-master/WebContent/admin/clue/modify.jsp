<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/jquery-validation-1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/jquery-validation-1.16.0/lib/jquery.form.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<title>修改体验者信息</title>
<script type="text/javascript">
	$(function() {
		$.ajaxSetup({
			async : false
		});
		
		/* 获取线索用户信息 */
		$.post("${pageContext.request.contextPath}/clue/getClueById.action", {id : $("[name='id']").val()}, function(data) {
			if (isDataStatus(data)) {
				showData(data.data);
			}
		});
		
		/* 手机号码验证 */
		$.validator.addMethod("isMobile", function(value, element) {
			var length = value.length;
			var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
		}, "手机号输入有误！");
		
		/* 表单验证  */
		$("#modify").validate({
			rules : {
				id : "required",
				aid : "required",
				num : "required",
				qq : "required",
				bdate : {
					required : true,
					date : true,
					dateISO : true
				},
				realName : {
					maxlength : 15,
				 	minlength : 2
				},
				phone : "isMobile",
				gdate : {
					date : true,
					dateISO : true
				},
			},
			messages : {
				id : "服务器发生异常！",
				aid : "服务器发生异常！",
				num : "服务器发生异常！",
				qq : "服务器发生异常！",
				bdate : {
					required : "开始时间不能为空!",
					date : "开始时间格式不正确！"
				},
				realName : {
					maxlength : "真实姓名最多15个字符(汉字算一个字符)！",
					minlength : "真实姓名最少2个字符(汉字算一个字符)！"
				},
				phone : "手机号输入有误！",
				gdate : "毕业时间格式不正确！"
			},
			errorLabelContainer : $("#modify div.error"),
			errorElement : "em",
			submitHandler : function(form) {
				$(form).ajaxSubmit( {
					type : "post",
					url : "${pageContext.request.contextPath}/clue/modify.action",
					data : {
						btime : new Date($("[name='bdate']").val())
					},
					success : function(data) {
						if (isDataStatus(data)) {
							parent.$("#flag").val("1");
							parent.layer.closeAll();
						}
					}
				});
			}
		});
		
		/* 显示线索用户信息 */
		function showData(data) {
			$("[name='num']").val(data.num);
			$("[name='qq']").val(data.qq);
			$("[name='aid']").val(data.aid);
			$("[name='realName']").val(isBlank(data.realName));
			$("[name='bdate']").val(new Date(data.btime).pattern("yyyy-MM-dd"));
			if (data.sex == "男") {
				$("input[name='sex']:eq(0)").attr("checked", 'checked');
			} else if (data.sex == "女") {
				$("input[name='sex']:eq(1)").attr("checked", 'checked');
			} else {
				$("input[name='sex']:eq(2)").attr("checked", 'checked');
			}
			$("[name='school']").val(isBlank(data.school));
			$("[name='diploma']").val(isBlank(data.diploma));
			$("[name='phone']").val(isBlank(data.phone));
			$("[name='school']").val(isBlank(data.school));
			$("[name='gdate']").val(datePattern(data.graduateDate));
			if (data.type) {
				$("input[name='type']:eq(0)").attr("checked", 'checked');
			} else {
				$("input[name='type']:eq(1)").attr("checked", 'checked');
			}
		}
	});
</script>
</head>
<body>
	<div class="container">
		<div class="panel panel-secondary">
			<div class="panel-header text-c">线索人物信息</div>
			<div class="panel-primary">
				<form id="modify">
					<input type="hidden" name="id" value="${param.id}">
					<input type="hidden" name="aid">
					<table class="table table-border table-hover radius">
						<tr>
							<th>用户名</th>
							<td>
								<input name="num" type="text" readonly style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>QQ号码</th>
							<td>
								<input name="qq" type="text" readonly style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>性别</th>
							<td>
								<input type="radio" name="sex" value="男" checked><label>男</label>
								<input type="radio" name="sex" value="女" style="margin-left: 20px"><label>女</label>
								<input type="radio" name="sex" value="不详" style="margin-left: 20px"><label>不详</label>
							</td>
						</tr>

						<tr>
							<th>开始时间</th>
							<td>
								<input type="text" name="bdate" style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>真实姓名</th>
							<td>
								<input name="realName" type="text" style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>所在学校</th>
							<td><input name="school" type="text" style="width: 200px"
								class="input-text radius" /></td>
						</tr>

						<tr>
							<th>学历</th>
							<td>
								<input name="diploma" type="text" style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>手机号</th>
							<td>
								<input name="phone" type="text" style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>毕业时间</th>
							<td>
								<input type="text" name="gdate" style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>是否学生</th>
							<td>
								<input type="radio" name="type" value="1" checked><label>是</label>
								<input type="radio" name="type" value="0" style="margin-left: 20px"><label>否</label>
							</td>
						</tr>

						<tr>
							<td colspan="2">
								<div class="error" style="color: red; font-weight: bold; font-size: 15px;" align="center"></div>
							</td>
						</tr>

						<tr>
							<td colspan="2">
								<div align="center">
									<button type="submit" class="btn btn-success radius" id="modify">保存修改</button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>