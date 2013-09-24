$(document).ready(function() {
	$("#tech").carouFredSel(
		{
			circular : false,
			infinite : false,
			width : "100%",	
			auto	: false,
			items : {
				visible: 4,
				minimum: 5
			},
			prev	: "#tech_prev",
			next  : "#tech_next"
		},
		{ 
			 wrapper  : "parent"
				 //element     : "figure",
				 //classname   : "col-md-10"
		});
	$("#food").carouFredSel(
		{
			circular : false,
			infinite : false,
			width : "100%",	
			auto	: false,
			items : {
				visible: 4,
				minimum: 5
			},
			prev	: "#food_prev",
			next  : "#food_next"
		},
		{ 
			 wrapper  : "parent"
				 //element     : "figure",
				 //classname   : "col-md-10"
		});
	$("#book").carouFredSel(
		{
			circular : false,
			infinite : false,
			width : "100%",	
			auto	: false,
			items : {
				visible: 4,
				minimum: 5
			},
			prev	: "#book_prev",
			next  : "#book_next"
		},
		{ 
			 wrapper  : "parent"
				 //element     : "figure",
				 //classname   : "col-md-10"
		});
});
