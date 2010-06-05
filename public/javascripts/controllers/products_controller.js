var products_controller = {
	init: function(){
		$('#photo_image').change(function(e){
			$('#new_photo').submit();
		});
		
		$(".imglist").sortable({
			items: '.sortable',
			handle: "img",
			update: function(event, ui) {
				var data = $(this).sortable("serialize");

				if (data != '') {
					$.ajax({
					  type:'post',
					  url: '/products/koszulka-old-school/product_photos/positions',
						data: data
					});
				};
			}
		});
		
		$('.imglist .delete a').live("click", function () {
			$.ajax({
				type: "post",
				data: "_method=delete&format=js",
				url: $(this).attr("href")
			});
			$(this).parents("li").fadeOut("medium", function () {
				$(this).remove();
			});
			return false;
		});
		
		this.bindFancyBox();
		
		$('#new_photo').submit(function () {
			var form = $(this);

			var progress = $('<li></li>');
			var uid = "uploading_"+Math.floor(Math.random()*9999999999999).toString(16).toUpperCase();
			progress.append("<iframe></iframe>");
			progress.find("iframe").attr("id",uid);
			progress.addClass("uploading");
			form.removeAttr("target");
			form.attr("target", uid);
			form.parents('.imglist .upload_photo').before(progress);

			
			$('#'+uid).load(function () {

				var raw_json = $(this).contents().text();
				var response = {};
				try {
					response = $.parseJSON(raw_json);
				} catch(error) {
					console.log("Błąd: "+ error);
				}

				if (response == null || response.url == null) {
					var errorMsg = "Nie można dodać zdjęcia!";
					if (response.error != null) { 
						errorMsg = response.error; 
					}

					alert(errorMsg);
				} else {
					$(this).parents('li').replaceWith(response.partial);
					products_controller.bindFancyBox();
				}
			});
		});
		
		$('#product_description').wysiwyg();
		$($('#product_description_input iframe').document()).find("body").css({ 
			"font-size": "10px",
			"font-family": '"Lucida Grande", Verdana, Arial, sans-serif'
		});
	},
	
	bindFancyBox: function(){
		$(".imglist .view a").fancybox({
			transitionIn: "elastic",
		});
	},
}