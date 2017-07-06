<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<style type="text/css">
.myline {
	font-weight: bold;
}

.myline td {
	color: red
}

.newline {
	background-color: #EEE
}

.otherline td {
	color: red
}
</style>
<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name);
	(function ($) {
	    $.getUrlParam = function (name) {
	        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	        var r = window.location.search.substr(1).match(reg);
	        if (r != null) return unescape(r[2]); return null;
	    }
	})(jQuery);
	var mid = $.getUrlParam('mid');
	$.post("${pageContext.request.contextPath}/member/getAllByMid.action",{mid : mid},function(data) {
		var dataObj = eval("("+data+")");
		var lists = dataObj.returnMap.list;
		var lines = "";
		lines += "<thead class='text-c'>";
		lines += "<tr>";
		lines += "<th>序号</th>";
		lines += "<th>交费日期</th>";
		lines += "<th>交费金额</th>";
		lines += "<th>撤销</th>";
		lines += "</tr>";
		lines += "</thead>";
		for(i = (lists.length - 1); i >= 0; i--){
			lines += "<tr class='text-c'>";			
			lines += "<td>" + (lists.length - i) + "</td>";			
			lines += "<td>" + lists[i].formatDate + "</td>";
			lines += "<td>" + lists[i].amount + "</td>";
			if(i == (lists.length - 1)) {
				lines += "<td><input type='button' value='撤销' onclick=revoke('" + lists[i].id + "," + mid + "') class='btn btn-danger radius'></td>";
			} else {
				lines += "<td><input type='button' value='撤销' disabled='disabled' class='btn disabled radius'></td>";
			}
			lines += "</tr>";
		}
		$("#period").html(lines);
	});
	function revoke(data) {
		var str = data.split(",");
		//alert(str[0]);
		//alert(str[1]);
		var i = layer.confirm('您确定要撤销这次的缴费记录？', {
			  btn: ['取消','确定'] //按钮
			}, function(){
				layer.close(i); 
				//parent.location.reload(); 
			}, function(){
				$.post("${pageContext.request.contextPath}/member/revoke.action",{mid:str[1]},function() {
					//layer.close(index);
					parent.location.reload(); 
					//location.href="${pageContext.request.contextPath}/admin/feerevoke.jsp?mid=" + str[1];
				});	
		});
	}
</script>
</head>
<body>
	<div class="mt-20">
		<table
			class="table table-border table-bg table-bordered radius" id="period">
		</table>
	</div>
</body>
</html>