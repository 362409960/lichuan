var lanren = {
	changeClass: function (target,id) {
       	var className = $(target).attr('class');
       	var ids = document.getElementById(id);
       	(className == 'on')? $(target).removeClass('on').addClass('off'): $(target).removeClass('off').addClass('on');
       	(className == 'on')? ids.pause():ids.play();
   	},
	play:function(){
		document.getElementById('media').play();
	}
}
lanren.play();