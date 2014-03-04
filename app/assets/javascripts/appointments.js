Appointments = {
  init: function() {
    AppointmentForm.init();
    EditForm.init();
    DeleteForm.init();
  }
}

AppointmentForm = (function() {
  function bindEvents() {
    $('.appointments-header-new-form').on('click', toggleHidden);
    $('.new-appointment-form form').on('ajax:success', addAppointment);
    $('.new-appointment-form form').on('ajax:error', showCreateError);
  }

  function toggleHidden(event) {
    event.preventDefault();
    $('.new-appointment-form').toggleClass('appointment-hidden');
  }

  function addAppointment(event, data) {
    $('.appointment-list').html(data);
    $('.new-appointment-form').toggleClass('appointment-hidden');
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
    $(this).closest('.appointment').html(data)
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
    $(this).closest('.appointment').html(data)
  }

  function showError(event, xhr, status, error) {
    console.log('Display edit form failed: ' + error)
  }

  function replaceWithEdit(event, data) {
    $(this).closest('.appointment').replaceWith(data)
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