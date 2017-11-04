// color palettes are taken from http://www.color-hex.com/color-palettes
	palettes = {
		'sunrise': ['#e65c6f', '#f98d77', '#ffcb69', '#ffe269',	'#fffa85', '#fffa85', '#ffe269', '#ffcb69', '#f98d77', '#e65c6f'],
		'blueskies': ['#76b8cc', '#87ccdb', '#a2d9e1', '#bfe4e5', '#d0eee6', '#d0eee6', '#bfe4e5', '#a2d9e1', '#87ccdb', '#76b8cc'],
		'illusionfire': ['#fff2bf', '#ffe2bf', '#fbd0be', '#ffc5c1', '#fdacb9', '#fdacb9', '#ffc5c1', '#fbd0be', '#ffe2bf', '#fff2bf'],
		'softhighlights': ['#ebe4c2', '#d5cad0', '#c7d7cf', '#dfcdbb', '#aec2d0', '#aec2d0', '#dfcdbb', '#c7d7cf', '#d5cad0', '#ebe4c2'],
		'illusionblue': ['#b9eafd', '#d0edff', '#d7e8fd', '#e8e8fd', '#fcecff', '#fcecff', '#e8e8fd', '#d7e8fd', '#d0edff', '#b9eafd']
	}

	palette_names = Array('sunrise', 'blueskies', 'illusionfire', 'softhighlights', 'illusionblue');
	palette_name = palette_names[Math.floor(Math.random()*palette_names.length)];
	palette = palettes[palette_name];
	
	i = 0;
	$( document ).ready(function() {
		$('.random-color-box').each(function(n) {
	    $(this).css('background', palette[i]);
	    i++;
	  });
  });