//扩展easyui表单的验证
$.extend($.fn.validatebox.defaults.rules, {
	chinese: {//验证汉字
    	validator: function (value) {
            return /^[\u0391-\uFFE5]+$/.test(value);
        },
        message: '只能输入汉字'
    },
    number : {//验证数字
    	validator: function (value) {
            return /^(0|[1-9][0-9]*)$/.test(value);
        },
        message: '只能输入数字'
    },
    maxlength: {//最大输入字符
    	validator: function (value, param) {
    		return value.length <= param[0];
    	},
    	message : '最大输入 {0} 个字符'  
    },
    minlength: {//最小输入字符
    	validator: function (value, param) {
    		return value.length >= param[0];
    	},
    	message : '最少输入 {0} 个字符'  
    },
    mobile: {//value值为文本框中的值  
        validator: function (value) {  
            var reg = /^1[3|4|5|8|9]\d{9}$/;  
            return reg.test(value);  
        },  
        message: '输入手机号码格式不准确'  
    },  
    zipcode: {      	//国内邮编验证  
        validator: function (value) {  
            var reg = /^[1-9]\d{5}$/;  
            return reg.test(value);  
        },  
        message: '邮编必须是非0开始的6位数字.'  
    },
    idcard: {// 验证身份证
        validator: function (value) {
             return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
         },
         message: '身份证号码格式不正确'
    },
    phone: {// 验证电话号码
        validator: function (value) {
             return /^((\d2,3 )|(\d{3}\-))?(0\d2,3 |0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
         },
         message: '格式不正确,请使用下面格式:020-88888888'
    },
    english: {// 验证英语
        validator: function (value) {
             return /^[A-Za-z]+$/i.test(value);
         },
         message: '请输入英文'
    },
    englishAndLength : {// 验证英语及长度  
        validator : function(value, param) {  
            var len = $.trim(value).length;  
            if (len >= param[0] && len <= param[1]) {  
                return /^[A-Za-z]+$/i.test(value);  
            }  
        },  
        message : '请输入英文'  
    },  
    englishUpperCase : {// 验证英语大写  
        validator : function(value) {  
            return /^[A-Z]+$/.test(value);  
        },  
         message : '请输入大写英文'  
    }, 
    unnormal : {// 验证是否包含空格和非法字符  
	    validator : function(value) {  
	    	return !/[~!@#\$%\^&\*]+/g.test(value);   
	    },  
	    message : '输入值不能包含其他非法字符'  
	}, 
    version:{
    	validator: function (value) {
            return /^d+(?=\.{0,1}\d+$|$)/i.test(value);
        },
        message: '版本号只能输入小数点和数字'
    },
    carNo : {  
	    validator : function(value) {  
	        return /^[\u4E00-\u9FA5][\da-zA-Z]{6}$/.test(value);  
	    },  
	    message : '车牌号码无效（例：粤B12350）'  
	},  
	carenergin : {  
	    validator : function(value) {  
	        return /^[a-zA-Z0-9]{16}$/.test(value);  
	    },  
	    message : '发动机型号无效(例：FG6H012345654584)'  
	},

});