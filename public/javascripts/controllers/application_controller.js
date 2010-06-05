var application_controller = {	
	init: function(){
		$('.message .close').live("click", function () {
			$(this).parent(".message").slideUp();
			return false;
		});
	},
}

$(document).ajaxSend(function(event, request, settings) { 
	if (typeof(window._token) == "undefined") return;
	
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window._token);
});


$(document).ready(function () {
	application_controller.init();
});