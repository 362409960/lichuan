$(function(){
	
	var $lotipa=$('.lotipbox .ali01');
	var $tanzh=$('#tanzh');
	var $azh=$('#azh');
	var $checkAllPlayer=$('#checkAllPlayer');
	var $aCheckBox=$(':checkbox[name=ckBox]');
	
	var $isPlayer=$('#isPlayer');
	$checkAllPlayer.bind('click',function(){
		var _this=this;
		$aCheckBox.each(function(index, element) {
            $(this).attr('checked',_this.checked);
        });
		var $aChLen=$(':checkbox[name=ckBox]:checked').length;
		$aChLen > 0 ? $isPlayer.html('&gt;<b>播放终端:'+$aChLen+'</b>'): $isPlayer.html(':(0)');
	});
	
	$aCheckBox.each(function(index, element){
		var $this=$(this);
		$this.bind('click',function(){
			var $aChLen=$(':checkbox[name=ckBox]:checked').length;
			var $aBox=$aCheckBox.length;
			if($aChLen==$aBox){
				$checkAllPlayer.attr('checked',this.checked);
			}else{
				$checkAllPlayer.removeAttr('checked');
			}
			$aChLen > 0 ? $isPlayer.html('&gt;<b>播放终端:'+$aChLen+'</b>'): $isPlayer.html(':(0)');
			
		});
	});
	
	$lotipa.hover(function(){
		$tanzh.addClass('aliShow');
		$azh.addClass('alion');
	},function(){
		$tanzh.removeClass('aliShow');
		$azh.removeClass('alion');
	});
	$tanzh.hover(function(){
		$(this).addClass('aliShow');
		$azh.addClass('alion');
	},function(){
		$(this).removeClass('aliShow');
		$azh.removeClass('alion');
	});
	$('li.li_index_right,li.li_index_right_al').hover(function(){
		$(this).addClass('li_index_right_hover');
	},function () {
		$(this).removeClass('li_index_right_hover');
	});
	var $menuLi=$('#menu').find('li');
	$menuLi.hover(function(){
		var $this=$(this);
		$('>a',this).attr('class','menuActive');
		$this.find('span').stop().animate({
			opacity:1
		},'slow');
		$this.find('span a:first').css('margin-left',this.offsetLeft);
	},function(){
		var $this=$(this);
		$('>a',this).attr('class','menuNormal');
		$this.find('span').stop().animate({
			opacity:0
		},'slow');
	});
	var $boxList=$('.boxList');
	$boxList.find('tr:even th').css('background-color','#bfc2cb');
	$boxList.find('tr:even td').css('background-color','#bfc2cb');
	
});


function layerAlter(title,message){
	layer.alert(message, {
	  icon:5,
	  title:title
	})
}