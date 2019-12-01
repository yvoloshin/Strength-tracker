$( document ).on('turbolinks:load', function() {
	if ($('#desktopTest').is(':hidden')) {
	    	$('.desktop').remove();
		} else {
				$('.mobile').remove();
		}
})