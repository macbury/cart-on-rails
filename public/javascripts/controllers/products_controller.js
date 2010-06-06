var products_controller = {
	property_template: "",
	new_property_template: "",
	
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
					  url: window.location.pathname + '/positions',
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
		
		$('#add_property').click(function () {
			var selected = $('#new_property_ :selected');
			if (selected.val() != "") {
				var new_property = $(products_controller.property_template);
				new_property.find(".name").attr("option_id", selected.val()).text(selected.text());
				new_property.find(".value input:text").attr("name", "property["+selected.val()+"]").removeAttr("id");
				$('.properties_editor tbody').append(new_property);
				selected.remove();
			} else {
				var new_property = $(products_controller.new_property_template);
				$('.properties_editor tbody').append(new_property);
			}
			
			return false;
		});
		
		$('.properties_editor tbody a.delete').live("click", function () {
			var tr = $(this).parents("tr");
			
			if (tr.attr("class") == "property") {
				var option = $("<option></option>");
				option.attr("value", tr.find(".name").attr("option_id"));
				option.text(tr.find(".name").text());
				$('#new_property_').append(option);
			}
			
			tr.remove();
			return false;
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