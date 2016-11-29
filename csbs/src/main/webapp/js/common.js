

var shopxx = {
	base: "",
	locale: "zh_CN",
	theme: "default"
};

var setting = {
	priceScale: 2,
	priceRoundType: "roundHalfUp",
	currencySign: "currencySign",
	currencyUnit: "currencyUnit",
	uploadMaxSize: 10,
	uploadImageExtension: "jpg,jpeg,bmp,gif,png",
	uploadMediaExtension: "swf,flv,mp3,wav,avi,rm,rmvb",
	uploadFileExtension: "zip,rar,7z,doc,docx,xls,xlsx,ppt,pptx"
};

var messages = {
	"shop.message.success": "正确",
	"shop.message.error": "错误",
	"shop.dialog.ok": "ok",
	"shop.dialog.cancel": "取消",
	"shop.dialog.deleteConfirm": "删除",
	"shop.dialog.clearConfirm": "清空"
};

// Cookie
function addCookie(name, value, options) {
	if (arguments.length > 1 && name != null) {
		if (options == null) {
			options = {};
		}
		if (value == null) {
			options.expires = -1;
		}
		if (typeof options.expires == "number") {
			var time = options.expires;
			var expires = options.expires = new Date();
			expires.setTime(expires.getTime() + time * 1000);
		}
		if (options.path == null) {
			options.path = "/";
		}
		if (options.domain == null) {
			options.domain = "";
		}
		document.cookie = encodeURIComponent(String(name)) + "=" + encodeURIComponent(String(value)) + (options.expires != null ? "; expires=" + options.expires.toUTCString() : "") + (options.path != "" ? "; path=" + options.path : "") + (options.domain != "" ? "; domain=" + options.domain : "") + (options.secure != null ? "; secure" : "");
	}
}

// Cookie
function getCookie(name) {
	if (name != null) {
		var value = new RegExp("(?:^|; )" + encodeURIComponent(String(name)) + "=([^;]*)").exec(document.cookie);	
		return value ? decodeURIComponent(value[1]) : null;
	}
}


function removeCookie(name, options) {
	addCookie(name, null, options);
}

// Html
function escapeHtml(str) {
	return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}


function abbreviate(str, width, ellipsis) {
	if ($.trim(str) == "" || width == null) {
		return str;
	}
	var i = 0;
	for (var strWidth = 0; i < str.length; i++) {
		strWidth = /^[\u4e00-\u9fa5\ufe30-\uffa0]$/.test(str.charAt(i)) ? strWidth + 2 : strWidth + 1;
		if (strWidth >= width) {
			break;
		}
	}
	return ellipsis != null && i < str.length - 1 ? str.substring(0, i) + ellipsis : str.substring(0, i);
}


function currency(value, showSign, showUnit) {
	if (value != null) {
			var price = (Math.round(value * Math.pow(10, 2)) / Math.pow(10, 2)).toFixed(2);
		if (showSign) {
			price = '￥' + price;
		}
		if (showUnit) {
			price += '$';
		}
		return price;
	}
}


function message(code) {
	if (code != null) {
		var content = messages[code] != null ? messages[code] : code;
		if (arguments.length == 1) {
			return content;
		} else {
			if ($.isArray(arguments[1])) {
				$.each(arguments[1], function(i, n) {
					content = content.replace(new RegExp("\\{" + i + "\\}", "g"), n);
				});
				return content;
			} else {
				$.each(Array.prototype.slice.apply(arguments).slice(1), function(i, n) {
					content = content.replace(new RegExp("\\{" + i + "\\}", "g"), n);
				});
				return content;
			}
		}
	}
}

(function($) {

	var zIndex = 100;
	

	$.checkLogin = function() {
		var result = false;
		$.ajax({
			url: "../login/check.do",
			type: "GET",
			dataType: "json",
			cache: false,
			async: false,
			success: function(data) {
				result = data;
			}
		});
		return result;
	}
	

	$.redirectLogin = function (redirectUrl, message) {
		var href = "../home/tologin.do";
		if (redirectUrl != null) {
			href += "?redirectUrl=" + encodeURIComponent(redirectUrl);
		}
		if (message != null) {
			$.message("warn", message);
			setTimeout(function() {
				location.href = href;
			}, 1000);
		} else {
			location.href = href;
		}
	}
	
	
	var $message;
	var messageTimer;
	$.message = function() {
		var message = {};
		if ($.isPlainObject(arguments[0])) {
			message = arguments[0];
		} else if (typeof arguments[0] === "string" && typeof arguments[1] === "string") {
			message.type = arguments[0];
			message.content = arguments[1];
		} else {
			return false;
		}
		
		if (message.type == null || message.content == null) {
			return false;
		}
		
		if ($message == null) {
			$message = $('<div class="xxMessage"><div class="messageContent message' + escapeHtml(message.type) + 'Icon"><\/div><\/div>');
			if (!window.XMLHttpRequest) {
				$message.append('<iframe class="messageIframe"><\/iframe>');
			}
			$message.appendTo("body");
		}
		
		$message.children("div").removeClass("messagewarnIcon messageerrorIcon messagesuccessIcon").addClass("message" + message.type + "Icon").html(message.content);
		$message.css({"margin-left": - parseInt($message.outerWidth() / 2), "z-index": zIndex ++}).show();
		
		clearTimeout(messageTimer);
		messageTimer = setTimeout(function() {
			$message.hide();
		}, 3000);
		return $message;
	}

})(jQuery);

$().ready(function() {

	var $window = $(window);
	var $goTop = $('<div class="goTop"><\/div>').appendTo("body");
	var $top = $('<a href="javascript:;">&nbsp;<\/a>').appendTo($goTop);
	//var $addFavorite = $('<a href="javascript:;">&nbsp;<\/a>').appendTo($goTop);
	var $headerCartQuantity = $("#headerCart em");
	

	$window.scroll(function() {
		if($window.scrollTop() > 100) {
			$goTop.fadeIn();
		} else {
			$goTop.fadeOut();
		}
	});
	
	
	$top.click(function() {
		$("body, html").animate({scrollTop: 0});
	});
	
	
	/*$addFavorite.click(function() {
		var title = document.title;
		var url = document.url;
		if (document.all) {
			window.external.addFavorite(url, title);
		} else if (window.sidebar && window.sidebar.addPanel) {
			window.sidebar.addPanel(title, url, "");
		} else {
			alert(url);
		}
	});*/
	

	function showHeaderCartQuantity() {
		if ($headerCartQuantity.size() == 0) {			
			return;
		 }	
		$.ajax({
			url: "../cart/quantity.do",
			type: "GET",
			dataType: "json",
			cache: false,
			global: false,
			success: function(data) {				
				if ($headerCartQuantity.text() != data && "opacity" in document.documentElement.style) {
					$headerCartQuantity.fadeOut(function() {
						$headerCartQuantity.text(data).fadeIn();							
					});
				} else {
					$headerCartQuantity.text(data);
					
				}
			}
		});
		
	}
	
	showHeaderCartQuantity();
	
	
	$.ajaxSetup({
		traditional: true
	});
	
	
	$(document).ajaxSend(function(event, request, settings) {
		if (!settings.crossDomain && settings.type != null && settings.type.toLowerCase() == "post") {
			var token = getCookie("token");
			if (token != null) {
				request.setRequestHeader("token", token);
			}
		}
	});
	
	$("form").submit(function() {
		var $this = $(this);
		if ($this.attr("method") != null && $this.attr("method").toLowerCase() == "post" && $this.find("input[name='token']").size() == 0) {
			var token = getCookie("token");
			if (token != null) {
				$this.append('<input type="hidden" name="token" value="' + token + '" \/>');
			}
		}
	});
	

	$(document).ajaxComplete(function(event, request, settings) {
		var tokenStatus = request.getResponseHeader("tokenStatus");
		var validateStatus = request.getResponseHeader("validateStatus");
		var loginStatus = request.getResponseHeader("loginStatus");
		if (tokenStatus == "accessDenied") {
			var token = getCookie("token");
			if (token != null) {
				$.extend(settings, {
					global: false,
					headers: {token: token}
				});
				$.ajax(settings);
			}
		} else if (validateStatus == "accessDenied") {
			$.message("warn", "xx");
		} else if (loginStatus == "accessDenied") {
			$.redirectLogin(location.href, "xx");
		} else {
			var url = settings.url.indexOf("/") == 0 ? settings.url : location.pathname.substring(0, location.pathname.lastIndexOf("/")) + "/" + settings.url;
			if (url.indexOf("/register/") == 0 || url.indexOf("/login/") == 0 || url.indexOf("/cart/") == 0 || url.indexOf("/order/") == 0) {
				showHeaderCartQuantity();
			}
		}
	});

});





if ($.validator != null) {
    
	$.extend($.validator.messages, {
		required: '必填',
		email: 'E-mail格式错误',
		url: '必须输入正确格式的网址',
		date: ' 必须输入正确格式的日期 日期校验ie6出错，慎用',
		dateISO: '必须输入正确格式的日期(ISO)，例如：2009-06-23，1998/01/22 只验证格式，不验证有效性',		
		number: '必须输入合法的数字(负数，小数)',
		digits: '必须输入整数',
		minlength: $.validator.format('长度不允许小于 {0}'),
		maxlength: $.validator.format('请输入一个 长度最少是 {0} 的字符串'),
		rangelength: $.validator.format('请输入 一个长度介于 {0} 和 {1} 之间的字符串'),
		min: $.validator.format('请输入一个最大为{0} 的值'),
		max: $.validator.format('请输入一个最小为{0} 的值'),
		range: $.validator.format('请输入一个介于 {0} 和 {1} 之间的值'),
		accept: '输入拥有合法后缀名的字符串（上传文件的后缀）',
		equalTo: '两次输入不一致',
		remote: '用户名被禁用或已被注册',
		integer: ' positive or negative non-decimal number please',
		positive: '格式错误',
		negative: 'A negative number please',
		decimal: '小数点2位后'	
	});
	
	$.validator.setDefaults({
		errorClass: "fieldError",
		ignore: ".ignore",
		ignoreTitle: true,
		errorPlacement: function(error, element) {
			//var fieldSet = element.closest("span.fieldSet");
		/*	if (fieldSet.size() > 0) {
				error.appendTo(fieldSet);
			} else {
				error.insertAfter(element);
			}*/
			element.parents('.inputbg').next('.err-tip').show().find('.err-box').append(error);
		},
		submitHandler: function(form) {
			$(form).find("input:submit").prop("disabled", true);			
			form.submit();
		},
		 success: function(label) { 
            label.parents('.err-tip').hide();
        } 
	});

}