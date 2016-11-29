// JavaScript Document
$(function(){
	var $oTool=$('#lefttool');
	$oTool.delegate('.Item','click',function(e){
		var $this=$(this);	
		var targetObj=e.target;
		var $titleName=targetObj.getAttribute('title');
		var $historyItem=$('#history').find('.Item');
		var $compItem=$('#comp').find('.Item');
		var $mainItem=$('#main').children('div');
		var $historyid=targetObj.getAttribute('historyid');
		var $guid=$this.attr('guid');
		if($titleName && $titleName=='隐藏'){
			targetObj.setAttribute('title','显示');
			targetObj.setAttribute('src',contextPath+'/images/icon/hide.png');
			getParentGuid($guid).hide();
		}else if($titleName && $titleName=='显示'){
			targetObj.setAttribute('title','隐藏');
			targetObj.setAttribute('src',contextPath+'/images/icon/show.png');
			getParentGuid($guid).show();
		}
		if($titleName && $titleName=='锁定'){
			targetObj.setAttribute('title','解锁');
			targetObj.setAttribute('src',contextPath+'/images/icon/lock.png');
			getParentGuid($guid).resizable('disable').draggable('disable');
			getParentGuid($guid).css('cursor','text');
			getParentGuid($guid).find('.ui-resizable-handle').hide();
		}else if($titleName && $titleName=='解锁'){
			targetObj.setAttribute('title','锁定');
			targetObj.setAttribute('src',contextPath+'/images/icon/unlock.png');
			getParentGuid($guid).resizable('enable').draggable("enable");
			getParentGuid($guid).find('.ui-resizable-handle').show();
		}
		if($historyid){
			var $index=$this.index();
			$historyItem.addClass('ItemDisable');
			$compItem.hide();
			$mainItem.hide();
			for(var i=0;i<=$index;i++){
				$historyItem.eq(i).removeClass('ItemDisable');	
				$compItem.eq(i).show();
				$mainItem.eq(i).show();
				getGuid($historyid).find('.ShowSpan').find('img').attr('src',contextPath+'/images/icon/show.png').attr('title','隐藏');
				getGuid($historyid).find('.LockSpan').find('img').attr('src',contextPath+'/images/icon/unlock.png').attr('title','锁定');
			}
		}
	});
	
});
function getParentGuid(guid){
	var $mainDiv=$('#main').children('div');
	var $that;
	$mainDiv.each(function(){
		var $this=$(this);
		var $cguid=$this.attr('guid');
		if($cguid==guid){
			$that=$this;
		}
	});
	return $that;
}