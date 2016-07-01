$('.dropdown').click(function() {
	if ($(this).hasClass('active')) {
		$(this).removeClass('active');
	} else {
		$('.dropdown.active').removeClass('active');
		$(this).addClass('active');
		$('html, body').animate({
			scrollTop : $(this).offset().top - 100
		}, 1000);
	}
});