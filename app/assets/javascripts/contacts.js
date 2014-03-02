$(function() {
  newContact.init();
  editContact.init();
});

var newContact = (function(){
  function bindEvents() {
    $('#new-contact').on('click', toggleHidden);
    $('.new-contact-form form').on('ajax:success', addContact);
    $('.new-contact-form form').on('ajax:error', showContactError);
  }

  function toggleHidden(event) {
    event.preventDefault;
    $('.new-contact-form').toggleClass('hidden');
    $('.contacts-list').css('display', 'none');
  }

  function addContact(e, data) {
    $('.new-contact-form').html(data);
  }

  function showContactError(e, error) {
    $('.new-contact-form .error').html(error)
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var editContact = (function(){
  function bindEvents() {
    $('a.edit-contact').on('ajax:success', renderEditForm)
    $('a.edit-contact').on('ajax:error', renderEditContactError)
    $('body').on('ajax:success', 'form.edit_contact', renderEditedContact);
    $('body').on('ajax:error', 'form.edit_contact', renderEditError);
  }

  function renderEditForm(event, data) {
    $('body').html(data);
  }

  function renderEditContactError(event, xhr) {
    alert('Something Broke');
  }

  function renderEditedContact(event, data) {
    $('body').html(data);
  }

  function renderEditError(event, xhr) {
    alert('Something Broke');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

