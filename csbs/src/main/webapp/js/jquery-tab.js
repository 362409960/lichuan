// JavaScript Document
;(function($){
	$.fn.tab=function(options){
		var defaults={
			//各种参数，各种属性
			currentClass:'current',
			tabNav:'li',
			tabContent:'.tabContent',
			eventType:'click',
		}
		var options=$.extend(defaults,options);
		this.each(function(){
			//实现功能的代码
			var _this=$(this);
			_this.find(options.tabNav).bind(options.eventType,function(){
				_this.find(options.tabNav).removeClass(options.currentClass);
				$(this).addClass(options.currentClass);
				var index=$(this).index();
				$(options.tabContent).eq(index).show().siblings(options.tabContent).hide();
			});
		});
		return this;
	}
})(jQuery);