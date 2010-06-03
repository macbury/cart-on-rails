var application_controller = {	
	init: function(){
		$('.message .close').live("click", function () {
			$(this).parent(".message").slideUp();
			return false;
		});
	},
}

$(document).ready(function () {
	application_controller.init();
});