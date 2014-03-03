$(function() {
  newContact.init();
  viewContact.init();
  editContact.init();
  deleteContact.init();
});

var newContact = (function(){
  function bindEvents() {
    $('#new-contact a').on('ajax:success', renderNewContactForm);
    $('#new-contact a').on('ajax:error', showContactFormError);
    $('.contacts-module').on('ajax:success', 'form.new_contact', renderContactsIndex);
  }

  function renderNewContactForm(e, data) {
    $('.contacts-module').html(data);
  }

  function showContactFormError(e, error) {
    alert('Something went wrong...sorry!');
  }

  function renderContactsIndex(e, data) {
    $('.contacts-module').html(data);
  }

  function showContactsIndexError(e, error) {
    alert('Something went wrong...sorry!');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var viewContact = (function(){
  function bindEvents() {
    $('.contacts-module').on('ajax:success', '.contacts-list a', showContact);
  }

  function showContact(event, data) {
    $('.contacts-module').html(data);
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
    $('.contacts-module').on('ajax:success', 'a.edit-contact', renderEditForm)
    $('a.edit-contact').on('ajax:error', renderEditContactError)
    $('body').on('ajax:success', 'form.edit_contact', renderEditedContact);
    $('body').on('ajax:error', 'form.edit_contact', renderEditError);
  }

  function renderEditForm(event, data) {
    event.preventDefault();
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

var deleteContact = (function(){
  function bindEvents() {
    $('.contacts-module').on('ajax:success', 'a.delete-contact', deleteContact);
  }

  function deleteContact(e, data) {
    debugger;
  }

  function showDeleteContactError(e, error) {

  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

