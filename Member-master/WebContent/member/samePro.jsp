<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>找小伙伴-Java互助学习VIP群业务运行系统</title>
<style type="text/css">
.bordered li{
	list-style:none;
	float:left;
	margin:0 5px;
	width:160px;
}
.bordered table{
	font-family: verdana,arial,sans-serif;
	color:#333333;
	border-width: 1px;
	border-color: #999999;
	border-collapse: collapse;
}
.bordered tr {
	background-color:#d4e3e5;
}
.bordered td{
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
	overlow:hidden;
}

.bordered a{
text-decoration : none;
}
</style>    	

	


<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>


    
<script type="text/javascript">

$(function(){
	$("#write").click(function(){
			$.post("${pageContext.request.contextPath}/summary/checkIsRepeatByTit.action",function(data){
			if(data == 0)
			{
				layer.msg('编写周报时间未到', {
				    icon: 2,
				    time: 1000
				});	
			}
			else{
			window.location.href="${pageContext.request.contextPath}/ueditor/write.jsp";			
			}
			});
	});
//	$("#modify").click(function(){
//			var index=layer.open({
//			    type: 2,
//			    title:'修改',
//			    area: ['740px', '560px'],
//			    shift:5,
//			    maxmin: true,
//			    content: '${pageContext.request.contextPath}/ueditor/modify.jsp'
//			});	
//	});
	$("#mywrite").click(function(){
		$.ajaxSetup({ async : false });
				var index=layer.open({
			    type: 2,
			    title:'查看周报',
			    area: ['740px', '560px'],
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath}/ueditor/showsummaryin.jsp'
			});
	});


	
	
});

	
$(function(){
	var date=$("#date").attr("value");
	
	//Ajax异步获得JSON对象后格式化时间
	 //实现思路：获得毫秒数 再转化为需要时间格式。形如：yyyy-MM-dd
var format = function(time, format) {
    var t = new Date(time);
    var tf = function(i) {
        return (i < 10 ? '0': '') + i
    };
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g,
    function(a) {
        switch (a) {
        case 'yyyy':
            return tf(t.getFullYear());
            break;
        case 'MM':
            return tf(t.getMonth() + 1);
            break;
        case 'mm':
            return tf(t.getMinutes());
            break;
        case 'dd':
            return tf(t.getDate());
            break;
        case 'HH':
            return tf(t.getHours());
            break;
        case 'ss':
            return tf(t.getSeconds());
            break;
        }
    });
}
	
	
	$("#get").click(function(){
	var url = "";
		var sel = $("#sel").val();
		if(sel == "1"){
			url = "samePro.action";
		}else if(sel == "2"){
			url = "sameScho.action";
		}else{
			url = "sameAge.action";
		}
		$.post("${pageContext.request.contextPath}/member/" + url,function(data){
			var cmid = ${myuser.member.id};
			var samePro_html="<tr>\n<td colspan=7 >\n";
			var h=data.length/7;

			if(data.length%7>0)
			{
				h++;
			}
			for(var i=0; i<h; i++)
			{
				samePro_html+="<ul>\n";
				for(var j=0; j<7; j++)
				{
					if(7*i+j<data.length && cmid != data[7*i+j].member.id ){
					var str = "<li><img src='${pageContext.request.contextPath}/member/getCover.action?uid="+data[7*i+j].id+"' width='150' height='150'><span style='display: block;text-align:center'><a href='javascript:void(0)' class='"+data[7*i+j].id+"'>"+data[7*i+j].name+"</a></span></li>\n";
					samePro_html += str;
					}else{
						var str = "<li></li>\n";
						samePro_html+= str;
					}

				}
				samePro_html+="</ul>\n";
			}

			samePro_html+="</td>\n</tr>";

			$("#members").html(samePro_html);

			$("a").click(function(){
				
				var name = $(this).text();
			    var id = $(this).attr("class");
					$.post("${pageContext.request.contextPath}/member/getMemDetails.action?id=" + id,null,function(data){
						var time = new Date();//获取当前时间
						var year = format(time, 'yyyy');
						var memYear = (data.userInfo.idNo).substr(6,4);
						var age = year - memYear;//年龄
						//毕业时间
						var formatGraduateDate = format(data.member.graduateDate, 'yyyy-MM-dd');
						//创建时间
						var formatJoinTime = format(data.member.time, 'yyyy-MM-dd HH:mm:ss');
						//注册时间
						var formatRegisterTime = format(data.time, 'yyyy-MM-dd HH:mm:ss');
						$.post("${pageContext.request.contextPath}/member/getProvByProvId.action?provid=" + data.member.provid,null,function(prov){
							var province = prov.name;
							var info_html = "<form>\n<table style='font-size:12px;'>\n<tr><td align='right'>VN.</td><td style='width: 83px;'>"+data.name+"</td><td align='right'>联系方式</td><td>"+data.member.mobile+"</td></tr>\n	";
							info_html += "<tr><td align='right'>姓名</td><td>"+data.member.name+"</td><td align='right'>工作单位</td><td>"+data.member.company+"</td></tr>\n";
							info_html += "<tr><td>性别</td><td>"+data.member.sex+"</td><td>所在城市</td><td>"+province+"</td></tr>\n";
							info_html += "<tr><td align='right'>年龄</td><td>"+age+"</td><td align='right'>注册时间</td><td>"+formatRegisterTime+"</td></tr>\n";
							info_html += "<tr><td>学校</td><td>"+data.member.school+"</td><td>毕业时间</td><td>"+formatGraduateDate+"</td></tr>\n</table>\n</form>\n";
							var mtitle =  "小伙伴" + name + "的详细信息";
								//layer弹出层，显示详细信息
								layer.open({
									title:mtitle,
								    type: 1,
								    skin: 'layui-layer-lan', //样式类名
								    closeBtn: 1, //不显示关闭按钮
								    shift: 1,//动画类型
								    shadeClose: true, //开启遮罩关闭
								    content: info_html
								});
						});
					});
			  });
		},"json");
	});
	
});
</script>

</head>
<body>

            <!-- 正文 -->
			
				<div>
	<select id="sel">
		<option value="1">同一个城市</option>
		<option value="2">同一个学校</option>
		<option value="3">同一个年龄</option>
	</select>
<input type="button" id="get" value="获取">
</div>
<br>
<br>
<table id="members" class="bordered" style="font-size:16px;"></table>

<div> 
	<input type="hidden" name="id" value="${myuser.member.id}">
</div>  

			<!-- 正文 结束-->








</body>
</html>