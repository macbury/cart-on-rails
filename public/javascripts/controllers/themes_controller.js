var themes_controller = {
	init: function(){
		$('#theme_content').wrap('<div class="code_editor"></div>')
		var editor = CodeMirror.fromTextArea('theme_content', {
			parserfile: ["parsexml.js", "parsecss.js", "tokenizejavascript.js", "parsejavascript.js", "parsehtmlmixed.js"],
			stylesheet: ["/codemirror/css/xmlcolors.css", "/codemirror/css/jscolors.css", "/codemirror/css/csscolors.css"],
			path: "/codemirror/js/",
			continuousScanning: 500,
			lineNumbers: true,
			autoMatchParens: true
		});
		
		$('#theme_page_type').change(function () {
			if ($(this).val() == 1) {
				$('#theme_layout_id_input').slideDown();
			}else{
				$('#theme_layout_id_input:visible').slideUp();
			}
		}).change();
		
	},
}
