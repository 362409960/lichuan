// JavaScript Document
$(function(){
	/*图片按钮*/
	var $picAdd=$('#picAdd');
	var $pidDel=$('#pidDel');
	
	/*视频按钮*/
	var $videoAdd=$('#videoAdd');
	var $videoDel=$('#videoDel');
	
	/*图片表格*/
	var $unpoading_list=$('#unpoading_list');
	var $unpoaded_list=$('#unpoaded_list');
	
	/*视频表格*/
	var $unpoading_video=$('#unpoading_video');
	var $unpoaded_video=$('#unpoaded_video');
	
	/*图片全选框*/
	var $uploading_all=$('#unpoading_all');
	var $uploaded_all=$('#uploaded_all');
	
	/*视频全选框*/
	var $videoing_all=$('#videoing_all');
	var $videoed_all=$('#videoed_all');
	
	/*图片复选框*/
	var $unpoadingBox=$unpoading_list.find('.pic_checkbox');
	var $unpoadedBox=$unpoaded_list.find('.pic_checkbox');
	
	/*视频全复框*/
	var $videoingBox=$unpoading_video.find('.video_checkbox');
	var $videoedBox=$unpoaded_video.find('.video_checkbox');
	
	/*图片选中复选框*/
	var $unpoading_checked=$unpoading_list.find('.pic_checkbox:checked');
	var $unpoaded_checked=$unpoaded_list.find('.pic_checkbox:checked');
	
	/*视频选中全复框*/
	var $videoingBox_checked=$unpoading_video.find('.video_checkbox:checked');
	var $videoedBox_checked=$unpoaded_video.find('.video_checkbox:checked');
	
	
	$unpoading_list.delegate('#unpoading_all','click',function(){
		var $state=this.checked;
		$unpoadingBox=$unpoading_list.find('.pic_checkbox');
		$unpoadingBox.attr('checked',$state);
	});
	
	$unpoading_video.delegate('#videoing_all','click',function(){
		var $state=this.checked;
		$videoingBox=$unpoading_video.find('.video_checkbox');
		$videoingBox.attr('checked',$state);
	});
		
	$unpoading_list.delegate('.pic_checkbox','click',function(){
		$unpoadingBox=$unpoading_list.find('.pic_checkbox');
		$unpoading_checked=$unpoading_list.find('.pic_checkbox:checked');
		if($unpoadingBox.length===$unpoading_checked.length){
			document.getElementById('unpoading_all').checked=true;
		}else{
			document.getElementById('unpoading_all').checked=false;
		}
	});
	
	$unpoading_video.delegate('.video_checkbox','click',function(){
		$videoingBox=$unpoading_video.find('.video_checkbox');
		$videoingBox_checked=$unpoading_video.find('.video_checkbox:checked');
		if($videoingBox.length===$videoingBox_checked.length){
			document.getElementById('videoing_all').checked=true;
		}else{
			document.getElementById('videoing_all').checked=false;
		}
		
	});
	
	
	$unpoaded_list.delegate('#uploaded_all','click',function(){
		var $state=this.checked;
		$unpoadedBox=$unpoaded_list.find('.pic_checkbox');
		$unpoadedBox.attr('checked',$state);
	});
	

	$unpoaded_video.delegate('#videoed_all','click',function(){
		var $state=this.checked;
		$videoedBox=$unpoaded_video.find('.video_checkbox');
		$videoedBox.attr('checked',$state);
	});
	
	
	$unpoaded_list.delegate('.pic_checkbox','click',function(){
		var $state=this.checked;
		$unpoadedBox=$unpoaded_list.find('.pic_checkbox');
		$unpoaded_checked=$unpoaded_list.find('.pic_checkbox:checked');
		if($unpoadedBox.length===$unpoaded_checked.length){
			document.getElementById('uploaded_all').checked=true;
		}else{
			$uploaded_all.removeAttr('checked');
		}
	});
	
	
	$unpoaded_video.delegate('.video_checkbox','click',function(){
		var $state=this.checked;
		$videoedBox=$unpoaded_video.find('.video_checkbox');
		$videoedBox_checked=$unpoaded_video.find('.video_checkbox:checked');
		if($videoedBox.length===$videoedBox_checked.length){
			document.getElementById('videoed_all').checked=true;
		}else{
			document.getElementById('videoed_all').checked=false;
		}
	});
	
	$picAdd.bind('click',function(){
		var $html='';
		$unpoading_checked=$unpoading_list.find('.pic_checkbox:checked');
		if($unpoading_checked.length){
			$unpoading_checked.each(function(index, element) {
				$(this).removeAttr('checked');
                $html+='<tr>'+$(this).parents('tr').html()+'</tr>';
				$(this).parents('tr').remove();
            });
			var $table_html=$unpoaded_list.children('tbody').html();
			$unpoaded_list.children('tbody').html($table_html+$html);
		}
	});
	
	
	$videoAdd.bind('click',function(){
		var $html='';
		$videoingBox_checked=$unpoading_video.find('.video_checkbox:checked');
		if($videoingBox_checked.length){
			$videoingBox_checked.each(function(index, element) {
				$(this).removeAttr('checked');
                $html+='<tr>'+$(this).parents('tr').html()+'</tr>';
				$(this).parents('tr').remove();
            });
			var $table_html=$unpoaded_video.children('tbody').html();
			$unpoaded_video.children('tbody').html($table_html+$html);
		}
	});
	
	
	
	$pidDel.bind('click',function(){
		var $html='';
		$unpoaded_checked=$unpoaded_list.find('.pic_checkbox:checked');
		if($unpoaded_checked.length){
			$unpoaded_checked.each(function(index, element) {
				$(this).removeAttr('checked');
                $html+='<tr>'+$(this).parents('tr').html()+'</tr>';
				$(this).parents('tr').remove();
            });
			var $table_html=$unpoading_list.children('tbody').html();
			$unpoading_list.children('tbody').html($table_html+$html);
		}
	});
	
	$videoDel.bind('click',function(){
		var $html='';
		$videoedBox_checked=$unpoaded_video.find('.video_checkbox:checked');
		if($videoedBox_checked.length){
			$videoedBox_checked.each(function(index, element) {
				$(this).removeAttr('checked');
                $html+='<tr>'+$(this).parents('tr').html()+'</tr>';
				$(this).parents('tr').remove();
            });
			var $table_html=$unpoading_video.children('tbody').html();
			$unpoading_video.children('tbody').html($table_html+$html);
		}
	});
});