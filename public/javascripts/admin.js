$(document).ajaxSend(function(event, request, settings) { 
	if (typeof(window._token) == "undefined") return;
	
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window._token);
});

$(document).ready(function () {
	$('.header ul a:not(.selected)').mouseover(function () {
		$(this).animate({
			'line-height': '28px',
			'border-top-width': '4px'
		});
	}).mouseout(function() {
		$(this).animate({
			'line-height': '32px',
			'border-top-width': '0px'
		});
	});
	
	refreshItems();
	
	$('input:checkbox').check_box();
	
	setTimeout(function () {
		$('.flash_notice, .flash_error').slideUp();
	}, 5000);
	
	$('.flash_notice, .flash_error').hover(function () {
		$(this).slideUp();
	});
	
	
	$('#filter_form').submit(function () {
		$.ajax({
			url: $(this).attr('action'),
			type: 'GET',
			data: $(this).serialize(),
			dataType: 'script'
		});
		
		return false;
	});
	
	$("#product_tag_list").autocomplete("/products/suggest_tag", {
		highlight: false,
		multiple: true,
		multipleSeparator: ",",
		scroll: true,
		scrollHeight: 300
	});
	
	$('#add_version').click(function () {
		var new_row = $(version_template);		
		
		var id = new Date().getTime();
		
		new_row.find('input').each(function () {
			var name = $(this).attr('name');
			name = name.replace(/([0-9])/, id);
			$(this).attr('name', name);
		});
		$('#product_versions thead').after(new_row);
		new_row.find('input:checkbox').check_box();
		
		return false;
	});
	
	$('#add_photo').click(function () {
		var new_row = $(photo_template);		
		
		var id = new Date().getTime();
		
		new_row.find('input').each(function () {
			var name = $(this).attr('name');
			name = name.replace(/([0-9])/, id);
			$(this).attr('name', name);
		});
		$('#product_photos').append(new_row);
		new_row.find('input:checkbox').check_box();
		new_row.find('input:file').file();
		
		return false;
	});
	
	$("#product_photos").sortable({ 
		items: 'li',
		handle: '.desc',
		cursor: 'move',
		revert: true
	});
	
	$('#product_form').submit(function () {
		var i = 0;
		$("#product_photos li").each(function () {
			$($(this).find('input:hidden')[1]).val(i);
			i++;
		});
	});
	
	$('#product_photos input:file').file();
	
	$('#page_page_type').change(function () {
		if ($(this).val() == 1) {
			$('#layout_box').show('blind');
		}else{
			$('#layout_box:visible').hide('blind');
		}
	});
});

function refreshItems () {
	bind_expand_buttons();
}

function bind_expand_buttons () {
	$('.expand').click(function () {
		$(this).siblings('.variants').toggle();
	}).toggle(function () {
		$(this).addClass('collapse');
	}, function () {
		$(this).removeClass('collapse');
	});
}

$.fn.extend({
	check_box: function(){
		$(this).each(function () {
			var self = $(this);
			self.wrap('<div class="checkbox">');
			var checkbox = self.parents('.checkbox');
			(self[0].checked) ? checkbox.attr('checked', 'checked') : checkbox.removeAttr('checked');
			checkbox.click(function () {
				self[0].checked = !self[0].checked;
				(self[0].checked) ? checkbox.attr('checked', 'checked') : checkbox.removeAttr('checked');
			});
		});
	},
	
	file: function(){
		$(this).change(function() {
			$(this).parent('li').addClass('changed').find('.desc span').text($(this).val());
		});
	}
});