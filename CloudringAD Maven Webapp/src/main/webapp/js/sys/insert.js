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

function searchParent(elem){
	var target=elem;
	var reg=/ui\-widget\-content/;
	while(!reg.test(target.className)){
		target=target.parentNode;
	}
	return target;
}

function toDouble(num){
	return num<10 ? '0'+num : num;
}

function getGuid(guid){
	var $compItem=$('#comp').find('.Item');
	var $that;
	$compItem.each(function(){
		var $this=$(this);
		var $cguid=$this.attr('guid');
		if($cguid==guid){
			$that=$this;
		}
	});
	return $that;
}
function getHistoryGuid(guid){
	var $compItem=$('#history').find('.Item');
	var $that;
	$compItem.each(function(){
		var $this=$(this);
		var $cguid=$this.attr('historyid');
		if($cguid==guid){
			$that=$this;
		}
	});
	return $that;
}

function getWeek(){
	var date=new Date();
	var week=['星期日','星期一','星期二','星期三','星期四','星期五','星期六'];
	return week[date.getDay()];
}
function dateFormate(num){
	var date=new Date();
	var year=date.getFullYear();
	var month=toDouble(date.getMonth()+1);
	var day=toDouble(date.getDate());
	var formateString='';
	switch(num){
		case 0:
			formateString=year+'年'+month+'月'+day+'日';
		break;
		case 1:
			formateString=year+'-'+month+'-'+day;
		break;
		case 2:
			formateString=year+'/'+month+'/'+day;
		break;
		case 3:
			formateString=month+'/'+day+'/'+year;
		break;
	};
	return formateString;
}

/*历史属性*/
function historyState(id,historyId,oParent){
	var hisDiv=document.createElement('div');
	hisDiv.className='Item';
	hisDiv.innerHTML=id;
	hisDiv.setAttribute('historyid',historyId);
	oParent.appendChild(hisDiv);
}
/*组件属性*/
function compState(oParent,historyId,content,type){
	var oCompChildLen=oParent.children.length;
	if(oCompChildLen!=0){
		$('#comp .Item').removeClass('ItemSelected');
	}
	var compDiv=document.createElement('div');
	compDiv.className='Item ItemSelected';
	compDiv.setAttribute('guid',historyId);
	var compspan1=document.createElement('span');
	compspan1.className='ShowSpan';
	compDiv.appendChild(compspan1);
	var compimg1=document.createElement('img');
	compimg1.src=contextPath+'/images/sys/icon/show.png';
	compimg1.setAttribute('title','隐藏');
	compspan1.appendChild(compimg1);
	var compDiv2=document.createElement('div');
	compDiv2.className='Content';
	compDiv2.innerHTML=content;
	compDiv.appendChild(compDiv2);
	var compspan2=document.createElement('span');
	compspan2.className='TitleSpan';
	compspan2.innerHTML=type;
	compDiv.appendChild(compspan2);
	var compspan3=document.createElement('span');
	compspan3.className='LockSpan';
	compDiv.appendChild(compspan3);
	var compimg2=document.createElement('img');
	compimg2.src=contextPath+'/images/sys/icon/unlock.png';
	compimg2.setAttribute('title','锁定');
	compspan3.appendChild(compimg2);
	oParent.appendChild(compDiv);
}
function showHistory(){
	var $compItem=$('#comp').find('.Item');
	var $mainItem=$('#main').children('div');
	$('.ItemDisable').remove();
	$compItem.each(function(index, element){
	   var $this=$(this);
	   var $state=$this.css('display');
	   if($state=='none'){
		   $this.remove();
	   }
    });
	$mainItem.each(function(index, element){
	   var $this=$(this);
	   var $state=$this.css('display');
	   if($state=='none'){
		   $this.remove();
	   }
    });
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
	//var tblink=getId('tblink');
	var addImg=getId('addImg');
	var addVideo=getId('addVideo');
	var oPattern=getId('pattern');
	var oBgColor=getId('bgColor');
	var $bgColor=$('#bgColor');
	var $textColor=$('#textColor');
	var btnSave=getId('btnSave');
	var oPlace=getId('place');
	var oPicAdd=getId('picAdd');
	var oHistory=getId('history');
	var oComp=getId('comp');
	var oModel=getId('btnInvokeTemp');
	
	var $widget=$('#main').find('.ui-widget-content');
	var oTemplateListContainerLi=$('#templateListContainer').find('li');
	
	var num=0;
	
	var oTime=getId('comp_text_time');
	var oWeek=getId('comp_text_week');
	var aDate=getId('dymd');
	var oDateFormate=getId('dateformat');
	var date=new Date();
	var hour=toDouble(date.getHours());
	var minu=toDouble(date.getMinutes());
	var second=toDouble(date.getSeconds());
	oTime.innerHTML=hour+':'+minu+':'+second;
	oWeek.innerHTML=getWeek();
	aDate.value=dateFormate(2);
	oDateFormate.onchange=function(){
		var type=parseInt(this.value);
		aDate.value=dateFormate(type);
	};
	
	$widget.each(function(index, element) {
		var $this=this;
		var pguid=$this.getAttribute('guid');
		var src=$this.getAttribute('data_img');
		var text=$this.getAttribute('data_text');
        $(this).resizable({containment:"#main"}).draggable({containment:"parent"});
        var word=this.textContent;
        historyState(this.id,pguid,oHistory);
		if(src){
			compState(oComp,pguid,'<img src='+src+'>',text);		
		}else{
			compState(oComp,pguid,word,text);		
		}
		$(this).contextPopup({
			title:'功能编辑',
			items: [
			  {
				 label:'删除',icon:contextPath+'/images/sys/icon/delete.gif',
				 enable:true,
				 action:function(){
					 oMain.removeChild($this);
					 getGuid(pguid).remove();
				 },
				 color:''
			   }
			]
		});
    });	
	
		//保存按钮
		EventUtil.addHandler(btnSave,'click',function(e){
			$(".ui-resizable-handle").remove();				
			var text1 = $("#wrapAll").html();
			$("#context_video").val(text1);				
			$("#context").val(text1);
			var text='';
			var oldHtml=$('#wrapAll').clone(true);
			var videogroup=oldHtml.find(".videogroup");
			var videoLength=videogroup.length;
			var $clock=oldHtml.find(".clock");
			var clockLength=$clock.length;
			var $pdf=oldHtml.find(".pdf");
			var pdfLength=$pdf.length;
			if(videoLength && clockLength &&pdfLength){
				$clock.each(function(){
					var $this=$(this);
					var $type=parseInt($this.attr('type'));
					if($type){
						$this.find('prev').remove();
						this.style.textAlign='left';
					}else{
						EventUtil.removeClass(this,'clock');
					}
				});
				oldHtml.find('.videogroup img').remove();
				oldHtml.find(".videoSource").css('display', 'block'); //显示
				
				oldHtml.find('.pdf img').remove();
				oldHtml.find(".media").css('display', 'block'); //显示
				
				text=oldHtml.html();
				$("#context").val(text);
			}else if(!videoLength && clockLength && pdfLength){
				$clock.each(function(){
					var $this=$(this);
					var $type=parseInt($this.attr('type'));
					if($type){
						$this.find('prev').remove();
						this.style.textAlign='left';
					}else{
						EventUtil.removeClass(this,'clock');
					}
				});
				oldHtml.find('.pdf img').remove();
				oldHtml.find(".media").css('display', 'block'); //显示		
				text=oldHtml.html();	
				$("#context").val(text);
			}else if(videoLength && !clockLength && pdfLength){
				oldHtml.find('.videogroup img').remove();
				oldHtml.find(".videoSource").css('display', 'block'); //显示
				oldHtml.find('.pdf img').remove();
				oldHtml.find(".media").css('display', 'block'); //显示		
				text=oldHtml.html();	
				$("#context").val(text);
			}else if(videoLength && clockLength && !pdfLength){
				$clock.each(function(){
					var $this=$(this);
					var $type=parseInt($this.attr('type'));
					if($type){
						$this.find('prev').remove();
						this.style.textAlign='left';
					}else{
						EventUtil.removeClass(this,'clock');
					}
				});
				oldHtml.find('.videogroup img').remove();
				oldHtml.find(".videoSource").css('display', 'block'); //显示
				
				text=oldHtml.html();
				$("#context").val(text);
			}else if(!videoLength && clockLength &&!pdfLength){
				$clock.each(function(){
					var $this=$(this);
					var $type=parseInt($this.attr('type'));
					if($type){
						$this.find('prev').remove();
						this.style.textAlign='left';
					}else{
						EventUtil.removeClass(this,'clock');
					}
				});
				text=oldHtml.html();
				$("#context").val(text);
			}else if(videoLength && !clockLength &&!pdfLength){
				oldHtml.find('.videogroup img').remove();
				oldHtml.find(".videoSource").css('display', 'block'); //显示
				text=oldHtml.html();	
				$("#context").val(text);
			}else if(!videoLength && !clockLength &&pdfLength){
				oldHtml.find('.pdf img').remove();
				oldHtml.find(".media").css('display', 'block'); //显示		
				text=oldHtml.html();
				$("#context").val(text);
			}
		var program_name = trim($("#program_name").val());
		var videoPlace=$(".video_place");
		if(videoPlace.length){	
			var left='';
			var top='';
			var width='';
			var height='';
			var ip='';
			videoPlace.each(function() {
				var _this=this;
				var objAttr={
						width:EventUtil.getStyle(_this,'width'),
						height:EventUtil.getStyle(_this,'height'),
						left:EventUtil.getStyle(_this,'left'),
						top:EventUtil.getStyle(_this,'top'),
						ip:this.getAttribute('data-ip')
					};
				left+=parseInt(objAttr.left.substring(0,objAttr.left.indexOf("px")))+"px"+",";
				top+=parseInt(objAttr.top.substring(0,objAttr.top.indexOf("px")))+"px"+",";
				width+=parseInt(objAttr.width.substring(0,objAttr.width.indexOf("px")))+"px"+",";
				height+=parseInt(objAttr.height.substring(0,objAttr.height.indexOf("px")))+"px"+",";
				ip+=objAttr.ip+"#";
			});
			
			$("#video_stream").val(ip.substring(0,ip.length-1)),
			$("#stream_left").val(left.substring(0,left.length-1)),
			$("#stream_top").val(top.substring(0,top.length-1)),
			$("#stream_width").val(width.substring(0,width.length-1)),
			$("#stream_height").val(height.substring(0,height.length-1));
		}else{
			$("#video_stream").val(null),
			$("#stream_left").val(null),
			$("#stream_top").val(null),
			$("#stream_width").val(null),
			$("#stream_height").val(null);
			$("#videoPlace_url").val(null);
		}	
		var $form = $("#frm");		
		 $.ajax({
				type : "post",
				url : contextPath + "/program/showProgramDetails.do",
				data : {
					id : $("#id").val(),
					scenes:$("#scenes").val()
				},
				dataType : "json",
				success : function(data) {	
					var sonId=$("#sonId").val();
					var $table=$(".table-btnSave");
					var html='';
					var time=data[0].time;
					var playTime;
					if(time==undefined){
						time=0;
					}
					playTime=$("#play_time").val()*1+time*1;					
					html+="<tr><th colspan=\"4\">节目名称: "+program_name+" 播放时间: "+playTime+" 秒</th></tr><tr>";
					if(data[0].list!=undefined){
						$.each(data[0].list, function(i, item){
							var music;
							if(item.is_b_music==0){
								music="无";
							}else{
								music="有";
							}
							if($("#scenes").val()==item.scenes){
								html+="<td>"+item.scenes+"</td><td>名称:"+item.scenes+"</td><td>场景时长:"+$("#play_time").val()+"秒</td><td>背景音乐:"+music+"</td></tr>";     
							}else{
								html+="<td>"+item.scenes+"</td><td>名称:"+item.scenes+"</td><td>场景时长:"+item.play_time+"秒</td><td>背景音乐:"+music+"</td></tr>";     
							}
							                        
						});	
					}
					
				
					if(sonId==''){	
						if($("#bagrmusic").val()==""){
							html+="<td>"+$("#scenes").val()+"</td><td>名称:"+$("#scenes").val()+"</td><td>场景时长:"+$("#play_time").val()+"秒</td><td>背景音乐:无</td></tr>";
						}else{
							html+="<td>"+$("#scenes").val()+"</td><td>名称:"+$("#scenes").val()+"</td><td>场景时长:"+$("#play_time").val()+"秒</td><td>背景音乐:有</td></tr>";
						}
					}
					$table.html(html);					
					var index=layer.open({
						type:1,
						btn: ['发布', '确定'],
						title:['节目详细信息','font-size:14px;font-weight:bold'],						
						area:['635px','auto'],
						content:$('.layer-btnSave'),
						btn1 : function() {// 发布
							var url = contextPath + '/publish/saveToPublish.do';
							if (program_name == null || trim(program_name) == '') {
								alert("节目名称不能为空！");
								return false;
							} else {	
								$("#program_name").attr("disabled",false);
								$("#program_name").val(program_name);
								$("#scenes").val(trim($("#scenes").val()));
								$form.attr("action", url);
								$form.submit();
							}
						},
						cancel : function() {// 保存
							if (program_name == null || trim(program_name) == '') {
								alert("节目名称不能为空！");
								return false;
							} else {
								$.ajax({
											url : contextPath + "/program/save.do",
											type : "POST",
											cache : false,
											async : true,
											dataType : "json",
											data : {
												program_name : program_name,
												context : $("#context").val(),
												resolution : $("#sel_screenRate").val(),
												program_type : $("#program_type").val(),
												release_time : $("#release_time").val(),
												bagrmusic : $("#bagrmusic").val(),
												scenes : trim($("#scenes").val()),
												play_time : $("#play_time").val(),									
												id : $("#id").val(),
												sonId : $("#sonId").val(),
												video_url:$("#video_url").val(),
												imgae_url:$("#imgae_url").val(),
												video_stream:$("#video_stream").val(),
												stream_left:$("#stream_left").val(),
												stream_top:$("#stream_top").val(),
												stream_width:$("#stream_width").val(),
												stream_height:$("#stream_height").val(),
												videoPlace_url:$("#videoPlace_url").val(),
												pdf_url:$("#pdf_url").val(),
												background_picture:$("#background_picture").val(),
												context_video:$("#context_video").val()
											},
											success : function(jsonData) {
											 var id=jsonData[0].id;	
											 var sonId=jsonData[0].sonId;	
											 var scens=jsonData[0].scens;	
//											$("#program_name").attr("disabled","disabled");							
											$("#id").val(id);
											$("#sonId").val(sonId);	
											$("#switchScene").html("");
											$("#switchScene").append("<option value=\"切换场景\" selected>切换场景</option>");    
											$.each(scens, function(key, value){
												$("#switchScene").append("<option value="+value.id+">"+value.scenes+"</option>");                                    
											});
											
											},
											error : function() {
												alert("保存时出现异常！");
											}
										});
							}
						}
					});
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
					return false;
				}
			});
		});
	//选择模板
	EventUtil.addHandler(oModel,'click',function(e){
		var index=layer.open({
			type:1,
			title:['选择模板','font-size:14px;font-weight:bold'],
			area:['780px','400px'],
			content:$('.layer-model')
		});
	});
	//选择模板单击事件
	oTemplateListContainerLi.bind('click',function(){
		var $this=$(this);
		var $id=$this.find('span').attr('id');
		$.ajax({
			type : "post",
			url : contextPath + "/program/showProgramTemplatJson.do",
			data : {
				id : $id
			},
			dataType : "json",
			success : function(data) {	
			   var p=data[0].template; 
			   if(p.play_time==''){
					$("#play_time").val(15);
			   }else{
					$("#play_time").val(p.play_time);
			   }
			   
			  	$("#video_url").val(p.video_url);
				$("#imgae_url").val(p.imgae_url);			
				$("#videoPlace_url").val(p.videoPlace_url);	
				$("#pdf_url").val(p.pdf_url);
				$("#sel_screenRate").val(p.resolution);
				$("#main").html(p.context_video);
				layer.closeAll();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
				return false;
			}
		});
		
	});
	//监控区域
	EventUtil.addHandler(oPlace,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		showHistory();
		var oDiv=document.createElement('div');
		oDiv.setAttribute('guid',historyId);
		oDiv.id='videoPlace'+(++num);
		setStyle(oDiv);
		oDiv.setAttribute('data-target','video_place');
		oDiv.setAttribute('data-ip','A');
		oDiv.style.width=800+'px';
		oDiv.style.height=600+'px';
		oDiv.className+=" video_place";
		$(oDiv).resizable({containment:"#main"}).draggable({containment:"parent"});
		var oImg=document.createElement('img');
		oImg.src=contextPath+'/images/sys/video_control.png';
		oImg.className='img';
		oDiv.setAttribute('data_img',contextPath+'/images/video_control.png');
		oDiv.setAttribute('data_text','监控');
		$("#videoPlace_url").val(contextPath+'/images/sys/video_control.png');
		oImg.onload=function(){
			oDiv.appendChild(oImg);
		};
		$(oDiv).resizable({containment:"#main"}).draggable({containment:"parent"});
		oMain.appendChild(oDiv);
		$(oDiv).contextPopup({
			title:'功能编辑',
			items: [
			  {
				  label:'删除',icon:contextPath+'/images/sys/icon/delete.gif',enable:true,action:function(){
				  	oMain.removeChild(oDiv); 
					var pguid=$(oDiv).attr('guid');
				 	getGuid(pguid).remove();},
				  color:''
			}]
		});
		historyState(this.id,historyId,oHistory);	
		compState(oComp,historyId,'<img src="'+contextPath+'/images/video_control.png">','监控');
	});


	
	
	
	//文字编辑处理
	EventUtil.addHandler(oText,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		showHistory();
		var oDiv=document.createElement('div');
		var divId=this.id+(++num);		
			oDiv.setAttribute('id',divId);
			setStyle(oDiv);
			oDiv.innerHTML='<span>请输入文字</span>';
			oDiv.setAttribute('guid',historyId);
			oDiv.setAttribute('data_text','文本');
		$(oDiv).resizable({containment:"#main"}).draggable({containment:"parent"});
		oMain.appendChild(oDiv);
		
		historyState(this.id,historyId,oHistory);
		compState(oComp,historyId,'请输入文本','文本');
		
		$(oDiv).contextPopup({
			title:'功能编辑',
			items: [
			  {
				  label:'删除',icon:contextPath+'/images/sys/icon/delete.gif',enable:true,action:function(){
				  	oMain.removeChild(oDiv); 
					var pguid=$(oDiv).attr('guid');
				 	getGuid(pguid).remove();
			  }, color:''}
			]
		});
	});
	
	$(oMain).delegate('.ui-widget-content','dblclick',function(){
		var $this=$(this);
		var $id=$this.attr('id');
		var reg=/text/;
		var regPlace=/videoPlace/;
		var pdf=/pdf/;
		var date=/date(\d+)/;
		var marquee=/marquee(\d+)/;
		var picture=/picture(\d+)/;
		var video=/^video(\d+)/;
		var livevideo=/^livevideo(\d+)/;
		if(reg.test($id)){
			var layerContent=getId('layer-content');
			var sText=this.textContent;
			layerContent.value=sText;
			var attrArr=['left','top','width','height','border-width','padding-top','padding-right','padding-bottom','padding-left'];
			var styleArr=['font-weight','text-decoration','font-style'];
			var selectAttr=['text-align','font-size','font-family','border-style'];
			var colorObj={
				color:'#000000',
				'background-color':'#ffffff',
				'border-color':'#000000'
			};
			for(var i in attrArr){
				var elem=getId(attrArr[i]);
				elem.value='';
			}
			for(var i in styleArr){
				var elem=getId(styleArr[i]);
				elem.checked=false;
			}
			for(var i in selectAttr){
				var elem=getId(selectAttr[i]);
				elem.value='0';
			}
			
			for(var attr in colorObj){
				var elem=getId(attr);
				elem.value=colorObj[attr];
				elem.style['background-color']=colorObj[attr];
			}
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
						case 'border-width':
						case 'padding-top':
						case 'padding-left':
						case 'padding-bottom':
						case 'padding-right':
							attrId.value=parseInt(objStyle[attr]);
							break;
						case 'text-align':
						case 'font-size':
						case 'font-family':
						case 'border-style':
							attrId.value=objStyle[attr];
							break;
						case 'font-weight':
						case 'text-decoration':
						case 'font-style':
							attrId.checked=true;
							break;
						case 'color':
						case 'background-color':
						case 'border-color':
							attrId.style['background-color']=objStyle[attr];
							attrId.value=objStyle[attr];
							break;
						default:
							attrId.value=objStyle[attr];
					}
				}else{
					switch(attrStyle){
						case 'padding':
							getId(attrStyle+'-top').value=parseInt(this.style.paddingTop);
							getId(attrStyle+'-left').value=parseInt(this.style.paddingLeft);
							getId(attrStyle+'-right').value=parseInt(this.style.paddingRight);
							getId(attrStyle+'-bottom').value=parseInt(this.style.paddingBottom);
							break;
						case 'border':
							getId(attrStyle+'-width').value=parseInt(this.style.borderWidth);
							getId(attrStyle+'-style').value=parseInt(this.style.borderStyle);
							getId(attrStyle+'-color').value=parseInt(this.style.borderColor);
							break;
					}
				}
			}
			var index=layer.open({
				type:1,
				btn:['确定','取消'],
				title:['文字编辑','font-size:14px;font-weight:bold'],
				area:['750px','auto'],
				content:$('.layer-text'),
				yes:function(){
					var $pguid=$this.attr('guid');
					getGuid($pguid).find('.Content').html(layerContent.value);
					var styleObj={
						position:'absolute'
					}
					var style='';	
					for(var i in attrArr){
						var elem=getId(attrArr[i]);
						var value=parseInt(elem.value);
						if(value!='' && !isNaN(value)){
							styleObj[attrArr[i]]=value+'px';
						}
					}
					for(var i in styleArr){
						var elem=getId(styleArr[i]);
						if(elem.checked){
							styleObj[styleArr[i]]=elem.value;
						}
					}
					for(var i in selectAttr){
						var elem=getId(selectAttr[i]);
						var value=elem.value;
						if(value!=0){
							styleObj[selectAttr[i]]=value;
						}
					}
					
					for(var attr in colorObj){
						var elem=getId(attr);
						if(elem.value!=colorObj[attr]){
							styleObj[attr]=elem.value;
						}
					}
					
					for(var attr in styleObj){
						style+=attr+':'+styleObj[attr]+';';
					}
					
					$this.attr('style',style);
					
					if(layerContent.value!==sText){
						$this.find('span').text(layerContent.value);
					}
					
					layer.closeAll();
				}
			});
		}else if(marquee.test($id)){
			var marqueeObj=this.getElementsByTagName('marquee')[0];
			var marqueeText=getId('marqueeText');
			marqueeText.value=marqueeObj.innerHTML;
			var marqueeCss={
				'font-family':'inherit',
				'font-size':12,
				color:'#000',
				'font-weight':false
			};
			var marqueeStyle={
				direction:'left',
				scrollamount:'scroll',
				behavior:12,
				loop:-1
			};
			var arrStyle=marqueeObj.getAttribute('style');
			var objStyle=getStyleObj(arrStyle);
			for(var attr in objStyle){
				var attrStyle=attr.trim();
				var attrId=getId('marquee-'+attrStyle);
				if(attrId!=null){
					if('font-weight'===attr){
						if(objStyle[attr]=='bold'){
							attrId.checked=true;
						}else{
							attrId.checked=false;
						}
					}else if('font-size'===attr){
						attrId.value=parseInt(objStyle[attr]);
					}else if('color'==attr){
						attrId.style['background-color']=objStyle[attr];
						attrId.value=objStyle[attr];
					}else{
						attrId.value=objStyle[attr];
					}
				}
			}
			for(var prop in marqueeStyle){
				var attrId=getId('marquee-'+prop);
				attrId.value=marqueeObj.getAttribute(prop);	
			}
			var index=layer.open({
				type:1,
				btn:['确定','取消'],
				title:['滚动字幕','font-size:14px;font-weight:bold'],
				area:['930px','auto'],
				content:$('.layer-marquee'),
				yes:function(){
					var marqueeVal=marqueeText.value;
					var $pguid=$this.attr('guid');
					getGuid($pguid).find('.Content').html(marqueeVal);	
					for(var css in marqueeCss){
						var target=getId('marquee-'+css);
						if('font-weight'===css){
							marqueeCss[css]=target.checked;
						}else{
							marqueeCss[css]=target.value;
						}
					}
					for(var style in marqueeStyle){
						var target=getId('marquee-'+style);
						marqueeStyle[style]=target.value;
					}
					if(!marqueeVal){
						alert('请输入文字内容!')
						marqueeText.focus();
					}else{
						marqueeObj.innerHTML=marqueeVal;
						var cssStyle='';
						for(var style in marqueeStyle){
							marqueeObj.setAttribute(style,marqueeStyle[style]);
						}
						for(var css in marqueeCss){
							if(css=='font-weight'){
								if(marqueeCss[css]){
									marqueeCss[css]='bold';
								}else{
									marqueeCss[css]='normal';
								}
							}else if(css=='font-size'){
								marqueeCss[css]+='px';
							}
							cssStyle+=css+':'+marqueeCss[css]+';';
						}
						$(marqueeObj).attr('style',cssStyle);
						layer.closeAll();
					}
				}
			}); 
		}else if(date.test($id)){
			var attrArr=['left','top','width','height','border-width','padding-top','padding-right','padding-bottom','padding-left'];
			var styleArr=['font-weight','text-decoration','font-style'];
			var selectAttr=['text-align','font-size','font-family','border-style'];
			var colorObj={
				color:'#000000',
				'background-color':'#ffffff',
				'border-color':'#000000'
			};
			for(var i in attrArr){
				var elem=getId('date-'+attrArr[i]);
				elem.value='';
			}
			for(var i in styleArr){
				var elem=getId('date-'+styleArr[i]);
				elem.checked=false;
			}
			for(var i in selectAttr){
				var elem=getId('date-'+selectAttr[i]);
				elem.value='0';
			}
			
			for(var attr in colorObj){
				var elem=getId('date-'+attr);
				elem.value=colorObj[attr];
				elem.style['background-color']=colorObj[attr];
			}
			var arrStyle=this.getAttribute('style');
			var objStyle=getStyleObj(arrStyle);
			for(var attr in objStyle){
				var attrStyle=attr.trim();
				var attrId=getId('date-'+attrStyle);
				if(attrId!=null){
					switch(attrStyle){
						case 'left':
						case 'top':
						case 'width':
						case 'height':
						case 'border-width':
						case 'padding-top':
						case 'padding-left':
						case 'padding-bottom':
						case 'padding-right':
							attrId.value=parseInt(objStyle[attr]);
							break;
						case 'text-align':
						case 'font-size':
						case 'font-family':
						case 'border-style':
							attrId.value=objStyle[attr];
							break;
						case 'font-weight':
						case 'text-decoration':
						case 'font-style':
							attrId.checked=true;
							break;
						case 'color':
						case 'background-color':
						case 'border-color':
							attrId.style['background-color']=objStyle[attr];
							attrId.value=objStyle[attr];
							break;
						default:
							attrId.value=objStyle[attr];
					}
				}else{
					switch(attrStyle){
						case 'padding':
							getId('date-'+attrStyle+'-top').value=parseInt(this.style.paddingTop);
							getId('date-'+attrStyle+'-left').value=parseInt(this.style.paddingLeft);
							getId('date-'+attrStyle+'-right').value=parseInt(this.style.paddingRight);
							getId('date-'+attrStyle+'-bottom').value=parseInt(this.style.paddingBottom);
							break;
						case 'border':
							getId('date-'+attrStyle+'-width').value=parseInt(this.style.borderWidth);
							getId('date-'+attrStyle+'-style').value=parseInt(this.style.borderStyle);
							getId('date-'+attrStyle+'-color').value=parseInt(this.style.borderColor);
							break;
					}
				}
			}

			var index=layer.open({
				type:1,
				btn:['确定'],
				title:['日期','font-size:14px;font-weight:bold'],
				area:['750px','350px'],
				content:$('.layer-date'),
				yes:function(){
					var styleObj={
						position:'absolute'
					};
					var style='';	
					for(var i in attrArr){
						var elem=getId('date-'+attrArr[i]);
						var value=parseInt(elem.value);
						if(value!='' && !isNaN(value)){
							styleObj[attrArr[i]]=value+'px';
						}
					}
					for(var i in styleArr){
						var elem=getId('date-'+styleArr[i]);
						if(elem.checked){
							styleObj[styleArr[i]]=elem.value;
						}
					}
					for(var i in selectAttr){
						var elem=getId('date-'+selectAttr[i]);
						var value=elem.value;
						if(value!=0){
							styleObj[selectAttr[i]]=value;
						}
					}
					
					for(var attr in colorObj){
						var elem=getId('date-'+attr);
						if(elem.value!=colorObj[attr]){
							styleObj[attr]=elem.value;
						}
					}
					
					for(var attr in styleObj){
						style+=attr+':'+styleObj[attr]+';';
					}
					var bShowWeek=getId('comp_check_week').checked;
					
					var oPrev=getId($id).getElementsByTagName('prev')[0];
					
					if(bShowWeek){
						oPrev.innerHTML=aDate.value+' '+oWeek.innerHTML+' '+oTime.innerHTML;
					}else{
						oPrev.innerHTML=aDate.value+' '+oTime.innerHTML;
					}
					$this.attr('type',getId('datestyle').value);
					var $pguid=$this.attr('guid');
					getGuid($pguid).find('.Content').html(oPrev.innerHTML);	
					$this.attr('style',style);
					layer.closeAll();
				}
			});
		}else if(picture.test($id)){			
			var id=$id;
			var $pguid=$this.attr('guid');
			//先把_srcX里面的url拿出来，通过ajax返回下面的表格数据。
			var $img=$("#"+id+" img");
			var index=$img.attr('index');
			var $src_url='';
			for(var i=0;i<index;i++){
				var _src=$img.attr('_src'+i+'');
				$src_url+=_src+",";
			}
			$src_url=$src_url.substring(0,$src_url.length-1);
			var $tableList=$('#unpoaded_list');
			$.ajax({
				type : "post",
				url : contextPath + "/program/showImgOrVideo.do",
				data : {
					url : $src_url				
				},
				dataType : "json",
				success : function(data) {
				   var jsonObj=data;
				   searchImgae();
				   $tableList.html("");				   
				   var html="<tbody><tr><td><input name=\"ckAllImage\" id=\"uploaded_all\" type=\"checkbox\"></td><td>图片名称</td> <td>分类</td>";
				    html+="<td>图片路径</td><td>尺寸(像素)</td><td>大小</td></tr>";
				     $.each(jsonObj, function (i, item) {
				    	 html+="<tr><td><input type=\"checkbox\" name=\"imageId\" value=\""+item.id+"\" class=\"pic_checkbox\"> </td> <td>"+item.name+"</td><td>图片</td><td><p style=\"width: 190px\; class=\"maxLength\">"+item.file_path+"</p></td>";
				         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
				     });	
				     html+="</tbody>";	   
				     $tableList.html(html);
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
					return false;
				}
			});
			
			var $imgae_url='';
			var that=this;
			var swip=that.getAttribute("data-swiper");
			$("#swiperType").val(swip); 
			var index=layer.open({
				type:1,
				title:['图片','font-size:14px;font-weight:bold'],
				btn:['确定','取消'],			
				area:['880px','auto'],
				content:$('.layer-picture'),
				yes:function(){				
					var $unpoadedList=$('#unpoaded_list');
					var $checkBox=$unpoadedList.find('.pic_checkbox');
					var imgArr=[];
					$checkBox.each(function(index,element){
						var $this=$(this);				
							imgArr.push($this.parents('tr').find('p').html());
					});
					if(imgArr.length){
						var width=getId('imgWidth').value;
						var height=getId('imgHeight').value;
						that.width=width;
						that.height=height;	
						that.setAttribute('data-swiper',getId('swiperType').value);
						$("#"+id+" img").remove();						
						var oImg=document.createElement('img');
						oImg.src=imgArr[0];
						oImg.width=width;
						oImg.height=height;
						oImg.className='img';
						oImg.setAttribute('index',imgArr.length);
						for(var i=0,len=imgArr.length;i<len;i++){
							oImg.setAttribute('_src'+i,imgArr[i]);
							$imgae_url+=imgArr[i]+",";
						}
						var imgUrl=$("#imgae_url").val();
						if(imgUrl.length>0){
							$("#imgae_url").val($imgae_url.substring(0,$imgae_url.length-1)+","+imgUrl);
						}else{
							$("#imgae_url").val($imgae_url.substring(0,$imgae_url.length-1));
						}
						
						oImg.onload=function(){
							that.appendChild(oImg);	
						};
						 layer.closeAll();
					}else{
						alert("请选择至少一张图片");					
					}
				}
			});
		}else if(livevideo.test($id)){
			var index=layer.open({
				type:1,
				title:'视频直播',			
				area:['500px','300px'],
				btn:['确定','取消'],
				content:$('.layer-livevideo'),
				yes:function(){
					if(!$('select[name="v-src"]').val()){
						layer.alert('请选择视频直播地址！');
					}else{
						layer.close(index);
					}
				}
			}); 
			
		}else if(video.test($id)){
					var $width=parseInt($this.css('width'));
					var $height=parseInt($this.css('height'));
					getId('viedoWidth').value=$width;
					getId('videoHeight').value=$height;
			        var id=$id;	
			        var $pguid=$this.attr('guid');
			        var $video=$("#"+id+" video");
					var index=$video.attr('tabindex');
					var $src_url='';
					for(var i=0;i<index;i++){
						var _src=$video.attr('_src'+i+'');
						$src_url+=_src+",";
					}
					$src_url=$src_url.substring(0,$src_url.length-1);
					var $tableList=$('#unpoaded_video');
					$.ajax({
						type : "post",
						url : contextPath + "/program/showImgOrVideo.do",
						data : {
							url : $src_url				
						},
						dataType : "json",
						success : function(data) {
						   var jsonObj=data;
						   searchVideo();
						   $tableList.html("");				   
						   var html="<tbody><tr><td><input id=\"videoed_all\" type=\"checkbox\"></td><td>视频名称</td><td>分类</td> <td>视频路径</td>";
						    html+="<td>尺寸(像素)</td><td>大小</td></tr>";
						     $.each(jsonObj, function (i, item) {
						    	 html+="<tr><td><input type=\"checkbox\" name=\"videoId\" value=\""+item.id+"\" class=\"video_checkbox\"></td><td>"+item.name+"["+item.video_play_time+"]</td><td>视频</td> <td><p style=\"width: 190px;\" class=\"maxLength\">"+item.file_path+"</p></td>";
						         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
						     });	
						     html+="</tbody>";	   
						     $tableList.html(html);
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							alert(errorThrown);
							return false;
						}
					});
					var $video_url='';
					var that=this;
					var index=layer.open({
						type:1,
						title:['视频','font-size:14px;font-weight:bold'],
						btn:['确定','取消'],				
						area:['880px','auto'],
						content:$('.layer-video'),
						yes:function(){	
							var $unpoaded_video=$('#unpoaded_video');
							var $checkBox=$unpoaded_video.find('.video_checkbox');
							var videoArr=[];
							var videoTime=[];
							var play;
							$checkBox.each(function(index,element){
								var $this=$(this);						
									videoArr.push($this.parents('tr').find('p').html());
									play=$this.parents('tr').find('td:nth-child(2)').text();
									videoTime.push(play.substring(play.lastIndexOf("[")+1,play.length-1));
								
							});
							if(videoArr.length){
								var width=getId('viedoWidth').value;
								var height=getId('videoHeight').value;
								that.style.width=width+'px';
								that.style.height=height+'px';
								$("#"+id+" img").remove();	
								$("#"+id+" video").remove();
								var oImg=document.createElement('img');				
								oImg.src=contextPath+'/images/sys/video.jpg';
								var video=document.createElement('video');
								video.className='videoSource';
								oImg.setAttribute('videoSrc',oImg.src);
								oImg.width=width;
								oImg.height=height;
									
									oImg.className='img video';
									video.setAttribute('tabindex',videoArr.length);							
									video.setAttribute('autoplay','true');
									video.setAttribute('poster',contextPath+'/images/sys/video.jpg');
									video.style.display='none';
									for(var i=0,len=videoArr.length;i<len;i++){
										video.setAttribute('_src'+i,videoArr[i]);
										$video_url+=videoArr[i]+",";
									}
									var play_time=0;
									for(var i=0;i<videoTime.length;i++){
										play_time=videoTime[i]*1+play_time*1;
									}						
									video.src=videoArr[0];
									var videoUrl=$("#video_url").val();
									if(videoUrl.length>0){
										$("#video_url").val($video_url.substring(0,$video_url.length-1)+","+videoUrl);
									}else{
										$("#video_url").val($video_url.substring(0,$video_url.length-1));
									}
								
									var playTime=$("#play_time").val();
									if(playTime!=null){
										if(playTime*1<play_time){
											$("#play_time").val(play_time);
										}else{
											$("#play_time").val(playTime);
										}
									}else{
										$("#play_time").val(play_time);
									}
									oImg.onload=function(){
										that.appendChild(oImg);	
										that.appendChild(video);	
										
									};
									 layer.closeAll();
							}else{
								alert("请选择至少一部视频");	
							}
						}
					}); 
		}else if(pdf.test($id)){
			var index=layer.open({
				type:1,
				title:['插入文档','font-size:14px;font-weight:bold'],
				btn:['确定','取消'],
				area:['880px','auto'],
				content:$('.layer-doc'),
				btn1:function(){
					var $pdfUrl=$("#pdf_url").val();					
					var media=$(".media");		
					media.attr('href',$pdfUrl);					
					layer.close(index); 
				}
			});
		}else if(regPlace.test($id)){
			var objAttr={
				width:EventUtil.getStyle(this,'width'),
				height:EventUtil.getStyle(this,'height'),
				left:EventUtil.getStyle(this,'left'),
				top:EventUtil.getStyle(this,'top'),
				ip:this.getAttribute('data-ip')
			};			
			$this.flag=true;
			var newAttr=[];		
			document.querySelector('.layer-monitor input[name=left]').value=objAttr.left;
			document.querySelector('.layer-monitor input[name=top]').value=objAttr.top;
			document.querySelector('.layer-monitor input[name=width]').value=objAttr.width;
			document.querySelector('.layer-monitor input[name=height]').value=objAttr.height;
			document.querySelector('.layer-monitor [name="monitor-ip"]').value=objAttr.ip;	
			var index=layer.open({
				type:1,
				btn:['确定','取消'],
				title:['视频监控','font-size:14px;font-weight:bold'],				
				area:['350px','auto'],
				content:$('.layer-monitor'),
				yes:function(){
					if(!$this.flag){
						var target=getId($id);
						var ip=getId('stream').value;					
						for(var attr in newAttr){
							target.style[attr]=parseInt(newAttr[attr])? parseInt(newAttr[attr])+'px':0+'px';
						}
						target.setAttribute('data-ip',ip);
						
					}
					layer.closeAll();
				}
			});
			var oInput=document.querySelectorAll('.layer-monitor .monitor-inp');
			for(var i=0,len=oInput.length;i<len;i++){
				oInput[i].onchange=function(){
					$this.flag=false;
					newAttr[this.getAttribute('name')]=this.value;
				};
			}
			var stream=$("#stream").val();
			
		}else if($id=='myweather'){
			var target=getId('weatherArea');
			var oFontSize=getId('weather-font-size');
			var oWeatherColor=getId('weather-color');
			var oFontWeight=getId('weather-font-weight');
			var fontSize=parseInt(target.style.fontSize);
			var weatherColor=target.style.color;
			var fontWeight=target.style.fontWeight=='bold' ? true : false;
			oFontSize.value=fontSize;
			oWeatherColor.style.backgroundColor=weatherColor;
			oFontWeight.checked=fontWeight;
			var index=layer.open({
				type:1,
				title:['天气','font-size:14px;font-weight:bold'],
				btn:['确定','取消'],
				area:['600px','300px'],
				content:$('.layer-weather'),
				btn1:function(){
					var weatherObj=getId('weatherArea');
						fontSize=parseInt(getId('weather-font-size').value);
						weatherColor=getId('weather-color').value;
					var bFont=getId('weather-font-weight').checked;
					var fontWeight=bFont?'bold':'normal';	
						weatherObj.style.fontSize=fontSize+'px';
						weatherObj.style.fontWeight=fontWeight;
						weatherObj.style.color=weatherColor;
						layer.closeAll();
				}
			}); 
		}
	});
	
	
	
	EventUtil.addHandler(oMarquee,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var marqueeText=getId('marqueeText');
	var historyId=Math.random().toString(36).substr(2);
		showHistory();
		historyState(this.id,historyId,oHistory);	
		compState(oComp,historyId,'','滚动字幕');
		var marqueeCss={
			'font-family':'inherit',
			'font-size':12,
			color:'#000',
			'font-weight':false
		};
		var marqueeStyle={
			direction:'left',
			scrollamount:1,
			behavior:'scroll',
			loop:-1
		};
		for(var css in marqueeCss){
			var target=getId('marquee-'+css);
			if('font-weight'===css){
				target.checked=marqueeCss[css];
			}else if('color'===css){
				target.style['backgroundColor']=marqueeCss[css];
			}else{
				target.value=marqueeCss[css];
			}
		}
		for(var style in marqueeStyle){
			var target=getId('marquee-'+style);
		/*	alert(marqueeStyle[style]+':'+target.value);*/
			target.value=marqueeStyle[style];
		}
		
		marqueeText.value='';
		var index=layer.open({
			type:1,
			btn:['确定','取消'],
			title:['滚动字幕','font-size:14px;font-weight:bold'],
			area:['930px','auto'],
			content:$('.layer-marquee'),
			yes:function(){
				var oWidth=getId('main').style.width;
				var marqueeVal=marqueeText.value;	
				for(var css in marqueeCss){
					var target=getId('marquee-'+css);
					if('font-weight'===css){
						marqueeCss[css]=target.checked;
					}else if('color'===css){
						marqueeCss[css]=target.style['backgroundColor'];
					}else{
						marqueeCss[css]=target.value;
					}
				}
				for(var style in marqueeStyle){
					var target=getId('marquee-'+style);
					marqueeStyle[style]=target.value;
				}
				if(!marqueeVal){
					//layer.alert('请输入文字内容!',{title:'消息:'});
					layer.alert('请输入文字内容!');
					marqueeText.focus();
				}else{
					var cssStyle='';
					var oDiv=document.createElement('div');
						oDiv.setAttribute('id','marquee'+(++num));
						oDiv.setAttribute('guid',historyId);
						oDiv.setAttribute('data_text','滚动文字');
						setStyle(oDiv);
						oDiv.style.width=oWidth;
						$(oDiv).resizable({containment:"#main"}).draggable({containment:"parent"});
					var marquee=document.createElement('marquee');
						for(var style in marqueeStyle){
							marquee.setAttribute(style,marqueeStyle[style]);
						}
						for(var css in marqueeCss){
							if(css=='font-weight'){
								if(marqueeCss[css]){
									marqueeCss[css]='bold';
								}else{
									marqueeCss[css]='normal';
								}
							}else if(css=='font-size'){
								marqueeCss[css]+='px';
							}
							cssStyle+=css+':'+marqueeCss[css]+';';
						}
						$(marquee).attr('style',cssStyle);
						marquee.innerHTML=marqueeVal;
						oDiv.appendChild(marquee);
						oMain.appendChild(oDiv);
						
						getGuid(historyId).find('.Content').html(marqueeText.value);
						
						
					layer.closeAll();
				}
			},cancel:function(){
			      getGuid(historyId).remove();
				  getHistoryGuid(historyId).remove();
			}
		}); 
	});
	
	EventUtil.addHandler(oweather,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
			var historyId=Math.random().toString(36).substr(2);
		showHistory();		
		$.ajax({
			url : contextPath + "/program/showWeatherJson.do",
			type : "get",
			cache : false,
			async : true,
			dataType : "json",			
			success : function(jsonData) {	
				var fil_weather=$("#fil_weather");
				fil_weather.html('');
				var html="<h2 class=\"legend\">预览</h2> <div class=\"showImg\"><img src=\""+jsonData[0].url+"\" id=\"url_weather\" >";
				html+="</div><div><div class=\"pad8\" id=\"location\">"+jsonData[0].location+" "+jsonData[0].weather+"</div><div id=\"temperature\">"+jsonData[0].temperature+"</div></div>";
				fil_weather.html(html);
			},
			error : function() {
				alert("出现异常！");
			}
		});
		 var target=getId('myweather');
		if(target!=null){
			layer.alert('天气预报已经存在！');
			return;
		}
		historyState(this.id,historyId,oHistory);
		compState(oComp,historyId,'<img src="'+contextPath+'/images/weather.png">','天气');
		var index=layer.open({
			type:1,
			title:['天气','font-size:14px;font-weight:bold'],
			btn:['确定','取消'],
			area:['600px','300px'],
			content:$('.layer-weather'),
			btn1:function(){
				var oDiv=document.createElement('div');
				oDiv.setAttribute('guid',historyId);
				oDiv.setAttribute('data_text','天气');
				oDiv.setAttribute('data_img',contextPath+'/images/weather.png');
				oDiv.id='myweather';
				setStyle(oDiv);
				$(oDiv).resizable({containment:"#main"}).draggable({containment:"parent"});
				$(oDiv).contextPopup({
					title:'功能编辑',
					items: [
					  {label:'删除',icon:contextPath+'/images/sys/icon/delete.gif',enable:true,action:function(){
						  	oMain.removeChild(oDiv); 
							var pguid=$(oDiv).attr('guid');
						 	getGuid(pguid).remove();}, color:''}
					]
				});
				oDiv.style.width=200+'px';
				var oDivc=document.createElement('div');
					oDivc.id='weatherArea';
				var fontSize=parseInt(getId('weather-font-size').value);
				var color=getId('weather-color').value;
				var bFont=getId('weather-font-weight').checked;
				var fontWeight=bFont?'bold':'normal';	
					oDivc.style.fontSize=fontSize+'px';
					oDivc.style.fontWeight=fontWeight;
					oDivc.style.color=color;
					oDivc.style.textAlign='left';
					//oDivc.style.whiteSpace='nowrap';
					oDiv.appendChild(oDivc);
					var url_weather=$("#url_weather")[0].src;
					
					var oDivcc=document.createElement('div');
					oDivcc.className='showImg';
					oDivc.appendChild(oDivcc);
					var oDivccImg=document.createElement('img');
					oDivccImg.src=url_weather;
					oDivccImg.onload=function(){
						oDivcc.appendChild(oDivccImg);
					};
					var location=$("#location").html();
					var temperature=$("#temperature").html();
					var weatherDiv=document.createElement('div');
					oDivc.appendChild(weatherDiv);
					var oDivcn=document.createElement('div');
					oDivcn.style.padding=5+'px';
					oDivcn.innerHTML=location;
					weatherDiv.appendChild(oDivcn);
					var oDivsn=document.createElement('div');
					oDivsn.innerHTML=temperature;
					weatherDiv.appendChild(oDivsn);
					oMain.appendChild(oDiv);
					layer.closeAll();
			},cancel:function(){
				getGuid(historyId).remove();
				getHistoryGuid(historyId).remove();
			}
		}); 
	});
	
	
	EventUtil.addHandler(oDate,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		showHistory();
		historyState(this.id,historyId,oHistory);	
		var date=new Date();
		var oYear=date.getFullYear();
		var oMonth=date.getMonth()+1;
		var oDate=date.getDate();
		var oHour=date.getHours();
		var oMin=date.getMinutes();
		var oSec=date.getSeconds();
		var oDiv=document.createElement('div');
			oDiv.setAttribute('guid',historyId);
		var prev=document.createElement('prev');
			oDiv.setAttribute('id',this.id+(++num));
			oDiv.appendChild(prev);
			oDiv.setAttribute('data_text','天气');
			setStyle(oDiv);
			oDiv.className+=" clock special";
			oDiv.setAttribute('type','0');
			prev.innerHTML=oYear+'/'+oMonth+'/'+oDate+' '+oHour+':'+oMin+':'+oSec;
			$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
			oMain.appendChild(oDiv);
			$(oDiv).contextPopup({
				title:'功能编辑',
				items: [
				  {label:'删除',icon:contextPath+'/images/sys/icon/delete.gif',enable:true,action:function(){
					  	oMain.removeChild(oDiv); 
						var pguid=$(oDiv).attr('guid');
					 	getGuid(pguid).remove();},color:''}
				]
			});
		compState(oComp,historyId,prev.innerHTML,'日期');
	});
	
	
	EventUtil.addHandler(picture,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		showHistory();
		historyState(this.id,historyId,oHistory);
		compState(oComp,historyId,'<img src="'+contextPath+'/images/image.png">','图片');
		var $tableList=$('#unpoaded_list');
		$.ajax({
			type : "post",
			url : contextPath + "/program/showImgOrVideo.do",
			data : {
				url : ''				
			},
			dataType : "json",
			success : function(data) {
			   var jsonObj=data;
			   searchImgae();
			   $tableList.html("");				   
			   var html="<tbody><tr><td><input name=\"ckAllImage\" id=\"uploaded_all\" type=\"checkbox\"></td><td>图片名称</td> <td>分类</td>";
			    html+="<td>图片路径</td><td>尺寸(像素)</td><td>大小</td></tr>";
			     $.each(jsonObj, function (i, item) {
			    	 html+="<tr><td><input type=\"checkbox\" name=\"imageId\" value=\""+item.id+"\" class=\"pic_checkbox\"> </td> <td>"+item.name+"</td><td>图片</td><td><p style=\"width: 190px\; class=\"maxLength\">"+item.file_path+"</p></td>";
			         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
			     });	
			     html+="</tbody>";	   
			     $tableList.html(html);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
				return false;
			}
		});
		var $imgae_url='';
		var that=this;
		var index=layer.open({
			type:1,
			title:['图片','font-size:14px;font-weight:bold'],
			btn:['确定','取消'],			
			area:['880px','auto'],
			content:$('.layer-picture'),
			yes:function(){				
				var $unpoadedList=$('#unpoaded_list');
				var $checkBox=$unpoadedList.find('.pic_checkbox');
				var imgArr=[];
				$checkBox.each(function(index,element){
					var $this=$(this);				
						imgArr.push($this.parents('tr').find('p').html());
					
				});
				if(imgArr.length){
					var width=getId('imgWidth').value;
					var height=getId('imgHeight').value;
					var oDiv=document.createElement('div');
					oDiv.setAttribute('id',that.id+(++num));
					oDiv.setAttribute('guid',historyId);
					oDiv.setAttribute('data_text','图片');
					setStyle(oDiv);
					oDiv.className+=' pictureImg';
					oDiv.style.height=height+'px';
					oDiv.style.width=width+'px';
					oDiv.setAttribute('data-swiper',getId('swiperType').value);
					var oImg=document.createElement('img');
					oImg.src=imgArr[0];
					oImg.setAttribute('index',imgArr.length);
					for(var i=0,len=imgArr.length;i<len;i++){
						oImg.setAttribute('_src'+i,imgArr[i]);
						$imgae_url+=imgArr[i]+",";
					}
					var imgUrl=$("#imgae_url").val();
					if(imgUrl.length>0){
						$("#imgae_url").val($imgae_url.substring(0,$imgae_url.length-1)+","+imgUrl);
					}else{
						$("#imgae_url").val($imgae_url.substring(0,$imgae_url.length-1));
					}
					
					oImg.onload=function(){
						oDiv.appendChild(oImg);	
						$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
						oMain.appendChild(oDiv);
					};
					 layer.closeAll();
				}else{
					alert("请选择至少一张图片");					
				}
			},cancel:function(){
				 getGuid(historyId).remove();
				 getHistoryGuid(historyId).remove();
			}
		});
		
	});
	



		
	EventUtil.addHandler(video,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
			showHistory();
		historyState(this.id,historyId,oHistory);
		compState(oComp,historyId,'<img src="'+contextPath+'/images/video.jpg">','视频');
		var $tableList=$('#unpoaded_video');
		$.ajax({
			type : "post",
			url : contextPath + "/program/showImgOrVideo.do",
			data : {
				url : ''				
			},
			dataType : "json",
			success : function(data) {
			   var jsonObj=data;
			   searchVideo();
			   $tableList.html("");				   
			   var html="<tbody><tr><td><input id=\"videoed_all\" type=\"checkbox\"></td><td>视频名称</td><td>分类</td> <td>视频路径</td>";
			    html+="<td>尺寸(像素)</td><td>大小</td></tr>";
			     $.each(jsonObj, function (i, item) {
			    	 html+="<tr><td><input type=\"checkbox\" name=\"videoId\" value=\""+item.id+"\" class=\"video_checkbox\"></td><td>"+item.name+"["+item.video_play_time+"]</td><td>视频</td> <td><p style=\"width: 190px;\" class=\"maxLength\">"+item.file_path+"</p></td>";
			         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
			     });	
			     html+="</tbody>";	   
			     $tableList.html(html);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
				return false;
			}
		});
		

		var isHave =$(".img.video").attr("src");
				
			var $video_url='';
			var that=this;
			var index=layer.open({
				type:1,
				title:['视频','font-size:14px;font-weight:bold'],
				btn:['确定','取消'],				
				area:['880px','auto'],
				content:$('.layer-video'),
				yes:function(){				
					var $unpoaded_video=$('#unpoaded_video');
					var $checkBox=$unpoaded_video.find('.video_checkbox');
					var videoArr=[];
					var videoTime=[];
					var play;
					$checkBox.each(function(index,element){
						var $this=$(this);						
							videoArr.push($this.parents('tr').find('p').html());
							play=$this.parents('tr').find('td:nth-child(2)').text();
							videoTime.push(play.substring(play.lastIndexOf("[")+1,play.length-1));
						
					});
					if(videoArr.length){
						var width=getId('viedoWidth').value;
						var height=getId('videoHeight').value;
						var oDiv=document.createElement('div');
						    oDiv.setAttribute('id',that.id+(++num));
						    oDiv.setAttribute('guid',historyId);
						    oDiv.setAttribute('data_text','视频');
						    oDiv.setAttribute('data_img',contextPath+'/images/video.jpg');
						    setStyle(oDiv);
						    oDiv.className+=' '+that.id+'group';
						    oDiv.style.width=width+'px';
						    oDiv.style.height=height+'px';
							var oImg=document.createElement('img');				
							oImg.src=contextPath+'/images/sys/video.jpg';
							oImg.width=width;
							oImg.height=height;
							var video=document.createElement('video');
							video.className='videoSource';
							oImg.setAttribute('videoSrc',oImg.src);
							
							oImg.className='img video';
							video.setAttribute('tabindex',videoArr.length);							
							video.setAttribute('autoplay','true');
							video.setAttribute('poster',contextPath+'/images/video.jpg');
							video.style.display='none';
							for(var i=0,len=videoArr.length;i<len;i++){
								video.setAttribute('_src'+i,videoArr[i]);
								$video_url+=videoArr[i]+",";
							}
							var play_time=0;
							for(var i=0;i<videoTime.length;i++){
								play_time=videoTime[i]*1+play_time*1;
							}						
							video.src=videoArr[0];
							var videoUrl=$("#video_url").val();
							if(videoUrl.length>0){
								$("#video_url").val($video_url.substring(0,$video_url.length-1)+","+videoUrl);
							}else{
								$("#video_url").val($video_url.substring(0,$video_url.length-1));
							}
							var playTime=$("#play_time").val();
							if(playTime!=null){
								if(playTime*1<play_time){
									$("#play_time").val(play_time);
								}else{
									$("#play_time").val(playTime);
								}
							}else{
								$("#play_time").val(play_time);
							}
							
							oImg.onload=function(){
								oDiv.appendChild(oImg);	
								oDiv.appendChild(video);	
								$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
								oMain.appendChild(oDiv);
							};
							 layer.closeAll();
					}else{
						alert("请选择至少一部视频");	
					}
				},cancel:function(){
					getGuid(historyId).remove();
					getHistoryGuid(historyId).remove();
				}
			}); 
		
		
	});
	
	
	
	
	EventUtil.addHandler(webpage,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		showHistory();
		historyState(this.id,historyId,oHistory);
		compState(oComp,historyId,'<img src="'+contextPath+'/images/webpage.jpg">','网络页面');
		var _this=this;
		var index=layer.open({
			type:1,
			title:['网络页面','font-size:14px;font-weight:bold'],
			btn:['确定'],
			area:['640px','auto'],
			content:$('.layer-webpage'),
			btn1:function(){
				var oDiv=document.createElement('div');
				oDiv.setAttribute('id',_this.id+(++num));
				oDiv.setAttribute('guid',historyId);
				oDiv.setAttribute('data_text','网络页面');
			    oDiv.setAttribute('data_img',contextPath+'/images/webpage.jpg');
				setStyle(oDiv);
				oDiv.className+=' page';
				oDiv.style.width=800+'px';
				oDiv.style.height=600+'px';
				$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
				var iFrame=document.createElement('iframe');
				iFrame.className='iframe';
				var webpageurl=$("#webpageurl").val();				
				iFrame.src=webpageurl;
				iFrame.setAttribute('frameborder',0);
				oDiv.setAttribute('data-src',webpageurl);
				oDiv.appendChild(iFrame);
				oMain.appendChild(oDiv);
			},cancel:function(){
				getGuid(historyId).remove();
				getHistoryGuid(historyId).remove();
			}
		}); 
	});
	
	
	
	
	EventUtil.addHandler(oliveVideo,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		showHistory();
		historyState(this.id,historyId,oHistory);
		compState(oComp,historyId,'<img src="'+contextPath+'/images/livevideo_100.jpg">','视频直播');
		var index=layer.open({
			type:1,
			title:'视频直播',			
			area:['500px','300px'],
			btn:['确定'],
			content:$('.layer-livevideo'),
			yes:function(){
				if(!$('select[name="v-src"]').val()){
					layer.alert('请选择视频直播地址！');
				}else{
					var oDiv=document.createElement('div');
					oDiv.setAttribute('guid',historyId);
					oDiv.id='livevideo'+(++num);
					oDiv.setAttribute('data_text','视频直播');
				    oDiv.setAttribute('data_img',contextPath+'/images/livevideo_100.jpg');
					setStyle(oDiv);
					$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});
					var oImg=document.createElement('img');
						oImg.src=contextPath+'/images/sys/livevideo_100.jpg';
					oDiv.appendChild(oImg);
					oMain.appendChild(oDiv);
					layer.close(index); 
				}
				
			},cancel:function(){
				 getGuid(historyId).remove();
				 getHistoryGuid(historyId).remove();
			}
		}); 
	});
	
	
	
	EventUtil.addHandler(doc,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		var historyId=Math.random().toString(36).substr(2);
		var isHave =$(".img.pdf").attr("src");
		if(isHave==undefined){
			showHistory();
			historyState(this.id,historyId,oHistory);
			compState(oComp,historyId,'<img src="'+contextPath+'/images/pdf.jpg">','文档');
			var index=layer.open({
				type:1,
				title:['插入文档','font-size:14px;font-weight:bold'],
				btn:['确定','取消'],
				area:['880px','auto'],
				content:$('.layer-doc'),
				yes:function(){
					var text=$('#docText').find('strong').html();
					if(text.indexOf('请选择')<0){
						var $pdfUrl=$("#pdf_url").val();
						var oDiv=document.createElement('div');
						oDiv.setAttribute('guid',historyId);
						oDiv.id='pdf';
						oDiv.setAttribute('data_text','文档');
					    oDiv.setAttribute('data_img',contextPath+'/images/pdf.jpg');
						setStyle(oDiv);
						oDiv.className+=' pdf';
						//oDiv.setAttribute('data-src',$pdfUrl);
						oDiv.style.width=oDiv.style.width?oDiv.style.width:800+'px';
						oDiv.style.height=oDiv.style.height?oDiv.style.height:600+'px';
						$(oDiv).resizable({containment:"#main"}).draggable({containment: "parent"});					
						var oImg=document.createElement('img');
							oImg.src=contextPath+'/images/sys/pdf.jpg';
							oImg.className='img pdf';
						oDiv.appendChild(oImg);
						var oA=document.createElement('a');
							oA.className="media";
							oA.setAttribute('href',$pdfUrl);
							oA.style.display='none';
							oDiv.appendChild(oA);	
						oMain.appendChild(oDiv);
						layer.close(index); 
					}else{
						alert("必须选择一个文档。");
					}
				},cancel:function(){
				getGuid(historyId).remove();
				getHistoryGuid(historyId).remove();
			}
			});
		}else{
			alert("一个场景只能添加一个office！");
		}
		
		 
	});
	
	
	
	EventUtil.addHandler(oMain,'click',function(e){
		EventUtil.removeAllChildClass.call(main,'focusin');
		 var oEvent=EventUtil.getEvent(e);
		 var target=EventUtil.getTarget(oEvent);
		 var targetId=target.id;
		 if(targetId=='main'){
			 for(var i=0,len=target.children.length;i<len;i++){
				 if(EventUtil.hasClass(target.children[i],'focusin')){
					 EventUtil.removeClass(target.children[i],'focusin');
				 }
			 }
			 $('#comp .Item').removeClass('ItemSelected');
		 }else{			 
			EventUtil.removeAllChildClass.call(main,'focusin');	 
			 if(targetId!=''){
				 if(!EventUtil.hasClass(target,'focusin')){
					 EventUtil.addClass(target,'focusin');
				 }
				 var pguid=getId(targetId).getAttribute('guid');
				 getGuid(pguid).addClass('ItemSelected');
			 }else{
				 if(!EventUtil.hasClass(searchParent(target.parentNode),'focusin')){
					 EventUtil.addClass(searchParent(target.parentNode),'focusin');
				 }
				 $('#comp .Item').removeClass('ItemSelected');
				 var pguid=getId(target.parentNode.id).getAttribute('guid');
				 getGuid(pguid).addClass('ItemSelected');
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
				if(!EventUtil.hasClass(searchParent(target.parentNode),'hover')){
					EventUtil.addClass(searchParent(target.parentNode),'hover');
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
				if(EventUtil.hasClass(searchParent(target.parentNode),'hover')){
					EventUtil.removeClass(searchParent(target.parentNode),'hover');
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
				var pguid=delObj.getAttribute('guid');
				getGuid(pguid).remove();	
				oMain.removeChild(delObj);
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
	
	$('.tabs').tabs();
	$('#background-color').cxColor({color:'#ffffff'});
	$('#date-background-color').cxColor({color:'#ffffff'});
	$('.cxColor').cxColor();
	$('#marquee-color').cxColor();
	
	
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
	
	
	/*图片弹出层——添加按钮*/
	EventUtil.addHandler(oPicAdd,'click',function(e){
		var imgList=document.querySelectorAll('.pic_select');
		var toTarget=getId('tableList');
		var i=0;
		var len=imgList.length;
		var strArr=[];
		for(i=0;i<len;i++){
			if(imgList[i].checked){
				strArr.push(imgList[i].parentNode.parentNode.innerHTML);
				imgList[i].parentNode.parentNode.parentNode.removeChild(imgList[i].parentNode.parentNode);
			}	
		}
		
		if(strArr.length>0){
			for(var i=0,len=strArr.length;i<len;i++){
				var oTr=document.createElement('tr');
				var oText=strArr[i];
				oTr.innerHTML=oText;
				toTarget.appendChild(oTr);
			}
		}
	});
	
	
	
	
	EventUtil.addHandler(document,'keydown',function(e){
		var oEvent=EventUtil.getEvent(e);
		var key=oEvent.keyCode;
		var oMain=getId('main');
		var nWidth=parseInt(oMain.style.width);
		var nHeight=parseInt(oMain.style.height);
		var speed=1;
		var flag=true;
		var isFocus=$(":text,textarea").is(":focus");  
		if(true==isFocus){  
			flag=false; 
		}else{  
			flag=true;
		}  
		if(key<=40 && key>=37 && flag){
			var mTargetHover=document.querySelector('.hover');
			var mTargetFocus=document.querySelector('.focusin');
			var oTarget=mTargetHover || mTargetFocus;
			if(oTarget){
				var mHeight=oTarget.offsetHeight;
				var mWidth=oTarget.offsetWidth;
				var oLeft=oTarget.offsetLeft;
				var oTop=oTarget.offsetTop;
				var bHeight=nHeight-mHeight;
				var bWidth=nWidth-mWidth;
				if(oLeft<0){
					oLeft=0;
				}else if(oLeft>bWidth){
					oLeft=bWidth;
				}
				if(oTop<0){
					oTop=0;
				}else if(oTop>bHeight){
					oTop=bHeight;
				}
				switch(key){
					case 37:
						speed=-1;
						oTarget.style.left=oLeft+speed+'px';
						break;
					case 38:
						speed=-1;
						oTarget.style.top=oTop+speed+'px';
						break;
					case 39:
						speed=1;
						oTarget.style.left=oLeft+speed+'px';
						break;
					case 40:
						speed=1;
						oTarget.style.top=oTop+speed+'px';
						break;
				}
			}
			EventUtil.preventDefault(oEvent);
		}
		
	});
	
	$('#preview').click(function () {
		var text=$("#marqueeText").val();
		var preview=$("#preview");
		 preview.html("");
		preview.append(text);
	});

})();

//返回
function back() {
	window.location.href = contextPath + '/program/toProject.do';
}

//预览
function preview(){
	var text=$("#wrapAll").html();
	var oldHtml=$('#wrapAll').clone(true);
	var videogroup=oldHtml.find(".videogroup");
	var videoLength=videogroup.length;
	var $clock=oldHtml.find(".clock");
	var clockLength=$clock.length;
	var $pdf=oldHtml.find(".pdf");
	var pdfLength=$pdf.length;
	if(videoLength && clockLength &&pdfLength){
		$clock.each(function(){
			var $this=$(this);
			var $type=parseInt($this.attr('type'));
			if($type){
				$this.find('prev').remove();
				this.style.textAlign='left';
			}else{
				EventUtil.removeClass(this,'clock');
			}
		});
		oldHtml.find('.videogroup img').remove();
		oldHtml.find(".videoSource").css('display', 'block'); //显示
		
		oldHtml.find('.pdf img').remove();
		oldHtml.find(".media").css('display', 'block'); //显示
		
		text=oldHtml.html();	
	}else if(!videoLength && clockLength && pdfLength){
		$clock.each(function(){
			var $this=$(this);
			var $type=parseInt($this.attr('type'));
			if($type){
				$this.find('prev').remove();
				this.style.textAlign='left';
			}else{
				EventUtil.removeClass(this,'clock');
			}
		});
		oldHtml.find('.pdf img').remove();
		oldHtml.find(".media").css('display', 'block'); //显示		
		text=oldHtml.html();	
	}else if(videoLength && !clockLength && pdfLength){
		oldHtml.find('.videogroup img').remove();
		oldHtml.find(".videoSource").css('display', 'block'); //显示
		oldHtml.find('.pdf img').remove();
		oldHtml.find(".media").css('display', 'block'); //显示		
		text=oldHtml.html();	
	}else if(videoLength && clockLength && !pdfLength){
		$clock.each(function(){
			var $this=$(this);
			var $type=parseInt($this.attr('type'));
			if($type){
				$this.find('prev').remove();
				this.style.textAlign='left';
			}else{
				EventUtil.removeClass(this,'clock');
			}
		});
		oldHtml.find('.videogroup img').remove();
		oldHtml.find(".videoSource").css('display', 'block'); //显示
		
		text=oldHtml.html();
		
	}else if(!videoLength && clockLength &&!pdfLength){
		$clock.each(function(){
			var $this=$(this);
			var $type=parseInt($this.attr('type'));
			if($type){
				$this.find('prev').remove();
				this.style.textAlign='left';
			}else{
				EventUtil.removeClass(this,'clock');
			}
		});
		text=oldHtml.html();
	}else if(videoLength && !clockLength &&!pdfLength){
		oldHtml.find('.videogroup img').remove();
		oldHtml.find(".videoSource").css('display', 'block'); //显示
		text=oldHtml.html();	
	}else if(!videoLength && !clockLength &&pdfLength){
		oldHtml.find('.pdf img').remove();
		oldHtml.find(".media").css('display', 'block'); //显示		
		text=oldHtml.html();
	}
	var url_pattern = contextPath + '/program/toPreview.do';
	openPostWindow(url_pattern,text,"预览");
	
	
	var iWidth = 1024; // 弹出窗口的宽度;
	var iHeight = 768; // 弹出窗口的高度;	
//	window.open(url_pattern, "", "height=" + iHeight + ",width=" + iWidth + ",location=no,menubar=no,resizable=yes,status=no,toolbar=no,titlebar=no,scrollbars=yes", "");
}


function trim(str) {
	// 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

//查询图片
function searchImgae() {
	var type = $("#image_material_type").val();
	var name = $("#image_name").val();
	var image=$("#unpoading_list");
	if("请选择"==type){
	  type="image";
	}else{
		var treeId="";
		var treeNode = zTreeImage.getNodeByParam("id",type,null); 	
		var childNodes = zTreeImage.transformToArray(treeNode);
	     for(var i = 0; i < childNodes.length; i++) {
	    	 treeId += childNodes[i].id+",";
	     }
	     
	     type=treeId.substring(0,treeId.length-1);
	}
	$.ajax({
		type : "post",
		url : contextPath + "/material/search.do",
		data : {
			type : type,
			name : name
		},
		dataType : "json",
		success : function(data) {
		   var jsonObj=data;
		    image.html("");
		   var html="<colgroup><col width=\"40\"><col width=\"180\"><col width=\"90\"><col width=\"200\"><col width=\"85\"><col width=\"75\"></colgroup>";
		    html+="<tr><td><input type=\"checkbox\" name=\"ckAllImage\" id=\"unpoading_all\"></td><td>图片名称</td> <td>分类</td> <td>图片路径</td>  <td>尺寸(像素)</td> <td>大小</td></tr>";
		     $.each(jsonObj, function (i, item) {
		         html+="<tr><td><input type=\"checkbox\" name=\"imageId\" value=\""+item.id+"\" class=\"pic_checkbox\"> </td> <td>"+item.name+"</td><td>图片</td><td><p style=\"width: 190px\; class=\"maxLength\">"+item.file_path+"</p></td>";
		         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
		     });		   
			image.html(html);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
}

//查询视频
function searchVideo(){
	var type = $("#video_material_type").val();
	var name = $("#video_name").val();
	var video=$("#unpoading_video");
	if("请选择"==type){
	  type="video";
	}else{
		var treeId="";
		var treeNode = zTreeVideo.getNodeByParam("id",type,null); 	
		var childNodes = zTreeVideo.transformToArray(treeNode);
	     for(var i = 0; i < childNodes.length; i++) {
	    	 treeId += childNodes[i].id+",";
	     }
	     
	     type=treeId.substring(0,treeId.length-1);
	}
	$.ajax({
		type : "post",
		url : contextPath + "/material/search.do",
		data : {
			type : type,
			name : name
		},
		dataType : "json",
		success : function(data) {
		   var jsonObj=data;
		    video.html("");
		   var html="<colgroup><col width=\"40\"><col width=\"180\"><col width=\"90\"><col width=\"200\"><col width=\"85\"><col width=\"75\"></colgroup>";
		    html+="<tr><td><input type=\"checkbox\" name=\"video_ckAll\" id=\"videoing_all\"></td><td>视频名称[秒]</td><td>分类</td><td>视频路径</td><td>尺寸(像素)</td><td>大小</td></tr>";
		     $.each(jsonObj, function (i, item) {
		         html+="<tr><td><input type=\"checkbox\" name=\"videoId\" value=\""+item.id+"\" class=\"video_checkbox\"></td><td>"+item.name+"["+item.video_play_time+"]</td><td>视频</td> <td><p style=\"width: 190px;\" class=\"maxLength\">"+item.file_path+"</p></td>";
		         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
		     });		   
			video.html(html);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
}
//把2个数组重复的数据干掉。
function analyzingRepeated(arr1,arr2) {
	  var temp = []; //临时数组1  
	  var temparray = [];//临时数组2
	    for (var i = 0; i < arr2.length; i++) {
	        temp[arr2[i]] = true;//巧妙地方：把数组B的值当成临时数组1的键并赋值为真  
	    };  
	    for (var i = 0; i < arr1.length; i++) {  
	        if (!temp[arr1[i]]) {  
	            temparray.push(arr1[i]);//巧妙地方：同时把数组A的值当成临时数组1的键并判断是否为真，如果不为真说明没重复，就合并到一个新数组里，这样就可以得到一个全新并无重复的数组  
	        } ;  
	    };  
     return temparray.join(",");
}
function openPostWindow(url, data, name)  
  {  
      var tempForm = document.createElement("form");  
      tempForm.id="tempForm1";  
      tempForm.method="post";  
      tempForm.action=url;  
      tempForm.target=name;  
      
      var hideInput = document.createElement("input");  
      hideInput.type="hidden";  
      hideInput.name= "text";
      hideInput.value= data;
      tempForm.appendChild(hideInput);     
      if(document.all){
    	  tempForm.attachEvent("onsubmit",function(){ openWindow(name); });        //IE
      }else if(isIE()){
          //var subObj = tempForm.addEventListener("onsubmit",function(){ openWindow(name);},false);    //ie11    
    	  tempForm.attachEvent("onsubmit",function(){ openWindow(name); });        //IE
      }else{
    	  var subObj = tempForm.addEventListener("submit",function(){ openWindow(name); },true);    //firefox
      }
      
      document.body.appendChild(tempForm);  
      if(document.all){
          tempForm.fireEvent("onsubmit");
      }else if(isIE()){
    	  tempForm.fireEvent("onsubmit");
      }else{
    	  tempForm.dispatchEvent(new Event("submit"));
      }
    
      tempForm.submit();
      document.body.removeChild(tempForm);
 }
     
 function openWindow(name)  
  {  
      window.open("", name, "height=600,width=1024,location=no,menubar=no,resizable=yes,status=no,toolbar=no,titlebar=no,scrollbars=yes", "");
  }  
 
 function isIE() { //ie11 
	 var a1 = navigator.userAgent;
	 var yesIE = a1.search(/Trident/i);
	 if(yesIE>0){
		 return true;
	 }else{
		 return false;
	 }
	} 
   