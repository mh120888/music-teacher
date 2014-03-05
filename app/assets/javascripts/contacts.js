var Contact = {
  init: function() {
    EditContact.init();
    DeleteContact.init();
    ContactHover.init();
    NewContact.init();
  }
}


var ContactHover = (function() {
  function bindEvents() {
    $('.contact-hover').on('mouseenter', showInfo);
    $('.contact-hover').on('mouseleave', hideInfo);
  }

  function showInfo(event, data) {
    $(this).find('.contact-toggle').show('fast')
  }

  function hideInfo() {
    $(this).find('.contact-toggle').hide('fast')
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init,
    bindEvents: bindEvents
  }
}());

var NewContact = (function() {
  function bindEvents() {
    $('#new_contact').on('ajax:success', addContact);
    $('#new_contact').on('ajax:error', showError);
    $('.new-contact-link').on('click', showForm)
  }

  function showForm() {
    $('.new-contact-form-wrapper').toggle('contact-hidden');
  }

  function addContact(event, data) {
    $('.new-contact-form-wrapper').toggle('contact-hidden');
    $('.contacts-list-append').append(data)
  }

  function showError() {
    cosole.log('Error adding new student')
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var EditContact = (function() {
  function bindEvents() {
    $('.contacts-module').on('ajax:success', 'a.edit-contact', renderEditForm)
    $('.contacts-module').on('ajax:error', 'a.edit-contact', renderEditContactError)
    $('.contacts-module').on('ajax:success', 'form.edit_contact', renderEditedContact);
    $('.contacts-module').on('ajax:error', 'form.edit_contact', renderEditError);
  }

  function renderEditForm(event, data) {
    event.preventDefault();
    $(this).closest('li').html(data);
  }

  function renderEditContactError(event, xhr) {
    alert('Something went wrong with rendering the edit contact form!');
  }

  function renderEditedContact(event, data) {
    $(this).closest('li').html(data);
  }

  function renderEditError(event, xhr) {
    console.log('Something went wrong with rendering the edited contact!');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var DeleteContact = (function() {
  function bindEvents() {
    $('.contacts-module').on('ajax:success', 'a.delete-contact', deleteContact);
    $('.contacts-module').on('ajax:error', 'a.delete-contact', showDeleteContactError);
  }

  function deleteContact(e, data) {
    $(this).closest('li').html(data);
  }

  function showDeleteContactError(e, error) {
    console.log('Something went wrong with deleting the contact!');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

