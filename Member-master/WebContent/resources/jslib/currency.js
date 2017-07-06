(function($) {
	jQuery.each([ "get", "post" ], function(i, method) {
		jQuery[method] = function(url, data, callback, type) {
			// shift arguments if data argument was omitted
			if (jQuery.isFunction(data)) {
				type = type || callback;
				callback = data;
				data = undefined;
			}

			return jQuery.ajax({
				url : url,
				type : method,
				dataType : type,
				data : data,
				success : callback,
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					var str = "";
					switch (textStatus) {
					case "timeout":
						str = "请求超时！";
						break;
					case "error":
						str = "服务器发生了错误！";
						break;
					case "notmodified":
						str = "缓存错误!";
						break;
					case "parsererror":
						str = "请求格式错误！";
						break;
					default:
						str = "发生了错误！";
					}
					layer.msg("<strong style='color:red;'>" + str + "</strong>",{icon : 2});
				},
			});
		};
	});
})(jQuery);
/** 对Date的扩展，将 Date 转化为指定格式的String * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q)
可以用 1-2 个占位符 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
* eg: 
* (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S")==> 2006-07-02 08:09:04.423      
* (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04      
* (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04      
* (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04      
* (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18      
*/    
Date.prototype.pattern=function(fmt) {         
    var o = {         
    "M+" : this.getMonth()+1, // 月份
    "d+" : this.getDate(), // 日
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, // 小时
    "H+" : this.getHours(), // 小时
    "m+" : this.getMinutes(), // 分
    "s+" : this.getSeconds(), // 秒
    "q+" : Math.floor((this.getMonth()+3)/3), // 季度
    "S" : this.getMilliseconds() // 毫秒
    };         
    var week = {         
    "0" : "日",         
    "1" : "一",         
    "2" : "二",         
    "3" : "三",         
    "4" : "四",         
    "5" : "五",         
    "6" : "六"        
    };         
    if(/(y+)/.test(fmt)){         
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));         
    }         
    if(/(E+)/.test(fmt)){         
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "星期" : "周") : "")+week[this.getDay()+""]);         
    }         
    for(var k in o){         
        if(new RegExp("("+ k +")").test(fmt)){         
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));         
        }         
    }         
    return fmt;         
}

/**
 * 获取url参数(不建议使用，推荐使用el表达式获取)
 * 
 * @param name
 *            需要获取的url参数名
 * @returns 返回参数的值
 */
function getUrlParam(name) {
     var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r != null)
    	 return unescape(r[2]); 
     return null;
}

/**
 * 显示页码
 * 
 * @param page
 *            当前页
 * @param count
 *            总页数
 * @returns 页码的html代码
 */
function showpage(page, count) {
	var paging = "<a href='javascript:;' class='nav-btn' lang='" + ((count != 0) ? 1 : 0) +"'><button type='button'>首页</button></a>&nbsp;&nbsp;";
	if(count <= 5) {
		for(var i = 1; i <= count; i++) {
			paging += getPageBut(i, page);
		}
	} else if(page <= 3){
		for(var i = 1; i <= 5; i++) {
			paging += getPageBut(i, page);
		}
	} else if(count - page <= 2) {
		for(var i = count - 4; i <= count; i++) {
			paging += getPageBut(i, page);
		}
	} else {
		for(var i = page - 2; i <= page + 2; i++) {
			paging += getPageBut(i, page);
		}
	}
	paging += "<a href='javascript:;' class='nav-btn' lang='" + count +"'><button type='button'>尾页</button></a>&nbsp;&nbsp;";
	paging += "共" + count + "页";
	return paging;
}

function getPageBut(i, page) {
	var paging = "<a href='javascript:;' class='nav-btn' lang='" + i +"'><button type='button'";
	if(page == i) {
		paging += " id='btn-currentpage'><font color='red'><b>" + i + "</b></font></button></a>&nbsp;&nbsp;";
	} else {
		paging += ">" + i + "</button></a>&nbsp;&nbsp;";
	}
	return paging;
}

/**
 * 校验状态码是否正确
 * 
 * @param data
 *            后端返回的Result对象
 * @returns true or false
 */
function isDataStatus(data) {
	if(data.status == 100) {
		return true;
	}
	layer.msg(data.msg, {icon : 2});
	return false;
}

/**
 * 校验数据的有效性并返回值
 * 
 * @param data
 *            需要校验的数据
 * @param defaultdata
 *            数据无效时的值
 * @param exception
 *            数据有效但显示特殊的值
 * @returns 返回结果
 */
function isBlank(data, defaultdata, exception) {
	if(arguments.length == 1) {
		return ((!data) ? "" : data);
	} 
	if(arguments.length == 2) {
		return ((!data) ? defaultdata : data);
	}
	return ((!data) ? defaultdata : exception);
}

/**
 * 格式化时间数据
 * 
 * @param date
 *            需要格式化的时间
 * @param formatdate
 *            格式化时间的格式
 * @returns 格式化后的数据，数据无效时返回空字符串
 */
function datePattern(date, formatdate) {
	if(!date) {
		return "";
	}
	if(arguments.length == 1) {
		return new Date(date).pattern("yyyy-MM-dd");
	}
	return new Date(date).pattern(formatdate);
}

/**
 * 点击行变色
 */
function clickRows() {
	$(".rows").click(function() {
		$(".rows").removeClass("info");
		$(this).addClass("info");
	});
}
