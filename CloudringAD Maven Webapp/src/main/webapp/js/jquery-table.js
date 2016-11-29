// JavaScript Document
;(function($){
	$.fn.table=function(options){
		var defaults={
			target:'tr',
			eventType:'mouseover',
			hoverClass:'trHover',
			eventType2:'mouseout',
			evenClass:'evenTr',

		}
		var options=$.extend(defaults,options);
		this.each(function(){
			//实现功能的代码
			var _this=$(this);
			
			var oTr=$(this).find(options.target);
			
			var i=0;
			
			for(i=0,len=oTr.length;i<len;i++){
				if(oTr.eq(i).index()%2!=0){
					oTr.eq(i).addClass(options.evenClass);
				}
			}
			_this.find(options.target).bind(options.eventType,function(){
				$(this).addClass(options.hoverClass);
			});
			_this.find(options.target).bind(options.eventType2,function(){
				$(this).removeClass(options.hoverClass);
			});
		});
		return this;
	}
})(jQuery);