//= require jquery2
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require twitter/bootstrap
//= require jquery.timeago
//= require_tree .
//= require_self


$(document).on("turbolinks:load", function() {
   jQuery("time.timeago").timeago();
});
