// JavaScript Document
var EventUtil = {
    addHandler: function(element,type,handler) {
        if(element.addEventListener) {
            element.addEventListener(type,handler,false);
        }else if(element.attachEvent) {
            element.attachEvent("on"+type,handler);
        }else {
            element["on" +type] = handler;
        }
    },
    removeHandler: function(element,type,handler){
        if(element.removeEventListener) {
            element.removeEventListener(type,handler,false);
        }else if(element.detachEvent) {
            element.detachEvent("on"+type,handler);
        }else {
            element["on" +type] = null;
        }
    },
    getEvent: function(event) {
        return event ? event : window.event;
    },
    getTarget: function(event) {
        return event.target || event.srcElement;
    },
    preventDefault: function(event){
        if(event.preventDefault) {
            event.preventDefault();
        }else {
            event.returnValue = false;
        }
    },
    stopPropagation: function(event) {
        if(event.stopPropagation) {
            event.stopPropagation();
        }else {
            event.cancelBubble = true;
        }
    },
    getRelatedTarget: function(event){
        if (event.relatedTarget){
            return event.relatedTarget;
        } else if (event.toElement){
            return event.toElement;
        } else if (event.fromElement){
            return event.fromElement;
        } else {
            return null;
        }
    },
    getWheelDelta: function(event) {
        if(event.wheelDelta) {
            return event.wheelDelta;
        }else {
            return -event.detail * 40
        }
    },
    getCharCode: function(event) {
        if(typeof event.charCode == 'number') {
            return event.charCode;
        }else {
            return event.keyCode;
        }
    },
	hasClass:function(obj,cls){
		var obj_class = obj.className,//获取 class 内容.
		obj_class_lst = obj_class.split(/\s+/);//通过split空字符将cls转换成数组.
		x = 0;
		for(x in obj_class_lst) {
			if(obj_class_lst[x] == cls) {//循环数组, 判断是否包含cls
				return true;
			}
		}
		return false;
	},
	addClass:function(obj,cls){
		var obj_class = obj.className,//获取 class 内容.
		blank = (obj_class != '') ? ' ' : '';//判断获取到的 class 是否为空, 如果不为空在前面加个'空格'.
		added = obj_class + blank + cls;//组合原来的 class 和需要添加的 class.
		obj.className = added;//替换原来的 class.
	},
	removeClass:function(obj,cls){
		var obj_class = ' '+obj.className+' ';//获取 class 内容, 并在首尾各加一个空格. ex) 'abc        bcd' -> ' abc        bcd '
		obj_class = obj_class.replace(/(\s+)/gi, ' '),//将多余的空字符替换成一个空格. ex) ' abc        bcd ' -> ' abc bcd '
		removed = obj_class.replace(' '+cls+' ', ' ');//在原来的 class 替换掉首尾加了空格的 class. ex) ' abc bcd ' -> 'bcd '
		removed = removed.replace(/(^\s+)|(\s+$)/g, '');//去掉首尾空格. ex) 'bcd ' -> 'bcd'
		obj.className = removed;//替换原来的 class.
	},
	removeAllChildClass:function(cls){
		var aChildLen=this.children.length;
		for(var i=0;i<aChildLen;i++){
			EventUtil.removeClass(this.children[i],cls);
		}
	},
	getStyle:function(obj,attr){
		if(obj.currentStyle){
			return obj.currentStyle[attr];
		}else{
			return getComputedStyle(obj,false)[attr];
		}
	}
};