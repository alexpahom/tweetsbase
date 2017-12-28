// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function(e) {
    $('.timing').hover(function(){
        $old_text = $(this).text();
        $(this).text($(this).attr('data_date'));
    },function() {
        $(this).text($old_text);
    });
});

