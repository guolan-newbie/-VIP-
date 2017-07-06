<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html>
<html>
<head lang="zh-CN">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>注册用户-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>

<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
	
<script src="${pageContext.request.contextPath}/bootstrap/bootstrapvalidator/bootstrapValidator.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/bootstrapvalidator/bootstrapValidator.css">
<script type="text/javascript">
	$(document).ready(function() {
		function randomNumber(min, max) {
			return Math.floor(Math.random() * (max - min + 1) + min);
		};
		
		$('#captchaOperation').html([ randomNumber(1, 100), '+', randomNumber(1, 200), '=' ].join(' '));
		
		$('#defaultForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			/* submitHandler: function (validator, form, submitButton) {
				$.post(form.attr('action'), form.serialize(), function(result) {
	    				parent.location.href="${pageContext.request.contextPath}/member/navbar1.jsp";
		    			parent.layer.close(index);
			    }, 'json');
            }, */
			fields : {
				name : {
					validators : {
						notEmpty : {
							message : '账户不能为空'
						},
						regexp: {
	                        regexp: /^\d{3,}$/,
	                        message: '用户名必须是会员号!'
	                    },
						different : {
							field : 'pwd',
							message : '账户和密码不能相同'
						},
						remote : {
							type : 'POST',
							url : '${pageContext.request.contextPath}/user/checkExists.action',
							message : '该账户已被注册',
							delay : 2000
						},
					}
				},
				pwd : {
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						different : {
							field : 'name',
							message : '账户和密码不能相同'
						}
					}
				},
				confirmPassword : {
					validators : {
						notEmpty : {
							message : '重复密码不能为空'
						},
						identical : {
							field : 'pwd',
							message : '两次密码不一致'
						},
						different : {
							field : 'name',
							message : '账户和重复密码不能相同'
						}
					}
				},
				captcha : {
					validators : {
						callback : {
							message : '答案错误',
							callback : function(value, validator) {
								var items = $('#captchaOperation').html().split(' '), sum = parseInt(items[0])+ parseInt(items[2]);
								return value == sum;
							}
						}
					}
				}
			}
		});
		
		$('#resetBtn').click(function() {
			$('#defaultForm').data('bootstrapValidator').resetForm(true);
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<div class="page-header">
                	<h2>注册用户</h2>
                </div>
				<form id="defaultForm" method="post" class="form-horizontal" action="${pageContext.request.contextPath}/member/addUserTwo.action">

					<div class="form-group">
						<label class="col-lg-3 control-label">账号</label>
						<div class="col-lg-5">
							<input type="text" class="form-control" name="name" required autofocus />
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-3 control-label">密码</label>
						<div class="col-lg-5">
							<input type="password" class="form-control" name="pwd" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-3 control-label">重复密码</label>
						<div class="col-lg-5">
							<input type="password" class="form-control" name="confirmPassword" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-3 control-label" id="captchaOperation"></label>
						<div class="col-lg-2">
							<input type="text" class="form-control" name="captcha" />
						</div>
					</div>

					<div class="form-group">
						<div class="col-lg-9 col-lg-offset-3">
							<button type="submit" class="btn btn-primary" name="signup" value="Sign up">注册</button>
							<button type="button" class="btn btn-info" id="resetBtn">重置</button>
							<a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">首页</a>
							<a href="${pageContext.request.contextPath}/user/login.jsp" class="btn btn-primary">登陆</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>