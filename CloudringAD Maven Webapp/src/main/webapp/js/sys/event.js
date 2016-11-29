// JavaScript Document
var EventUtil = {
    addHandler: function(element,type,handler) {
    	element?element:document;
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
		var obj_class = obj.className,//��ȡ class ����.
		obj_class_lst = obj_class.split(/\s+/);//ͨ��split���ַ�clsת��������.
		x = 0;
		for(x in obj_class_lst) {
			if(obj_class_lst[x] == cls) {//ѭ������, �ж��Ƿ��cls
				return true;
			}
		}
		return false;
	},
	addClass:function(obj,cls){
		var obj_class = obj.className,//��ȡ class ����.
		blank = (obj_class != '') ? ' ' : '';//�жϻ�ȡ���� class �Ƿ�Ϊ��, ���Ϊ����ǰ��Ӹ�'�ո�'.
		added = obj_class + blank + cls;//���ԭ���� class ����Ҫ��ӵ� class.
		obj.className = added;//�滻ԭ���� class.
	},
	removeClass:function(obj,cls){
		var obj_class = ' '+obj.className+' ';//��ȡ class ����, ������β����һ���ո�. ex) 'abc        bcd' -> ' abc        bcd '
		obj_class = obj_class.replace(/(\s+)/gi, ' '),//������Ŀ��ַ��滻��һ���ո�. ex) ' abc        bcd ' -> ' abc bcd '
		removed = obj_class.replace(' '+cls+' ', ' ');//��ԭ���� class �滻����β���˿ո�� class. ex) ' abc bcd ' -> 'bcd '
		removed = removed.replace(/(^\s+)|(\s+$)/g, '');//ȥ����β�ո�. ex) 'bcd ' -> 'bcd'
		obj.className = removed;//�滻ԭ���� class.
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