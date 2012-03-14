$('#temp').hide();
$("#spinner").hide();

$('#statuses').prepend('<%= escape_javascript(render 'feed') %>')
.fadeIn();

