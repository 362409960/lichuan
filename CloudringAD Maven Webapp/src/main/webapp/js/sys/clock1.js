
var config = {
	
	/*the name of the div containing the clock*/
	divId: "clock",
			
	/*set to false if you don't want to use the second hand*/		
	useSecondHand: "true",
	
	/*width and height of the clock*/
	clockWidthAndHeight: "200",
	
	/*location of the images*/
	clockFaceImg: "js/clock/clockBg.png",
	hourHandImg: "js/clock/hourHand.png",
	minuteHandImg: "js/clock/minuteHand.png",
	secondHandImg: "js/clock/secondHand.png", 
	/*location of the high res images for retina display*/
	clockFaceHighResImg: "js/clock/clockBgHighRes.png",
	hourHandHighResImg: "js/clock/hourHandHighRes.png",
	minuteHandHighResImg: "js/clock/minuteHandHighRes.png",
	secondHandHighResImg: "js/clock/secondHandHighRes.png", 
	
	/*Set true to make hand move at steady speed*/
	smoothRotation: "false",
	
	/*speed of the second hand. Lower is faster. */
	/*Must be under 1000. */
	/*If smooth rotation is true, this does nothing.*/
	secondHandSpeed: "100"
					
};

var myhtml5Clock = new html5Clock(config);
