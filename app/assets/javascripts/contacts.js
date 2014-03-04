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
    alert('Something went wrong with showing the add contact form!');
  }

  function renderContactsIndex(e, data) {
    $('.contacts-module').html(data);
  }

  function showContactsIndexError(e, error) {
    alert('Something went wrong with showing the list of contacts!');
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
    $('.contacts-module').on('ajax:error', '.contacts-list a', showViewContactError);
  }

  function showContact(event, data) {
    $('.contacts-module').html(data);
  }

  function showViewContactError(event, error) {
    alert("something went wrong with showing a particular contact!");
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
    $('.contacts-module').on('ajax:error', 'a.edit-contact', renderEditContactError)
    $('.contacts-module').on('ajax:success', 'form.edit_contact', renderEditedContact);
    $('.contacts-module').on('ajax:error', 'form.edit_contact', renderEditError);
  }

  function renderEditForm(event, data) {
    event.preventDefault();
    $('.contacts-module').html(data);
  }

  function renderEditContactError(event, xhr) {
    alert('Something went wrong with rendering the edit contact form!');
  }

  function renderEditedContact(event, data) {
    $('.contacts-module').html(data);
  }

  function renderEditError(event, xhr) {
    alert('Something went wrong with rendering the edited contact!');
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
    $('.contacts-module').on('ajax:error', 'a.delete-contact', showDeleteContactError);
  }

  function deleteContact(e, data) {
    window.location = '/users/' + data + '/contacts'
  }

  function showDeleteContactError(e, error) {
    alert('Something went wrong with deleting the contact!');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

