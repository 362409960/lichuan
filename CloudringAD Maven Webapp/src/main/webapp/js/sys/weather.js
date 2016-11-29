function refresh(){
	 $.ajax({  
	        url:"http://192.168.1.113:8080/CloudringAD/proxy/?params={\"no\":\"101\"}",  
	        dataType:'jsonp',   
	        jsonp:'callback',  
	        success:function(result) {  	        
				var showAddImg=$("#showAddImg");
					showAddImg.html('');
					var html="<div class=\"showImg\"><img src="+result.url+"></div><div>";
					html+="<div style=\"padding: 5px;\">"+result.location+" "+result.weather+"</div><div>"+result.temperature+"</div></div>";
					showAddImg.html(html);
	        },  
	        error: function (XMLHttpRequest, textStatus,errorThrown) {
		            alert(errorThrown);
		            return false;
		        } 
	    });  
}
window.setInterval("refresh()",43200000);