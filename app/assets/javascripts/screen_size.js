$( document ).on('turbolinks:load', function() {
	if ($('#desktopTest').is(':hidden')) {
	    	$('.desktop').attr("hidden", true);
		} else {
				$('.mobile').attr("hidden", true);
		}
})