// JavaScript Document
function getId(obj){
	return obj==undefined ?document:document.getElementById(obj);
}
function setStyle(obj){
	obj.style.position='absolute';
	obj.style.left=0+'px';
	obj.style.top=0+'px';
	obj.className='focusin ui-widget-content';
	obj.style.textAlign='center';
}
String.prototype.trim=function(){
	return this.replace(/(^\s*)|(\s*$)/,'');
}
function getStyleObj(string){
	var num=string.lastIndexOf(';');
	var styleObj=string.substr(0,num).split(';');
	var arrObj=new Object();
	var i,len;
	for(i=0,len=styleObj.length;i<len;i++){
		var oItem=styleObj[i].split(':');
		arrObj[oItem[0].trim()]=oItem[1].trim();
	}
	return arrObj;
}

function getUnit(string){
	var pattern=/(\s*\d+\s*)/g;
	return string.replace(pattern,'');
}






;(function(){
	var oMain=getId('main');	//绘制区域
	var oText=getId('text');   //插入文字
	var oMarquee=getId('marquee');	//滚动文字
	var oDate=getId('date');
	var odiaMarque=getId('diaMarque');
	var oliveVideo=getId('livevideo');
	var oweather=getId('weather');
	var picture=getId('picture');
	var video=getId('video');
	var doc=getId('doc');
	var webpage=getId('webpage');
	var tblink=getId('tblink');
	var addImg=getId('addImg');
	var addVideo=getId('addVideo');
	var oPattern=getId('pattern');
	var oBgColor=getId('bgColor');
	var $bgColor=$('#bgColor');
	var $textColor=$('#textColor');
	//var layerBtnsave=getId('layer_btnsave');
	var btnSave=getId('btnSave');
	
	//var childMain=oMain.document.getElementById('');
	
	var oWidget=$('.ui-widget-content');
	
	var fnDbClick=function(){
		var index=layer.open({
			type:1,
			btn:['确定'],
			title:['文字编辑','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['750px','auto'],
			content:$('.layer-text'),
			yes:function(){
				/*if(layerContent.value!==sText){
					$this.find('pre').text(layerContent.value);
				}*/
				layer.closeAll();
			}
		});
	}
	

	oWidget.dele
	
	/*for(var i=0,len=oWidget.length;i<len;i++){
		$(oWidget[i]).resizable({containment:"#main"}).draggable({containment:"parent"});
		$(oWidget[i]).contextPopup({
			title:'功能编辑',
			items: [
			  {label:'删除',icon:'images/icon/delete.gif',enable:true,action:function(){oMain.removeChild($('.focusin').get(0))}, color:''},
			]
		});
		$(oWidget[i]).bind('dblclick',fnDbClick);
	}	*/
	
	var num=0;	
	
	//保存按钮
	EventUtil.addHandler(btnSave,'click',function(e){
		
		var index=layer.open({
			type:1,
			btn: ['发布', '确定'],
			title:['节目详细信息','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['635px','auto'],
			content:$('.layer-btnSave'),
			btn1:function(){
				
			}
		});
	});
	
	//文字编辑处理
	EventUtil.addHandler(oText,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var oDiv=document.createElement('div');
		var divId=this.id+(++num);		
			oDiv.setAttribute('id',divId);
			setStyle(oDiv);
			oDiv.innerHTML='<pre>请输入文字</pre>';
			oMain.appendChild(oDiv);
			$(oDiv).resizable({containment:"#main"}).draggable({containment:"parent"});
			$(oDiv).contextPopup({
				title:'功能编辑',
				items: [
				  {label:'删除',icon:'images/icon/delete.gif',enable:true,action:function(){oMain.removeChild(oDiv);}, color:''},
				]
			});
			/*$('#'+divId).bind('dblclick',function(){
				fnDbClick();
				alert(3);
			});*/
	});
	
	
	
	
	EventUtil.addHandler(oMarquee,'click',function(e){
		var index=layer.open({
			type:1,
			title:['滚动字幕','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['930px','auto'],
			content:$('.layer-marquee')
		}); 
	});
	
	EventUtil.addHandler(oweather,'click',function(e){
		var index=layer.open({
			type:1,
			title:['天气','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['600px','400px'],
			content:$('.layer-weather')
		}); 
	});
	
	
	EventUtil.addHandler(oDate,'click',function(e){
		var date=new Date();
		var oYear=date.getFullYear();
		var oMonth=date.getMonth()+1;
		var oDate=date.getDate();
		var oHour=date.getHours();
		var oMin=date.getMinutes();
		var oSec=date.getSeconds();
		var oDiv=document.createElement('div');
			oDiv.setAttribute('id',this.id+(++num));
			setStyle(oDiv);
			oDiv.innerHTML=oYear+'/'+oMonth+'/'+oDate+' '+oHour+':'+oMin+':'+oSec;
			$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
		oMain.appendChild(oDiv);
		
		$(oDiv).bind('dblclick',function(){
			var index=layer.open({
				type:1,
				title:['日期','font-size:14px;font-weight:bold'],
				shadeClose: true,
				shade: 0.8,
				area:['750px','350px'],
				content:$('.layer-date'),
			}); 
		});
	});
	
	
	EventUtil.addHandler(picture,'click',function(e){
		var index=layer.open({
			type:1,
			title:['图片','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['880px','auto'],
			content:$('.layer-picture')
		});
		
	});
	
	//添加图片按钮
	EventUtil.addHandler(addImg,'click',function(e){
		var width=getId('imgWidth').value;
		var height=getId('imgHeight').value;
		var oDiv=document.createElement('div');
			oDiv.setAttribute('id',this.id+(++num));
			setStyle(oDiv);
			var oImg=document.createElement('img');
				oImg.src='images/webpage.jpg';
				oImg.width=width;
				oImg.height=height;
				oImg.className='img';
				oImg.onload=function(){
					oDiv.appendChild(oImg);	
					$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
					oMain.appendChild(oDiv);
				}
	});
	

		
	EventUtil.addHandler(video,'click',function(e){
		var index=layer.open({
			type:1,
			title:['视频','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['880px','auto'],
			content:$('.layer-video')
		}); 
	});
	
	//添加视频按钮
	EventUtil.addHandler(addVideo,'click',function(e){
		var width=getId('viedoWidth').value;
		var height=getId('videoHeight').value;
		var oDiv=document.createElement('div');
			oDiv.setAttribute('id',this.id+(++num));
			setStyle(oDiv);
			var oImg=document.createElement('img');
				oImg.src='images/livevideo_100.jpg';
				oImg.setAttribute('videoSrc',oImg.src);
				oImg.width=width;
				oImg.height=height;
				oImg.className='img video';
				oImg.onload=function(){
					oDiv.appendChild(oImg);	
					$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
					oMain.appendChild(oDiv);
				}
	});
	
	
	EventUtil.addHandler(webpage,'click',function(e){
		var index=layer.open({
			type:1,
			title:['网络页面','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['640px','auto'],
			content:$('.layer-webpage')
		}); 
	});
	
	EventUtil.addHandler(tblink,'click',function(e){
		var index=layer.open({
			type:1,
			title:['插入链接','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['600px','auto'],
			content:$('.layer-tblink')
		}); 
	});
	
	
	
	
	
	EventUtil.addHandler(oliveVideo,'click',function(e){
		var index=layer.open({
			type:1,
			title:'视频直播',
			shadeClose: true,
			shade: 0.8,
			area:['500px','300px'],
			btn:['确定'],
			content:$('.layer-livevideo'),
			btn1:function(){
				var oDiv=document.createElement('div');
				oDiv.id='livevideo'+(++num);
				setStyle(oDiv);
				$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
				var oImg=document.createElement('img');
					oImg.src='images/livevideo_100.jpg';
				oDiv.appendChild(oImg);
				oMain.appendChild(oDiv);
				layer.close(index); 
			}
		}); 
	});
	
	
	
	EventUtil.addHandler(doc,'click',function(e){
		var index=layer.open({
			type:1,
			title:['插入文档','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['880px','auto'],
			content:$('.layer-doc')
		}); 
	});
	
	
	
	EventUtil.addHandler(oMain,'click',function(e){
		 var oEvent=EventUtil.getEvent(e);
		 var target=EventUtil.getTarget(oEvent);
		 var targetId=target.id;
		 if(targetId=='main'){
			 for(var i=0,len=target.children.length;i<len;i++){
				 if(EventUtil.hasClass(target.children[i],'focusin')){
					 EventUtil.removeClass(target.children[i],'focusin');
				 }
			 }
		 }else{			 
			EventUtil.removeAllChildClass.call(main,'focusin');	 
			 if(targetId!=''){
				 if(!EventUtil.hasClass(target,'focusin')){
					 EventUtil.addClass(target,'focusin');
				 }
			 }else{
				 if(!EventUtil.hasClass(target.parentNode,'focusin')){
					 EventUtil.addClass(target.parentNode,'focusin');
				 }
			 }
		 }	 
	});
	
	
	EventUtil.addHandler(oMain,'mouseover',function(e){
		var oEvent=EventUtil.getEvent(e);
		var target=EventUtil.getTarget(oEvent);
		if(target.id != 'main'){		
			if(target.id !=''){
				if(!EventUtil.hasClass(target,'hover')){
					EventUtil.addClass(target,'hover');
				}
			}else{
				if(!EventUtil.hasClass(target.parentNode,'hover')){
					EventUtil.addClass(target.parentNode,'hover');
				}
			}
		}
	});
	EventUtil.addHandler(oMain,'mouseout',function(e){
		var oEvent=EventUtil.getEvent(e);
		var target=EventUtil.getTarget(oEvent);
		if(target.id != 'main'){		
			if(target.id !=''){
				if(EventUtil.hasClass(target,'hover')){
					EventUtil.removeClass(target,'hover');
				}
			}else{
				if(EventUtil.hasClass(target.parentNode,'hover')){
					EventUtil.removeClass(target.parentNode,'hover');
				}
			}
		}
	});
	
	
	EventUtil.addHandler(document,'keydown',function(e){
		var oEvent=EventUtil.getEvent(e);
		var nKey=oEvent.keyCode;
		if(nKey===46){
			var delObj=document.querySelector('.focusin');
			if(delObj!=null){
				oMain.removeChild(delObj)
			}
		}
	});

	EventUtil.addHandler(oPattern,'click',function(e){
		var oEvent=EventUtil.getEvent(e);
		var target=EventUtil.getTarget(oEvent);
		var aFocusin=document.querySelector('.focusin');
		var mWidth=parseInt(EventUtil.getStyle(oMain,'width'));
		var mHeight=parseInt(EventUtil.getStyle(oMain,'height'));
		if(aFocusin!=null){
			var tWidth=parseInt(EventUtil.getStyle(aFocusin,'width'));
			var tHieght=parseInt(EventUtil.getStyle(aFocusin,'height'));
			var numX=parseInt(mWidth-tWidth)/2;
			var numY=parseInt(mHeight-tHieght)/2;
			
			if(EventUtil.hasClass(target,'gtop')){
				aFocusin.style.bottom='auto';
				aFocusin.style.top=0+'px';
			}
			else if(EventUtil.hasClass(target,'gbottom')){
				aFocusin.style.top='auto';
				aFocusin.style.bottom=0+'px';
			}
			else if(EventUtil.hasClass(target,'gleft')){
				aFocusin.style.right='auto';
				aFocusin.style.left=0+'px';
			}
			else if(EventUtil.hasClass(target,'gright')){
				aFocusin.style.left='auto';
				aFocusin.style.right=0+'px';
			}
			else if(EventUtil.hasClass(target,'gcenter')){
				aFocusin.style.right='auto';
				aFocusin.style.bottom='auto';
				aFocusin.style.left=numX+'px';
				aFocusin.style.top=numY+'px';
			}
			else if(EventUtil.hasClass(target,'vcenter')){
				aFocusin.style.right='auto';
				aFocusin.style.bottom='auto';
				aFocusin.style.left=numX+'px';
				aFocusin.style.top=numY+'px';
			}

			else if(EventUtil.hasClass(target,'bold')){
				if(aFocusin.style.fontWeight=='bold'){
					aFocusin.style.fontWeight='normal';
				}else{
					aFocusin.style.fontWeight='bold';
				}
				
			}
			else if(EventUtil.hasClass(target,'underline')){
				if(aFocusin.style.textDecoration=='underline'){
					aFocusin.style.textDecoration='none';
				}else{
					aFocusin.style.textDecoration='underline';
				}
			}
			else if(EventUtil.hasClass(target,'italic')){
				if(aFocusin.style.fontStyle=='italic'){
					aFocusin.style.fontStyle='normal';
				}else{
					aFocusin.style.fontStyle='italic';
				}
				
			}
		}
	});
	
	
	
	$bgColor.cxColor({color:'#fff'},function(api){
		$bgColor.click(function(){
			var aFocusin=document.querySelector('.focusin');
			if(aFocusin==null){
				api.hide();
				return false;
			}
		});
		$bgColor.change(function(){
			var aFocusin=document.querySelector('.focusin');
			aFocusin.style.backgroundColor=api.color();
		});
	});
	
	$textColor.cxColor({color:'#000'},function(api){
		$textColor.click(function(){
			var aFocusin=document.querySelector('.focusin');
			if(aFocusin==null){
				api.hide();
				return false;
			}
		});
		$textColor.change(function(){
			var aFocusin=document.querySelector('.focusin');
			aFocusin.style.color=api.color();
		});
	});
	
	
	$('.tabs').tabs();
	
	$('.cxColor').cxColor();
	
	
	
	/*function fnDbClick(){
		var $this=$(this);
		
		var layerContent=getId('layer-content');
		var sText=this.textContent;
		layerContent.value=sText;
				
		var index=layer.open({
			type:1,
			btn:['确定'],
			title:['文字编辑','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['750px','auto'],
			content:$('.layer-text'),
			yes:function(){
				if(layerContent.value!==sText){
					$this.find('pre').text(layerContent.value);
				}
				layer.closeAll();
			}
		});
		var arrStyle=this.getAttribute('style');

		var objStyle=getStyleObj(arrStyle);	
	
	
		for(var attr in objStyle){
			var attrStyle=attr.trim();
			var attrId=getId(attrStyle);
			if(attrId!=null){
				switch(attrStyle){
					case 'left':
					case 'top':
					case 'width':
					case 'height':
						attrId.value=parseInt(objStyle[attr]);
						var unitId=getId(attrStyle+'_unit');
						unitId.value=getUnit(objStyle[attr]);					
					break;
					case 'border-width':
					case 'padding-top':
					case 'padding-left':
					case 'padding-bottom':
					case 'padding-right':
						attrId.value=parseInt(objStyle[attr]);
					break;
					default:
						attrId.value=objStyle[attr];
				}
			}
		}
	}*/
	
})();


