// JavaScript Document

var text=$(".special").find('prev').text();
function clock(){
	var date=new Date();
	var oYear=date.getFullYear();
	var oMonth=date.getMonth()+1;
	var oDate=date.getDate();
	var oHour=date.getHours();
		oHour=double(oHour);
	var oMin=date.getMinutes();
		oMin=double(oMin);
	var oSec=date.getSeconds();
		oSec=double(oSec);		
		var $time=$(".special");
		$time.each(function(){
			var $this=$(this);				
			if(!$this.hasClass("clock")){				
				var time;
				if(text.indexOf("星期")>0){
					 time=oYear+'/'+oMonth+'/'+oDate+' '+getWeek()+' '+oHour+':'+oMin+':'+oSec;
				}else{
					 time=oYear+'/'+oMonth+'/'+oDate+' '+oHour+':'+oMin+':'+oSec;
				}
				
				$this.text(time);
			}
		});
		setTimeout(clock,500);	
}

function double(num){
	if(num<10){
		num='0'+num;
	}
	return num;
}

function getWeek(){
	var date=new Date();
	var week=['星期日','星期一','星期二','星期三','星期四','星期五','星期六'];
	return week[date.getDay()];
}
clock();