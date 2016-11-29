// JavaScript Document
$(function(){
	$('#selectAll').click(function(){
		var oChildSelect=$('#cartListBody .icon-checkbox');
		if($(this).hasClass('icon-checkbox-selected')){
			$(this).removeClass('icon-checkbox-selected');
			oChildSelect.each(function(index, element) {
                $(element).removeClass('icon-checkbox-selected');
            });
		}else{
			$(this).addClass('icon-checkbox-selected');
			oChildSelect.each(function(index, element) {
                $(element).addClass('icon-checkbox-selected');
            });
		}
	});
	$('.recommend-list').hover(function(){
		$(this).find('.btn').show();
	},function(){
		$(this).find('.btn').hide();
	});
});
EventUtil.addHandler(window,'load',function(){
	var oCartListBody=document.getElementById('cartListBody');
	var oSelectAll=document.getElementById('selectAll');
	var oItemList=getClass(oCartListBody,'item-box');
	var oCheckBox=getClass(oCartListBody,'icon-checkbox');
	var i=0;
	for(i=0,len=oItemList.length;i<len;i++){
		oItemList[i].flag=true;
		EventUtil.addHandler(oItemList[i],'click',function(e){
			var that=this;
			var oEvent=EventUtil.getEvent(e);
			var target=EventUtil.getTarget(oEvent);
			var oNodeName=target.nodeName;
			var oClass=target.className;
			var oldClass='icon-checkbox-selected';
			var oGoodsNum=getClass(this,'goods-num')[0];
			var ohideValue=getClass(this,'hideId')[0]; 
			if(oNodeName.toLowerCase()=='i'){
				if(oClass.indexOf(oldClass)!==-1){					
					target.className='icon-checkbox';
					oSelectAll.className='icon-checkbox';					
					that.flag=false;
				}else{
					target.className='icon-checkbox '+oldClass;
					that.flag=true;
					for(var j=0;j<oItemList.length;j++){		
						if(!oItemList[j].flag){
							return;
						}
					}
					oSelectAll.className='icon-checkbox '+oldClass;
				}
			}		
			switch(oClass){
				case 'del':
					var oDiv=document.createElement('div');
					var oModalAlert=document.getElementById('modalAlert');
					oDiv.className='modal-backdrop';
					document.body.appendChild(oDiv);
					oModalAlert.style.display='block';		
					startMove(oModalAlert,{marginTop:-135});
					modalAlert.onclick=function(e){
						var childOvent=e||window.event;
						var childTarge=childOvent.srcElement || childOvent.target;
						var childClass=childTarge.className;
						if(childClass=='alertOk'){
							var id=ohideValue.value;
							$.ajax({
								url: contextPath+"/cart/deleteCart.do",
								type: "POST",
								data: {id: id},
								dataType: "json",
								cache: false,
								success: function(data) {
									location.reload(true);
								}
							});
							that.parentNode.removeChild(that);
						}
						oModalAlert.style.cssText='display:none;marginTop:-800px;';
						document.body.removeChild(oDiv);
					};
				break;
				case 'minus':
					if(oGoodsNum.value==1){
						return;
					}
					oGoodsNum.value--;
					var id=ohideValue.value;
					var quantity=oGoodsNum.value;
					$.ajax({
						url: contextPath+"/cart/updateCart.do",
						type: "POST",
						data: {id: id, quantity: quantity},
						dataType: "json",
						cache: false,
						success: function(data) {
							location.reload(true);
						}
					});
				break;
				case 'plus':
					oGoodsNum.value++;
					var id=ohideValue.value;
					var quantity=oGoodsNum.value;
					$.ajax({
						url: contextPath+"/cart/updateCart.do",
						type: "POST",
						data: {id: id, quantity: quantity},
						dataType: "json",
						cache: false,
						success: function(data) {
							location.reload(true);
						}
					});
				break;
			}
			
		});	
	}
});