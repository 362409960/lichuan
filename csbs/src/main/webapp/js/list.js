// JavaScript Document
$(function(){
	var $listForm=$('#listForm');
	var $filterMenu=$('#filterMenu'); /*筛选*/
	var $pageSizeMenu=$('#pageSizeMenu');/*每页显示*/
	var $searchMenu=$('#searchMenu'); /*搜索类别*/
	var $deleteButton=$('#deleteButton');
	var $sendButton=$('#sendButton');
	var $selectAll=$('#selectAll');
	var $enabledIds=$('#listTable input[name="ids"]:enabled');
	var $contentRow=$('#listTable tr:gt(0)');
	
	$filterMenu.hover(function(){
		$(this).children('ul').show();
	},function(){
		$(this).children('ul').hide();
	});
	
	$pageSizeMenu.hover(function(){
		$(this).children('ul').show();
	},function(){
		$(this).children('ul').hide();
	});
	
	$searchMenu.hover(function(){
		$(this).children('ul').show();	
	},function(){
		$(this).children('ul').hide();	
	});
	
	$selectAll.click(function(){
		var $this=$(this);
		if($this.prop('checked')){
			$enabledIds.prop('checked',true);
			$deleteButton.removeClass('disabled');
			$sendButton.removeClass('disabled');
			$contentRow.addClass('selected');
		}else{
			$enabledIds.prop('checked',false);
			$deleteButton.addClass('disabled');
			$sendButton.addClass('disabled');
			$contentRow.removeClass('selected');	
		}
	});
	$enabledIds.each(function(index, element) {
        var $this=$(this);
		$this.click(function(){
			var $checkedIds=$('#listTable input[name="ids"]:checked');
			if($checkedIds.length==$enabledIds.length){
				$selectAll.prop('checked',true);
			}else{
				$selectAll.prop('checked',false);
			}
			if($checkedIds.length==0){
				$deleteButton.addClass('disabled');
				$sendButton.addClass('disabled');
				
			}else{
				$deleteButton.removeClass('disabled');
				$sendButton.removeClass('disabled');
			}
			if($this.prop('checked')){
				$contentRow.eq(index).addClass('selected');
			}else{
				$contentRow.eq(index).removeClass('selected');
			}
		});
    });
	
	$deleteButton.click(function(){
		var $this=$(this);
		if($this.hasClass('disabled')){
			return false;
		}
		var $checkedIds=$('#listTable input[name="ids"]:checked');
		$checkedIds.closest("tr").remove();
		$deleteButton.addClass("disabled");
		$selectAll.prop("checked", false);
		$checkedIds.prop("checked", false);
	});
});
