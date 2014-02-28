$(function(){
  // $('.nav-toggle').on('click', toggleNav)
});

function toggleNav(event) {
  event.preventDefault();
  $('.nav-toggle-area').slideToggle("fast");
}