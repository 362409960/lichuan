// JavaScript Document
;(function($){
	$.fn.date=function(options){
		var defaults={
			//各种参数，各种属性
			eventType1:'focus',
			eventType2:'blur',
			target:'.date-time'
		}
		var options=$.extend(defaults,options);
		this.each(function(){
			//实现功能的代码
			var _this=$(this);
			_this.bind(options.eventType1,function(event){
				var oLeft=_this.offset().left; 
				var oTop=_this.offset().top+_this.outerHeight();
				var oTime=$(this).prev(options.target);
				oTime.css({top:oTop,left:oLeft}).show();
				oTime.find('a').click(function(){
					_this.val($(this).text());
					oTime.hide();
				});
			});
		});
		return this;
	}
})(jQuery);

