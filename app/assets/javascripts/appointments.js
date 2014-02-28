$(function(){
  EditForm.init();
  DeleteForm.init();
  NewForm.init();
});

var NewForm = (function() {
  function bindEvents() {
    $('#new-appointment').on('click', toggleHidden);
  }

  function toggleHidden(event) {
    event.preventDefault();
    $('.new-appointment-form').toggleClass('hidden');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());


var DeleteForm = (function() {
  function bindEvents() {
    $('.delete-appointment').on('ajax:success', showDeleteMessage);
    $('.delete-appointment').on('ajax:error', showDeleteError);
  }

  function showDeleteMessage(event, data) {
    $(this).parent().html(data)
  }

  function showDeleteError(event, xhr, status, error) {
    console.log('Delete Appointement failed: ' + error)
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());


var EditForm = (function() {
  function bindEvents() {
    $('.show-edit-form').on('ajax:success', show);
    $('.show-edit-form').on('ajax:error', showDisplayError);

    $('.new-appointment-form form').on('ajax:success', addAppointment);
    $('.new-appointment-form form').on('ajax:error', showCreateError);

    $('.appointment').on('ajax:success', '.edit_appointment', replaceWithEdit);
    $('.appointment').on('ajax:error', '.edit_appointment', showEditError);
  }

  function show(event, data) {
    $(this).parent().html(data);
  }

  function showDisplayError(event, xhr, status, error) {
    console.log('Display edit form failed: ' + error)
  }

  function addAppointment(event, data) {
    $('.appointment-list').html(data);
  }

  function showCreateError(event, xhr, status, error) {
    console.log('Create appointment failed ' + error)
  }

  function replaceWithEdit(event, data) {
    $(this).parent().html(data);
  }

  function showEditError(event, xhr, status, error) {
    console.log('Edit appointment failed: ' + error)
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

