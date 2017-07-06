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
<title>添加体验者</title>
<script type="text/javascript">
	$(function() {
		$.ajaxSetup({
			async : false
		});
		
		/* 获取线索用户编号  */
		$.post("${pageContext.request.contextPath}/clue/getNum.action", function(data) {
			$("[name='num']").val(data);
		});
		/* 给开始时间设个初始值  */
		$("[name='date']").val((new Date()).pattern('yyyy-MM-dd'));

		/* 表单验证  */
		$("#add").validate({
			rules : {
				num : "required",
				qq : {
					required : true,
					digits : true,
					rangelength : [ 5, 10 ],
					remote : {
						url : "${pageContext.request.contextPath}/clue/checkQq.action", //后台处理程序
						type : "post", //数据发送方式
						dataType : "json", //接受数据格式   
						data : { //要传递的数据
							qq : function() {
								return $("[name='qq']").val();
							}
						}
					}
				},
				date : {
					required : true,
					date : true,
					dateISO : true
				}
			},
			messages : {
				num : "服务器发生异常！",
				qq : {
					required : "qq号不能为空!",
					digits : "请输入正确的qq号!",
					rangelength : "请输入5~10个数字的qq号",
					remote : "该qq号已经存在"
				},
				date : {
					required : "开始时间不能为空!",
					date : "时间格式不正确"
				}
			},
			errorLabelContainer : $("#add div.error"),
			errorElement : "em",
			submitHandler : function(form) {
				$(form).ajaxSubmit({
					type : "post",
					url : "${pageContext.request.contextPath}/clue/add.action",
					data : {
						btime : new Date($("[name='date']").val())
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
	});
</script>
</head>
<body>
	<div class="container">
		<div class="panel panel-secondary">
			<div class="panel-header text-c">线索人物信息</div>
			<div class="panel-primary">
				<form id="add">
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
								<input name="qq" type="text" style="width: 200px" class="input-text radius" />
							</td>
						</tr>

						<tr>
							<th>开始时间</th>
							<td>
								<input type="text" name="date" placeholder="必填项" class="input-text radius" style="width: 200px" />
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
									<button type="submit" class="btn btn-success radius" id="add">提交</button>
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