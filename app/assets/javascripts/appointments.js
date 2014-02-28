$(function(){
  $('#new-appointment').on('click', NewForm.toggleHidden);
  EditForm.init();
});

var NewForm = {
  toggleHidden: function(event) {
    event.preventDefault();
    $('.new-appointment-form').toggleClass('hidden');
  }
}


var EditForm = (function(){

  function toggleHidden(event) {
    event.preventDefault();
    $('.new-appointment-form').toggleClass('hidden');
  }

  function bindEvents() {
    $('.show-edit-form').on('ajax:success', show);
    $('.show-edit-form').on('ajax:error', showError);
    $('.appointment').on('ajax:success', '.edit_appointment', replaceWithEdit)
    $('.appointment').on('ajax:error', '.edit_appointment', showEditError)
  }

  function show(event, data) {
    $(this).parent().html(data);
  }

  function showError(event, xhr, status, error) {
    debugger
  }

  function replaceWithEdit(event, data) {
    $(this).parent().html(data);
  }

  function showEditError(event, xhr, status, error) {
    debugger
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

