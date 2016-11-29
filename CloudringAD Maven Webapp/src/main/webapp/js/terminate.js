// JavaScript Document
function SetClock(){
	var url ="ClockSetting.html";
    window.showModalDialog(url, window, "dialogHeight:400px;dialogWidth:1024px;center:yes;status:no;scroll:no");
}
function SetVolume(){
	var url ="SetVolume.html";
	window.showModalDialog(url, window, "dialogHeight:100px;dialogWidth:400px;center:yes;status:no;scroll:no");
}

function layerEmpty(){
	layer.confirm('清空已选择终端上的节目？',{
	  btn: ['确定','取消'], //按钮
	  title: ['请确认','font-size:14px;font-weight:bold']
	}, function(){
	  
	}, function(){

	});
}
function layerRestore(){
	layer.confirm('确定发出重启终端命令吗？',{
	  btn: ['确定','取消'], //按钮
	  title: ['请确认','font-size:14px;font-weight:bold']
	}, function(){
	  
	}, function(){

	});
}

function layerSucc(){
	layer.confirm('命令设置成功!',{
	  title: ['结果信息','font-size:14px;font-weight:bold']
	})
}

function layerRestore(){
	layer.confirm('确定发出重启终端命令吗？',{
	  btn: ['确定','取消'], //按钮
	  title: ['请确认','font-size:14px;font-weight:bold']
	}, function(){
	  
	}, function(){

	});
}
function layerInstall(){
	var index=layer.open({
		type:1,
		title:['远程安装APK','font-size:14px;font-weight:bold'],
		shadeClose: true,
		shade: 0.8,
		area:['400px','200px'],
		content:$('.layer_install'),
	});
}
function layerUnstall(){
	var index=layer.open({
		type:1,
		title:['远程卸载APK','font-size:14px;font-weight:bold'],
		shadeClose: true,
		shade: 0.8,
		area:['400px','170px'],
		content:$('.layer_unstall'),
	});
}
