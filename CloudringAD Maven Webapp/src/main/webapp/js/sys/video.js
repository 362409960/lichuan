// JavaScript Document
$(function(){
	var $videogroup=$('.videogroup');
	$videogroup.each(function(index, element){
        var $this=$(this);
		var $videoSource=$this.find('.videoSource');
		this.style.height=this.style.height?this.style.height:'400px';
		this.style.width=this.style.width?this.style.width:'800px';
		var videoArr=[];
		var curren=1;
		var len=$videoSource.attr('tabindex');
		for(i=0;i<len;i++){
			var src=$videoSource.attr('_src'+i);
			videoArr.push(src);
		}
		if(len > 1){
			$videoSource[0].addEventListener("ended",function(){
				this.src=videoArr[curren];
				this.play();
				curren++;
				if(curren>=len){
					curren=0;
				}
			},true);
		}else{
			$videoSource.attr('loop','-1');
		}
    });
});
