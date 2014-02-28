$(function(){
  NewForm.init();
  EditForm.init();
  DeleteForm.init();
  Test.init();
});

var NewForm = (function() {
  function bindEvents() {
    $('#new-appointment').on('click', toggleHidden);
    $('.new-appointment-form form').on('ajax:success', addAppointment);
    $('.new-appointment-form form').on('ajax:error', showCreateError);
  }

  function toggleHidden(event) {
    event.preventDefault();
    $('.new-appointment-form').toggleClass('hidden');
  }

  function addAppointment(event, data) {
    $('.appointment-list').html(data);
    $('.new-appointment-form').toggleClass('hidden');
  }

  function showCreateError(event, xhr, status, error) {
    console.log('Create appointment failed ' + error)
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
    $('.appointments-pannel').on('ajax:success', '.delete-appointment', showDeleteMessage);
    $('.appointments-pannel').on('ajax:error', '.delete-appointment', showDeleteError);
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
    $('.appointments-pannel').on('ajax:success', '.show-edit-form', show);
    $('.appointments-pannel').on('ajax:error', '.show-edit-form', showError);

    $('.appointments-pannel').on('ajax:success', '.edit_appointment', replaceWithEdit);
    $('.appointments-pannel').on('ajax:error', '.edit_appointment', showEditError);
  }

  function show(event, data) {
    $(this).parent().html(data);
  }

  function showError(event, xhr, status, error) {
    console.log('Display edit form failed: ' + error)
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

Test = (function() {
  function bindEvents() {
    $('.show-appointments-module').on('ajax:success', show);
    $('.show-appointments-module').on('ajax:error', showError);
  }

  function show(event, data) {
    $('body').html(data)
    NewForm.init();
    EditForm.init();
    DeleteForm.init();
  }

  function showError(event, xhr, status, error) {
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());