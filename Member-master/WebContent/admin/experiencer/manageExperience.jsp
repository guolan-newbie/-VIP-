<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户审核-Java互助学习VIP群业务运行系统</title>
	
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	var page=1;
	var status =0;
	var aId=0;
	var qq="";
	$(function(){
		$.ajaxSetup({async : false});
		
		/* 页面一加载获取的全部信息*/
		getData(status,qq,aId,page);
		
		/*获取不同状态体验者*/
		$(".butname").click(function(){
			var buttons =$(".butname");
			buttons.removeClass("active");
		    $(this).addClass("active");
			status=this.lang;
			$("#estatus").val(status);
			aId=$("[name='assistant']").val();
			qq=$("#qq").val();
			getData(status,qq,aId,page);
		});
		
		/*选择小助手查询*/
		$("[name='assistant']").change(function() {
			aId=$("[name='assistant']").val();
			status=$("#estatus").val();
			qq=$("#qq").val();
			getData(status,qq,aId,page);
		});
		
		/*qq号查询*/
		$("#qqsearch").click(function(){
			var buttons =$(".butname");
			buttons.removeClass("active");
			$("[name='assistant']").val(0);
			qq=$("#qq").val();
			getData(0,qq,0,page);
		});
		
		
		/*用于显示的数据*/
		function getData(status,qq,aId,page){
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/experience/getExperienceList.action",{status:status,qq:qq,aId:aId,page:page},function(data){
				if (isDataStatus(data)) {	
					drawTable(data.data);
					$("#paging").html(showpage(data.page, data.count));
					btnPage();
					lookCommunicationclick();
					addCommunicationclick();
					joinclick();
					previpclick();
					leftclick();
					resetclick();
					deleteclick()
					addclick();
					einfoOn();
					clickRows();
				}
		});
		}
		
		/* 生成表格  */
		$("#download").click(function() {
			$.post("${pageContext.request.contextPath}/experience/download.action", function(data) {
				if (isDataStatus(data)) {
					$("#dl").attr("href", "${pageContext.request.contextPath}/" + data.data);
					layer.tips('下载表格已准备好!', $("#download"), {
						tips : [1, '#3595CC' ],
						time : 4000
					});
				}
			});
		});
		
		/* 下载表格  */
		$("#dl").click(function() {
			alert($("#dl").attr("href"));
			if (isBlank($("#dl").attr('href')) == "") {
				layer.tips('请先生成下载表格!', $("#download"), {
					tips : [ 1, '#3595CC' ],
					time : 4000
				});
			}
		});
		
		/* 翻页*/
		function btnPage() {
			$(".nav-btn").click(function() {
				getData(status,qq,aId,this.lang);
			});
		}
		
		//添加点击事件
		function addclick(){
			$("#add").unbind("click").click(function(){
				$(this).unbind();
				layer.open({
					  type: 2,
					  title: '添加体验者',
					  area: ['380px', '500px'],
					  shift: 1,
					  shade: 0.5, //开启遮罩关闭
					  content: '${pageContext.request.contextPath}/experience/add.jsp',
					  end: function(){
						  getData(status,qq,aId,$("#btn-currentpage").parent().attr("lang"));
					  }
				});
			})
		}
		//备注鼠标悬停事件
		function memoOn(){
			$(".memo").mouseover(function(){
				var id="#"+this.id;			
				layer.tips('只想提示地精准些', id,{time: 1000});
				});
		}	
		//查看沟通信息点击事件
		function lookCommunicationclick(){
			$(".lookCommunication").click(function(){
				var data=this.lang.split(",");
				var id=data[0];
				var name=data[1];
				layer.open({
					  type: 2,
					  title: '查看沟通信息',
					  area: ['780px', '550px'],
					  shift: 1,
					  shade: 0.5, //开启遮罩关闭
					  content: '${pageContext.request.contextPath}/experience/lookcommunication.jsp?id='+id+'&name='+name,
				});
			})
		}
		//添加沟通信息点击事件
		function addCommunicationclick(){
			$(".addCommunication").click(function(){
				var data=this.lang.split(",");
				var id=data[0];
				var name=data[1];
				layer.open({
					  type: 2,
					  title: '添加沟通信息',
					  area: ['810px', '550px'],
					  shift: 1,
					  shade: 0.5, //开启遮罩关闭
					  content: '${pageContext.request.contextPath}/experience/addcommunication.jsp?id='+id+'&name='+name,
				});
			})
		}
		//加入VIP点击事件
		//*未修复：1.重复添加会员
		//	    2.添加会员后，不能重置取消会员资格，否则会员编号，会和提示框中的编号不同
		function joinclick(){
			$(".join").click(function(){
				//alert("功能暂未完善！");
				//return false;
				var data=this.lang.split(",");
				if('true' == data[3]) {
					layer.msg("该体验者已经添加过了!", {icon: 1});
					return ;
				}
				var id=data[0];
				var name=data[1];
				var tempNum=(""+data[2]).split("0");
				var num=tempNum[3];
				if(!confirm("确认添加【" + name + "】" + "为会员吗？"))
				{
					return;
				}
				$.post("${pageContext.request.contextPath}/experience/joinVIP.action",{id:id},function(data){
					if (isDataStatus(data)) {
						getData(status,qq,aId,$("#btn-currentpage").parent().attr("lang"));
					}
				});			
			})
		}
		//加入VIP点击事件
		//*未修复：1.重复添加会员
		//	    2.添加会员后，不能重置取消会员资格，否则会员编号，会和提示框中的编号不同
		function previpclick(){
			$(".preVIP").click(function(){
				//alert("功能暂未完善！");
				//return false;
				var data=this.lang.split(",");
				if('true' == data[3]) {
					layer.msg("该体验者已经添加过了!", {icon: 1});
					return ;
				}
				var id=data[0];
				var name=data[1];
				var tempNum=(""+data[2]).split("0");
				var num=tempNum[3];
				if(!confirm("确认添加【" + name + "】" + "为预科计划吗？"))
				{
					return;
				}
				$.post("${pageContext.request.contextPath}/experience/joinPreVIP.action",{id:id},function(data){
					if (isDataStatus(data)) {
						getData(status,qq,aId,$("#btn-currentpage").parent().attr("lang"));
					}
				});			
			})
		}
		//退出点击事件
		function leftclick(){
			$(".left").click(function(){
				var str = this.lang.split(",");
				var id=str[0];
				//alert(str[1]);
				if('' != str[1]) {
					layer.msg("<b style='color:red;'>该体验者已经退出或者变成会员了！</b>", {icon: 2});
					return ;
				}
				$.post("${pageContext.request.contextPath}/experience/leftVIP.action",{id:id},function(data){
					if (isDataStatus(data)) {
						getData(status,qq,aId,$("#btn-currentpage").parent().attr("lang"));
					}
				});
			})
		}
		//重置点击事件
		function resetclick(){
			$(".reset").click(function(){
				var id=this.lang;
				$.post("${pageContext.request.contextPath}/experience/resetVIPFlag.action",{id:id},function(data){
					if (isDataStatus(data)) {
						getData(status,qq,aId,$("#btn-currentpage").parent().attr("lang"));
					}
				});
			})
		}
		//删除点击事件
		function deleteclick(){
			$(".delete").click(function(){
				var id = this.lang;
				layer.confirm('您确定要删除该用户吗?删除该用户时，同时也会删除该用户的基本信息和信用信息，请谨慎操作！',{btn:['是','否']},//按钮一的回调函数
						function(){
							$.post("${pageContext.request.contextPath}/user/deleteById.action?id=" + id,function(data){
									layer.closeAll('dialog');
									getData(status,qq,aId,$("#btn-currentpage").parent().attr("lang"));
							});
				});
			});
		}
		//点击姓名显示信息事件
		function einfoOn(){
			$(".einfo").click(function(){
				$.ajaxSetup({async:false});
				$.post("${pageContext.request.contextPath}/experience/getExperienceById.action",{id:this.lang},function(data){
						var info=data.name+"<br/>";
						info+="手机号码：" + data.phone+"<br/>";
						info+="QQ号码："+data.qq;
						layer.alert(info);
				});
			});
		}
		
		//详细信息点击事件
		function msgclick(){
			$(".msg").click(function(){
				var x=$(this);
				$.post("${pageContext.request.contextPath}/user/getinfo.action?id=" + this.lang,function(data){
						var info="";
						if(data==""){
							info="没有信息，该会员还没有填写";
						}else{
							info="<table class='table table-bordered'>";
							info+="<tr>";
							info+="<td>身份证号码</td><td>"+ data.idNo + "</td>";
							info+="</tr><tr>";
							info+="<td>QQ号码</td><td>" + data.qqNo + "</td>"; 
							info+="</tr><tr>";
							info+="<td>支付宝</td><td>" + data.payAccount + "</td>"; 
							info+="</tr><tr>";
							info+="<td>家庭联系人</td><td>" + data.contactName + "</td>"; 
							info+="</tr><tr>";
							info+="<td>家庭联系人手机</td><td>" + data.contactMobile + "</td>"; 
							info+="</tr><tr>";
							info+="<td>与家庭联系人关系</td><td>" + data.relation + "</td>"; 
							info+="</tr><tr>";
							info+="<td>收件地址</td><td>" + data.address + "</td>"; 
							info+="</tr><tr>";
							info+="</table>";
						}						
						layer.alert(info);
				});
			});
		}
		function drawTable(data){
			if(data.length == 0) {
				layer.msg("没有数据", {
					icon : 0
				});
				$("#tbody").html("");
				return ;
			}
			var line = "";
			for(i=0;i<data.length;i++){
				var student="在学"
				if(data[i].student==false){
					student="在职";
				}
				var aname="";
				if(data[i].admin!=null){
					aname=data[i].admin.realname;
				}
				var membernum="";
				if(data[i].user!=null){
					membernum=data[i].user.name;
				}
				var endtime="";
				if(data[i].endtime!=null){
					endtime=data[i].endtime;
				}
				if(data[i].flag==0 && data[i].endtime!=null){
					data[i].flag=3;
				}
				switch (data[i].flag) {
				case 1 : line += "<tr class='rows success'>";break;
				case 2 : line += "<tr class='rows warning'>";break;
				case 3 : line += "<tr class='rows danger'>";break;
				default : line += "<tr class='rows'>";break;
				}
				line=line + "<td>" + (i+1) + "</td>";
				line=line + "<td>" + data[i].num + "</td>";
				line=line + "<td class='einfo' lang='" + data[i].id + "'>" + data[i].name + "</td>";
				line=line + "<td>" + isBlank(data[i].school) + "</td>";
				line += "<td class='nowrap'><span style='text-decoration:underline'><a href='tencent://message/?uin="+data[i].qq+"&Site=&Menu=yes'>" +isBlank(data[i].qq) + "</a></span></td>";
				line=line + "<td>" + student +  "</td>";	
				line=line + "<td>" + datePattern(data[i].begintime) + "</td>";
				line=line + "<td>" + membernum + "</td>";
				line=line + "<td>" + aname + "</td>";
				line=line + "<td class='memo' id='memo"+(i+1)+"'>";
				line=line + "<a href='javascript:void(0)' title='添加' style='text-decoration:none' class='addCommunication' lang='" + data[i].id + "," + data[i].name +"'>添加"+"</a>&nbsp;|&nbsp;";
				line=line + "<a href='javascript:void(0)' title='查看' style='text-decoration:none' class='lookCommunication' lang='" + data[i].id + "," + data[i].name +"'>查看"+"</a>";
				line=line + "</td>";
				line=line + "<td>";
				line=line + "<a href='javascript:void(0)' title='加入' style='text-decoration:none' class='join' lang='"+ data[i].id + "," + data[i].name + "," + data[i].num + "," + data[i].flag +"'>加入"+"</a>&nbsp;|&nbsp;";
				line=line + "<a href='javascript:void(0)' title='预科' style='text-decoration:none' class='preVIP' lang='"+ data[i].id + "," + data[i].name + "," + data[i].num + "," + data[i].flag +"'>预科"+"</a>&nbsp;|&nbsp;";
				line=line + "<a href='javascript:void(0)' title='退出' style='text-decoration:none' class='left' lang='"+ data[i].id + "," + endtime +"'>退出"+"</a>&nbsp;|&nbsp;";
				line=line + "<a href='javascript:void(0)' title='重置' style='text-decoration:none' class='reset' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe66b;</i></a>&nbsp;|&nbsp;";
				line=line + "<a href='javascript:void(0)' title='修改' style='text-decoration:none' class='modify' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe6df;</i></a>&nbsp;|&nbsp;";
				line=line + "<a href='javascript:void(0)' title='删除' style='text-decoration:none' class='delete' lang='"+data[i].id+"'><i class='Hui-iconfont'>&#xe609;</i></a>";
				line=line + "</td>";
				line=line + "</tr>";
			}
			$("#tbody").html(line);
		}
	});
</script>

</head>
<body>
	<c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>		
	<div class="panel panel-secondary">
		<div class="panel-header">
			<div style="float: left;">
				<input type="hidden" id="flag" value="0">
				<button class="btn btn-success" id="add">
					<i class="fa fa-plus" aria-hidden="true"></i> 添加体验者
				</button>
			</div>
			<div class="btn-group" style="float: left">
			<input type="hidden" id="estatus" value="0"/>
				<button type="button" class="btn btn-primary radius active butname"
					lang="0">全部信息</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="2">正在体验</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="1">已经加入</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="3">已经退出</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="4">预科计划</button>
			</div>
			<div class="form-group">
				<span class="select-box radius" style="width: 100px;background : white;">
					<select class="select" name="assistant">
						<option value="0">所有人</option>
						<option value="36">王炜强</option>
						<option value="37">曾小晨</option>
						<option value="22">闽光磊</option>
						<option value="32">刘文启</option>
						<option value="54">陈家豪</option>
						<option value="41">张晓敏</option>
					</select>
				</span>
				<input id="qq" type="text" placeholder="QQ号" style="width: 100px"
					class="input-text radius" />
				<button id="qqsearch" class="btn btn-success" type="button">
					<i class="fa fa-search" aria-hidden="true"></i> QQ号模糊查询
				</button>
			</div>
			<div class="btn-group" style="float: right">
				<button type="button" class="btn btn-primary radius" id="download">生成表格</button>
				<a type="button" class="btn btn-primary radius" id="dl">点击下载</a>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class="text-c">
					<tr>
						<th>序号</th>
						<th>用户名</th>
						<th>姓名</th>
						<th>学校</th>
						<th>QQ</th>
						<th>类型</th>
						<th>开始时间</th>
						<th>会员编号</th>
						<th>助教</th>
						<th>沟通</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	<div class="page-nav" style="float: right; margin-top: 10px;" id="paging"></div>
</body>
</html>